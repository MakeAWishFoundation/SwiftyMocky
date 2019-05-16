import Foundation
import Yams
import PathKit
import Commander
import xcodeproj

// MARK: - Temporary directory

class WorkingDirectory {

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
