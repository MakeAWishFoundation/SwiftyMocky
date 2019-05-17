import Foundation
import Yams
import PathKit
import Commander
import xcodeproj

// MARK: - Mock configuration

struct Mock {
    var sources: Sources
    var output: String
    var targets: [String]
    var testable: [String]
    var `import`: [String]
}

// MARK: - Codable

extension Mock: Codable {
    enum CodingKeys: String, CodingKey {
        case sources
        case output
        case targets
        case testable
        case `import` = "import"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        sources = try container.decode(.sources)
        output = try container.decode(.output)
        targets = (try? container.decode([String].self, forKey: .targets)) ?? []
        testable = (try? container.decode([String].self, forKey: .testable)) ?? []
        `import` = (try? container.decode([String].self, forKey: .import)) ?? []
    }
}

// MARK: - Mock config and Sources

extension Mock {

    init(config: LegacyConfiguration) {
        self.sources = config.sources.sorted()
        self.output = config.output
        self.testable = (config.args?.testable ?? config.args?.swiftyMocky?.testable ?? []).sorted()
        self.import = (config.args?.import ?? config.args?.swiftyMocky?.import ?? []).sorted()
        self.targets = [] // TODO: Resolve targets
    }

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

    struct Sources: Codable {
        var include: [String]
        var exclude: [String]?

        func sorted() -> Sources {
            return Sources(include: include.sorted(), exclude: exclude?.sorted())
        }
    }
}

// MARK: - Legacy configuration

/// Sourcery configuration - yaml file
struct LegacyConfiguration: Codable {

    var sources: Mock.Sources
    var templates: [String]
    var output: String
    var args: Arguments?
}

extension LegacyConfiguration {

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
