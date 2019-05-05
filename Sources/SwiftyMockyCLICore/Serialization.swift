import Foundation
import Yams
import PathKit
import Commander
import xcodeproj
import Crayon

public var defaultSourceryCommand = "mint run krzysztofzablocki/Sourcery@0.16.1 sourcery"

public class VerifyConfigCommand {
    init(config: Path) {

    }
}

public class TestCommand {

    let root: Path

    public init(root: Path) {
        self.root = root
    }

    public func run() throws {
        let configuration = Mockfile(
            sourceryCommand: nil,
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
                    import: [
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

// MARK: - Mockfile Configuration

@dynamicMemberLookup
struct Mockfile: Codable {

    var sourceryCommand: String?
    var allMocks: [Mock] { return contents.values.map { $0 } }
    var allMembers: [String] { return contents.keys.map { $0 } }

    private var contents: [String: Mock]

    init(sourceryCommand: String?, contents: [String: Mock]) {
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

    subscript(dynamicMember member: String) -> Mock? {
        get { return contents[member] }
        set {
            guard let newValue = newValue else {
                contents.removeValue(forKey: member); return
            }
            contents[member] = newValue
        }
    }
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
    var `import`: [String]

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

extension PBXTarget {

    /// Local path (relative to project root) for info plist file
    ///
    /// - Returns: Project root relative Info.plist path
    func infoPlistPath() -> Path? {
        guard let config = buildConfigurationList?.buildConfigurations.first else {
            return nil
        }
        guard let path = config.buildSettings["INFOPLIST_FILE"] as? String else {
            return nil
        }

        return Path(path)
    }

    /// Local path (relative to project root) for directory enclosing info plist file
    ///
    /// - Returns: Project root relative Info.plist enclosing directory path
    func infoPlistEnclosingDirectory() -> Path? {
        guard let path = infoPlistPath() else { return nil }
        return Path(components: path.components.dropLast())
    }

    func commonSourcesEnclosingFolder() -> Path? {
        guard let sources = try? sourceFiles() else { return nil }

        let paths = sources.compactMap { file -> Path? in
            return file.relativePath()
        }

        return paths.commonPrefix()
    }

    func defaultSourcesFolder() -> Path {
        guard let path = commonSourcesEnclosingFolder() else { return Path(".") }
        return path
    }
}

extension PBXFileElement {
    func relativePath() -> Path? {
        guard let path = self.path else { return nil }

        if let parentPath = self.parent?.relativePath() {
            return parentPath + Path(path)
        } else {
            return Path(path)
        }
    }
}

extension Array where Element == Path {
    func commonPrefix() -> Path? {
        guard let first = self.first else { return nil }

        return self.reduce(first, { (result, current) -> Path in
            return result.commonPrefix(with: current)
        })
    }
}

extension Path {
    func commonPrefix(with other: Path) -> Path {
        var common = [String]()
        var lhs = self.components
        var rhs = other.components

        while !lhs.isEmpty, !rhs.isEmpty, rhs.first == lhs.first {
            common.append(lhs.first!)
            lhs.removeFirst()
            rhs.removeFirst()
        }

        return Path(components: common)
    }
}
