import Foundation
import Yams
import PathKit
import Commander
import XcodeProj
import Crayon

// MARK: - Project Setup

var defaultOutputName: Path { return Path("Mock.generated.swift") }

public class ProjectSetupController {

    public var mockfileExists: Bool { return mockfile.existis }
    public let project: XcodeProj
    
    private let path: Path
    private let root: Path
    private let mockfile: MockfileInteractor
    private let generate: GenerationController
    private var policy: AddingPolicy = .addOnly

    // MARK: - Lifecycle

    public init(project name: Path, at root: Path) throws {
        self.root = root

        path = try ProjectPathOption.select(project: name, at: root)
        project = try XcodeProj(path: path)
        mockfile = try MockfileInteractor(path: root + "Mockfile")
        generate = GenerationController(root: root, mockfile: mockfile.mockfile)
    }

    // MARK: - Actions

    public func initializeAsANewMockfile() throws {
        Message.list()
        Message.header("Initializing new Mockfile™ at \(root)")

        let targets = try findTestTargets()
        Message.success("Found \(targets.count) unit test bundles:")
        Message.indent()

        targets
        .map { (name: $0.name, mockName: mockfile.firstMockFor(target: $0)) }
        .enumerated()
        .forEach {
            let exists = $1.mockName != nil
            let prefix = "\(exists ? "❕":"☑️ ") \($0 + 1))"
            let infix = "\(crayon.bold.on($1.name))"
            let suffix = exists ? " - already defined in \'\($1.mockName!)\'" : ""
            Message.just("\(prefix) \(infix) \(suffix)")
        }

        Message.unindent()

        guard !targets.isEmpty else {
            throw MockyError.targetNotFound
        }

        // Check if any further action needed
        let needsOverride = targets.contains(where: { mockfile.isSetup(target: $0) })
        let needsAddNewMock = targets.contains(where: { !mockfile.isSetup(target: $0) })

        // Read user action if needed
        switch (needsOverride, needsAddNewMock) {
        case (true, true):
            var options = (1...targets.count).map { AddingOption.only($0) }
            options.append(contentsOf: [
                .add,
                .override,
                .cancel
            ])
            policy = AddingOption.select(from: options).policy
        case (true, false):
            var options = (1...targets.count).map { AddingOption.only($0) }
            options.append(contentsOf: [
                .override,
                .cancel
                ])
            policy = AddingOption.select(from: options).policy
        default:
            break
        }

        // Cancel if needed
        if case .cancel = policy {
            return
        }

        // This will create new configurations or override existing
        try initializeBasedOnPolicy()
        try save()
    }

    public func initializeBasedOnPolicy() throws {
        let targets = try findTestTargets()
        try targets.enumerated().forEach { offset, target in
            let exists = mockfile.isSetup(target: target)
            switch (policy, exists) {
            case (.override, _):
                try initializeMock(for: target, force: true)
            case (.skipOverriding, true):
                return
            case (.onlyOverride(let index), _):
                if (offset + 1) == index {
                    try initializeMock(for: target, force: true)
                }
            default:
                try initializeMock(for: target)
            }
        }
    }

    public func initializeMock(for target: PBXTarget, force: Bool = false) throws {
        if mockfile.isSetup(target: target) {
            Message.actionHeader("\(target.name) - overriding Mock configuration...")
        } else {
            Message.actionHeader("\(target.name) - adding Mock configuration...")
        }

        Message.infoPoint("Targets set to: \(crayon.bold.on(target.name))")

        let output = "./" + defaultOutput(for: target).string
        Message.infoPoint("Default output set to: \(crayon.bold.on(output))")

        let sources = "./" + defaultSources(for: target).string
        Message.infoPoint("Default sources directory: \(crayon.bold.on(sources))")

        let testable = defaultTestable(for: target)
        Message.infoPoint("Default testable module: \(crayon.bold.on(testable.joined(separator: ",")))")

        let imports = defaultImports(for: target)
        Message.infoPoint("Default testable module: \(crayon.bold.on(imports.joined(separator: ",")))")

        guard force || !mockfile.isSetup(target: target) else {
            throw MockyError.overrideWarning
        }

        var config = MockConfiguration(
            sources: MockConfiguration.Sources(
                include: [sources].sorted(),
                exclude: nil
            ),
            output: output,
            targets: [target.name],
            testable: testable.sorted(),
            import: imports.sorted(),
            prototype: false,
            sourcery: []
        )
        try generate.updateImports(into: &config)

        mockfile.add(mock: config, for: target.name)
    }

    public func save() throws {
        Message.just("Saving mockfile...")
        try mockfile.save()
        Message.success("Mockfile™ saved.")
    }

    // MARK: - Helpers

    private func findTestTargets() throws -> [PBXTarget] {
        let testTargets = project.pbxproj.allUnitTestTargets
        guard !testTargets.isEmpty else {
            throw MockyError.targetNotFound
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

}
