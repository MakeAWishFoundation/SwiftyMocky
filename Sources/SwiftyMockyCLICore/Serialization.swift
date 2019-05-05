import Foundation
import Yams
import PathKit
import Commander
import xcodeproj

public class VerifyConfigCommand {
    init(config: Path) {

    }
}

public class ReadSourceryConfigurationCommand {

    let config: Path

    public init(config: Path) {
        self.config = config
    }

    public func run() throws {
        let yaml = try String(contentsOfFile: config.absolute().string)
        print(yaml)
        let configuration: LegacyConfiguration = try YAMLDecoder().decode(from: yaml)
        print(configuration)
    }
}

public class ProjectSetup {

    private let project: XcodeProj
    private let path: Path
    public var encoding: String.Encoding = .utf8

    public init(project input: Path, at root: Path) throws {
        if input.string.isEmpty {
            let projectsPaths = root.glob("*.xcodeproj")
            guard let projectPath = projectsPaths.first else { throw Error.projectNotFound }
            guard projectsPaths.count == 1 else { throw Error.multipleProjects }

            print("Found project at \(projectPath)")
            path = projectPath
        } else {
            if input.string.hasSuffix("/") {
                path = root + Path(String(input.string.dropLast()))
            } else {
                path = root + input
            }
        }
        project = try XcodeProj(path: path)
    }

    public enum Error: Swift.Error {
        case targetNotFound
        case projectNotFound
        case multipleProjects
        case internalFailure
        case writingError
    }

    public func findTestTargets() throws -> [PBXTarget] {
        print("Scanning project...")
        let testTargets = project.pbxproj.allUnitTestTargets
        guard !testTargets.isEmpty else {
            throw Error.targetNotFound
        }

        return testTargets
    }

    public func selected(target: PBXTarget) throws {
        print("Selected: \(target.name)")
        target.dependencies.forEach { print("    \($0.name ?? "?")") }
    }
}

public class TestCommand {

    let root: Path

    public init(root: Path) {
        self.root = root
    }

    public func run() throws {
        let configuration = Mockfile(
            sourceryCommand: "mint run krzysztofzablocki/Sourcery@0.16.1 sourcery",
            contents: [
                "iOS": Mock(
                    sources: Mock.Sources(
                        include: [
                            "./SwiftyMocky-Example/Shared",
                            "./SwiftyMocky-Example/iOS",
                            "./SwiftyMocky-Tests/iOS",
                        ],
                        exclude: [
                            "./SwiftyMocky-Example/Shared/Other/Excluded.generated.swift"
                        ]
                    ),
                    output: "./SwiftyMocky-Tests/iOS/Mocks",
                    testable: [
                        "Mocky_Example_iOS"
                    ],
                    imports: [
                        // None
                    ]
                )
            ]
        )

        let yaml = try YAMLEncoder().encode(configuration)
        print(yaml)

        let mockfile = root + Path("Mockfile")
        try mockfile.write(yaml)

        let readYaml: String = try mockfile.read()
        let readConfig: Mockfile = try YAMLDecoder().decode(from: readYaml)

        print(readConfig)
    }
}

// MARK: - Mockfile Configuration

@dynamicMemberLookup
struct Mockfile: Codable {

    var sourceryCommand: String
    var allMocks: [Mock] { return contents.values.map { $0 } }
    var allMembers: [String] { return contents.keys.map { $0 } }

    private var contents: [String: Mock]

    init(sourceryCommand: String, contents: [String: Mock]) {
        self.sourceryCommand = sourceryCommand
        self.contents = contents
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        sourceryCommand = try container.decode(.sourceryCommand)
        contents = [:]

        container.allKeys.forEach { key in
            guard let mock = try? container.decode(Mock.self, forKey: key) else {
                return
            }

            contents[key.stringValue] = mock
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(sourceryCommand, forKey: .sourceryCommand)
        try allMembers.forEach { mock in
            try container.encode(self[dynamicMember: mock], forKey: .mock(named: mock))
        }
    }

    subscript(dynamicMember member: String) -> Mock? { return contents[member] }
}

extension Mockfile {

    enum CodingKeys: CodingKey {

        case sourceryCommand
        case mock(named: String)

        var stringValue: String {
            switch self {
            case .sourceryCommand: return "sourceryCommand"
            case .mock(named: let name): return name
            }
        }
        var intValue: Int? { return nil }

        init?(stringValue: String) {
            switch stringValue {
            case CodingKeys.sourceryCommand.stringValue:
                self = .sourceryCommand
            default:
                self = .mock(named: stringValue)
            }
        }

        init?(intValue: Int) {
            return nil
        }
    }
}

// MARK: - Mock configuration

struct Mock: Codable {
    var sources: Sources
    var output: String
    var testable: [String]
    var imports: [String]

    struct Sources: Codable {
        var include: [String]
        var exclude: [String]?
    }
}

// MARK: - Legacy

/// Sourcery configuration - yaml file
struct LegacyConfiguration: Codable {

    var sources: Mock.Sources
    var templates: [String]
    var output: String
    var args: Arguments?
}

extension LegacyConfiguration {

    struct Arguments: Codable {
        var swiftyMocky: Configuration?

        // Legacy from very old version of swifty mocky, needs for migration
        var `import`: [String]?
        var testable: [String]?
    }

    struct Configuration: Codable {
        var imports: [String]?
        var testable: [String]?
    }
}

// MARK: - Helpers

extension KeyedDecodingContainer where K : CodingKey {
    func decode<T: Decodable>(_ key: K) throws -> T {
        return try decode(T.self, forKey: key)
    }
}

extension PBXProj {

    var allTargets: [PBXTarget] {
        var all = [PBXTarget]()
        all.append(contentsOf: nativeTargets)
        all.append(contentsOf: legacyTargets)
        all.append(contentsOf: aggregateTargets)
        return all
    }
    var allUnitTestTargets: [PBXTarget] {
        return allTargets.filter { $0.productType == .unitTestBundle }
    }
    var allUITestTargets: [PBXTarget] {
        return allTargets.filter { $0.productType == .uiTestBundle }
    }
}
