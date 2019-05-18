import Foundation
import PathKit
import Yams

// MARK: - Temporary directory

class WorkingDirectory {

    var path: Path { return root + Path(".mocky") }
    var template: Path { return root + Path(".mocky/.template.swifttemplate") }
    var config: Path { return root + Path(".mocky/.config.yml.tmp") }

    private let root: Path

    init(root: Path) {
        self.root = root
    }

    func createDirIfNeeded() throws {
        guard !path.exists else { return }
        try path.mkdir()
    }

    func create(config: LegacyConfiguration, output: String? = nil) throws {
        let includes = config.sources.include.map { ".\($0)" }
        let excludes = config.sources.exclude?.map { ".\($0)" }
        let templates = config.templates
        let updatedConfig = LegacyConfiguration(
            sources: MockConfiguration.Sources(
                include: includes,
                exclude: excludes
            ),
            templates: templates,
            output: output ?? ("." + config.output),
            args: config.args
        )
        try? self.config.delete()
        let yaml: String = try YAMLEncoder().encode(updatedConfig)
        try self.config.write(yaml)
    }

    func cleanup() throws {
        try? config.delete()
        try? template.delete()
        try? path.delete()
    }
}
