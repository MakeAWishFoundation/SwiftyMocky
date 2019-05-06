import Foundation
import Yams
import PathKit
import Commander
import xcodeproj

// MARK: - Temporary directory

class Temp {

    var tempDirectory: Path { return root + Path(".mocky") }
    var tempConfig: Path { return root + Path(".mocky/.config.yml.tmp") }

    private let root: Path

    init(root: Path) {
        self.root = root
    }

    func createDirIfNeeded() throws {
        guard !tempDirectory.exists else { return }
        try tempDirectory.mkdir()
    }

    func create(config: LegacyConfiguration, output: String? = nil) throws {
        let includes = config.sources.include.map { ".\($0)" }
        let excludes = config.sources.exclude?.map { ".\($0)" }
        let templates = config.templates
        let updatedConfig = LegacyConfiguration(
            sources: Mock.Sources(
                include: includes,
                exclude: excludes
            ),
            templates: templates,
            output: output ?? ("." + config.output),
            args: config.args
        )
        try? tempConfig.delete()
        let yaml: String = try YAMLEncoder().encode(updatedConfig)
        try tempConfig.write(yaml)
    }

    func cleanup() throws {
        try? tempDirectory.delete()
        try? tempConfig.delete()
    }
}

// MARK: - Mock configuration

struct Mock: Codable {
    var sources: Sources
    var output: String
    var testable: [String]
    var `import`: [String]
}

extension Mock {
    init(config: LegacyConfiguration) {
        self.sources = config.sources.sorted()
        self.output = config.output
        self.testable = (config.args?.testable ?? config.args?.swiftyMocky?.testable ?? []).sorted()
        self.import = (config.args?.import ?? config.args?.swiftyMocky?.import ?? []).sorted()
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

// MARK: - Legacy

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
