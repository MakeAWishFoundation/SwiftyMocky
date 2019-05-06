import Foundation
import Yams
import PathKit
import Commander
import xcodeproj
import Crayon

enum AddingPolicy {
    case addOnly
    case cancel
    case override
    case skipOverriding
}

enum AddingOption: String {
    case add
    case cancel
    case override

    var title: String {
        switch self {
        case .add:
            return crayon.underline.on("A") + "dd missing"
        case .cancel:
            return crayon.underline.on("C") + "ancel"
        case .override:
            return crayon.underline.on("O") + "verride"
        }
    }

    var policy: AddingPolicy {
        switch self {
        case .add: return .skipOverriding
        case .cancel: return .cancel
        case .override: return .override
        }
    }

    init?(rawValue: String) {
        switch rawValue {
        case "A", "a", "Add", "add":
            self = .add
        case "C", "c", "Cancel", "cancel":
            self = .cancel
        case "O", "o", "Override", "override":
            self = .override
        default:
            return nil
        }
    }

    static func select(from options: [AddingOption]) -> AddingOption {
        let optionsString = options.map { $0.title }.joined(separator: ", ")
        let message = "Please choose one of possible actions: (\(optionsString))"

        var option: AddingOption?
        repeat {
            print(message)
            option = AddingOption(rawValue: readLine() ?? "")
        } while option == nil
        return option!
    }
}

public class ProjectSetup {

    var defaultOutputName: Path { return Path("Mock.generated.swift") }

    public var mockfileExists: Bool { return mockfile.existis }

    private let project: XcodeProj
    private let path: Path
    private let root: Path
    private let mockfile: MockfileSetup
    private var policy: AddingPolicy = .addOnly

    // MARK: - Lifecycle

    public init(project name: Path, at root: Path) throws {
        self.root = root

        if name.string.isEmpty {
            let projectsPaths = root.glob("*.xcodeproj")
            guard let projectPath = projectsPaths.first else { throw Error.projectNotFound }
            guard projectsPaths.count == 1 else { throw Error.multipleProjects }

            print("Found project at \(projectPath)")
            path = projectPath
        } else {
            if name.string.hasSuffix("/") {
                path = root + Path(String(name.string.dropLast()))
            } else {
                path = root + name
            }
        }

        project = try XcodeProj(path: path)
        mockfile = try MockfileSetup(path: root + "Mockfile")
    }

    // MARK: - Actions

    public func initializeAsANewMockfile() throws {
        print("Initializing new Mockfile at \(root)")
        let targets = try findTestTargets()
        print("✅ Found \(targets.count) unit test bundles:")

        let targetsOverview = targets
            .map { (name: $0.name, exists: mockfile.isSetup(target: $0)) }
            .enumerated()
            .map {
                let prefix = "\($1.exists ? "❕":"☑️ ") \($0 + 1))"
                let infix = "\(crayon.bold.on($1.name))"
                let suffix = "\($1.exists ? " - already defined" : "")"
                return "\(prefix) \(infix) \(suffix)"
            }
            .joined(separator: "\n")
        print(targetsOverview)

        guard !targets.isEmpty else {
            throw Error.targetNotFound
        }

        // Check if any further action needed
        let needsOverride = targets.contains(where: { mockfile.isSetup(target: $0) })
        let needsAddNewMock = targets.contains(where: { !mockfile.isSetup(target: $0) })

        // Read user action if needed
        switch (needsOverride, needsAddNewMock) {
        case (true, true):
            policy = AddingOption.select(from: [
                .add,
                .override,
                .cancel
            ]).policy
        case (true, false):
            policy = AddingOption.select(from: [
                .override,
                .cancel
            ]).policy
        default:
            break
        }

        // Cancel if needed
        guard policy != .cancel else {
            return
        }

        // This will create new configurations
        try overrideMockConfigurations()
        try save()
    }

    public func overrideMockConfigurations() throws {
        let targets = try findTestTargets()
        try targets.forEach { target in
            let exists = mockfile.isSetup(target: target)
            switch (policy, exists) {
            case (.override, _):
                try initializeMock(for: target, force: true)
            case (.skipOverriding, true):
                return
            default:
                try initializeMock(for: target)
            }
        }
    }

    public func initializeMock(for target: PBXTarget, force: Bool = false) throws {
        if mockfile.isSetup(target: target) {
            print("\(crayon.bold.on(target.name)) - overriding Mock configuration...")
        } else {
            print("\(crayon.bold.on(target.name)) - adding Mock configuration...")
        }

        let output = "./" + defaultOutput(for: target).string
        print(" -> Default output set to: \(crayon.bold.on(output))")

        let sources = "./" + defaultSources(for: target).string
        print(" -> Default sources directory: \(crayon.bold.on(sources))")

        let testable = defaultTestable(for: target)
        print(" -> Default testable module: \(crayon.bold.on(testable.joined(separator: ",")))")

        let imports = defaultImports(for: target)
        print(" -> Default testable module: \(crayon.bold.on(imports.joined(separator: ",")))")

        guard force || !mockfile.isSetup(target: target) else {
            throw Error.overrideWarning
        }

        let config = Mock(
            sources: Mock.Sources(
                include: [sources],
                exclude: nil
            ),
            output: output,
            testable: testable,
            import: imports
        )

        mockfile.add(mock: config, for: target.name)
    }

    public func save() throws {
        print("Saving mockfile...")
        try mockfile.save()
        print("✅ Mockfile saved.")
    }

    // MARK: - Helpers

    private func findTestTargets() throws -> [PBXTarget] {
        let testTargets = project.pbxproj.allUnitTestTargets
        guard !testTargets.isEmpty else {
            throw Error.targetNotFound
        }

        return testTargets
    }

    private func defaultOutput(for target: PBXTarget) -> Path {
        guard let path = target.infoPlistEnclosingDirectory() else {
            return Path(".") + defaultOutputName
        }

        return path + defaultOutputName
    }

    private func defaultSources(for target: PBXTarget) -> Path {
        guard let dependency = target.dependencies.first?.target else {
            return Path(".")
        }

        return dependency.defaultSourcesFolder()
    }

    private func defaultImports(for target: PBXTarget) -> [String] {
        // TODO: Run sourcery to auto-resolve mockable types
        return ["Foundation"]
    }

    private func defaultTestable(for target: PBXTarget) -> [String] {
        return target.dependencies.compactMap { $0.target?.name }
    }

    // MARK: - Defines

    public enum Error: Swift.Error {
        case targetNotFound
        case projectNotFound
        case multipleProjects
        case internalFailure
        case writingError
        case overrideWarning
    }
}

class MockfileSetup {

    var mockfile: Mockfile
    let path: Path
    let existis: Bool

    init(path: Path) throws {
        self.path = path

        if let yaml: String = try? path.read() {
            mockfile = try YAMLDecoder().decode(from: yaml)
            existis = true
        } else {
            mockfile = Mockfile(sourceryCommand: nil, contents: [:])
            existis = false
        }
    }

    init(path: Path, mockfile: Mockfile) {
        self.path = path
        self.mockfile = mockfile
        self.existis = true
    }

    func save() throws {
        try path.write(try YAMLEncoder().encode(mockfile))
    }

    func isSetup(target: PBXTarget) -> Bool {
        return mockfile.allMembers.contains(target.name)
    }

    func add(mock: Mock, for name: String) {
        mockfile[dynamicMember: name] = mock
    }

    func remove(for name: String) {
        mockfile[dynamicMember: name] = nil
    }
}
