import Foundation
import Yams
import PathKit
import Commander

// MARK: - Legacy configuration

/// Sourcery configuration - yaml file
public struct LegacyConfiguration: Codable {

    public var sources: MockConfiguration.Sources
    public var templates: [String]
    public var output: String
    public var args: Arguments?
}

public extension LegacyConfiguration {

    init?(path: Path) {
        guard let contents: String = try? path.read() else {
            return nil
        }
        guard let config: LegacyConfiguration = try? YAMLDecoder().decode(from: contents) else {
            return nil
        }

        self = config
    }
}

public extension LegacyConfiguration {

    struct Arguments: Codable {
        public var swiftyMocky: Configuration?

        // Legacy from very old version of swifty mocky, needs for migration
        public var `import`: [String]?
        public var testable: [String]?
    }

    struct Configuration: Codable {
        public var `import`: [String]?
        public var testable: [String]?
    }
}
