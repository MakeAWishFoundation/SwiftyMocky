import Foundation
import Yams
import PathKit
import Commander

// MARK: - Mockfile

@dynamicMemberLookup
public struct Mockfile: Codable {

    var sourceryCommand: String?
    var allMocks: [MockConfiguration] { return contents.values.map { $0 } }
    var allMembers: [String] { return contents.keys.map { $0 } }

    private var contents: [String: MockConfiguration]

    // MARK: - Lifecycle

    public init(sourceryCommand: String?, contents: [String: MockConfiguration]) {
        self.sourceryCommand = sourceryCommand
        self.contents = contents
    }

    public init(path: Path) throws {
        let yaml: String = try path.read()
        self = try YAMLDecoder().decode(from: yaml)
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        sourceryCommand = try container.decode(.sourceryCommand)
        contents = [:]

        container.allKeys.forEach { key in
            guard let mock = try? container.decode(MockConfiguration.self, forKey: key) else {
                return
            }

            contents[key.stringValue] = mock
        }
    }

    // MARK: - Dynamic lookup

    subscript(dynamicMember member: String) -> MockConfiguration? {
        get { return contents[member] }
        set {
            guard let newValue = newValue else {
                contents.removeValue(forKey: member); return
            }
            contents[member] = newValue
        }
    }

    // MARK: - Coding

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(sourceryCommand, forKey: .sourceryCommand)
        try allMembers.sorted().forEach { key in
            try container.encode(self[dynamicMember: key], forKey: .mock(named: key))
        }
    }

    public enum CodingKeys: CodingKey {

        case sourceryCommand
        case mock(named: String)

        public var stringValue: String {
            switch self {
            case .sourceryCommand: return "sourceryCommand"
            case .mock(named: let name): return name
            }
        }
        public var intValue: Int? { return nil }

        public init?(stringValue: String) {
            switch stringValue {
            case CodingKeys.sourceryCommand.stringValue:
                self = .sourceryCommand
            default:
                self = .mock(named: stringValue)
            }
        }

        public init?(intValue: Int) {
            return nil
        }
    }
}

// MARK: - Helpers

extension KeyedDecodingContainer where K : CodingKey {
    func decode<T: Decodable>(_ key: K) throws -> T {
        return try decode(T.self, forKey: key)
    }
}
