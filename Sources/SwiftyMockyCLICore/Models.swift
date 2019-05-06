import Foundation
import Yams
import PathKit
import Commander
import xcodeproj
import Crayon

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

    init(path: Path) throws {
        let yaml: String = try path.read()
        self = try YAMLDecoder().decode(from: yaml)
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
        try allMembers.sorted().forEach { key in
            try container.encode(self[dynamicMember: key], forKey: .mock(named: key))
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

extension Mock {
    func configuration(template: Path) -> LegacyConfiguration {
        return LegacyConfiguration(
            sources: sources,
            templates: [template.string],
            output: output,
            args: LegacyConfiguration.Arguments(
                swiftyMocky: LegacyConfiguration.Configuration(
                    import: `import`,
                    testable: testable
                ),
                import: nil,
                testable: nil
            )
        )
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
        var `import`: [String]?
        var testable: [String]?
    }
}

// MARK: - Helpers

extension KeyedDecodingContainer where K : CodingKey {
    func decode<T: Decodable>(_ key: K) throws -> T {
        return try decode(T.self, forKey: key)
    }
}
