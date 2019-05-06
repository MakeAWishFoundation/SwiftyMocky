import Foundation
import Yams
import PathKit
import Commander
import xcodeproj

// MARK: - Mockfile Setup

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

// MARK: - Mockfile

@dynamicMemberLookup
struct Mockfile: Codable {

    var sourceryCommand: String?
    var allMocks: [Mock] { return contents.values.map { $0 } }
    var allMembers: [String] { return contents.keys.map { $0 } }

    private var contents: [String: Mock]

    // MARK: - Lifecycle

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

    // MARK: - Dynamic lookup

    subscript(dynamicMember member: String) -> Mock? {
        get { return contents[member] }
        set {
            guard let newValue = newValue else {
                contents.removeValue(forKey: member); return
            }
            contents[member] = newValue
        }
    }

    // MARK: - Coding

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(sourceryCommand, forKey: .sourceryCommand)
        try allMembers.sorted().forEach { key in
            try container.encode(self[dynamicMember: key], forKey: .mock(named: key))
        }
    }

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

// MARK: - Helpers

extension KeyedDecodingContainer where K : CodingKey {
    func decode<T: Decodable>(_ key: K) throws -> T {
        return try decode(T.self, forKey: key)
    }
}
