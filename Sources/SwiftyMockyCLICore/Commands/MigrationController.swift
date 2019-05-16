import Foundation
import Yams
import PathKit
import Commander
import xcodeproj
import Crayon

// MARK: - Migration

public class MigrationController {

    public var mockfileExists: Bool { return mockfile.existis }

    private let root: Path
    private var project: XcodeProj
    private let mockfile: MockfileSetup
    private let generate: GenerationController

    // MARK: - Lifecycle

    public init(root: Path, projectName name: Path = "") throws {
        self.root = root

        let path = try ProjectPathOption.select(project: name, at: root)
        project = try XcodeProj(path: path)
        mockfile = try MockfileSetup(path: root + "Mockfile")
        generate = GenerationController(root: root, mockfile: mockfile.mockfile, project: project)
    }

    public init(root: Path, project: XcodeProj) throws {
        self.root = root
        self.project = project
        self.mockfile = try MockfileSetup(path: root + "Mockfile")
        self.generate = GenerationController(root: root, mockfile: mockfile.mockfile, project: project)
    }

    // MARK: - Actions

    public func save() throws {
        print("Saving mockfile...")
        try mockfile.save()
        print("✅ Mockfile saved.")
    }

    public func migrationPossible() -> Bool {
        return (try? root.children().contains { LegacyConfiguration(path: $0) != nil }) ?? false
    }

    public func migrate() throws {
        guard migrationPossible() else { return }

        print("Migrating existing configuration to a new Mockfile at \(root)")

        let configurations: [(LegacyConfiguration, String)] = try root
            .children()
            .compactMap { path in
                guard let config = LegacyConfiguration(path: path) else { return nil }
                return (config: config, name: path.lastComponentWithoutExtension)
        }

        print("Found \(configurations.count) existing configuration files")

        configurations.forEach { (config, name) in
            var mock = Mock(config: config)
            mock.targets = project.targets(for: Path(mock.output))
            // find targets
            mockfile.add(mock: mock, for: name)
        }

        try mockfile.save()
        print("\n✅  🎉  " + crayon.bold.on("Migration completed!"))

        // Ask for removing old configuration files
        print("\n⚠️  " + crayon.bold.on("Do you want to remove old configurations?"))
        switch BoolOption.select() {
        case .yes: try removeLegacyConfigurations()
        case .no: break
        }
    }

    // MARK: - Helpers

    private func removeLegacyConfigurations() throws {
        try root.children().filter { LegacyConfiguration(path: $0) != nil }.forEach {
            try $0.delete()
        }
    }
}

private extension XcodeProj {
    func targets(for file: Path) -> [String] {
        return pbxproj.allUnitTestTargets
            .filter { $0.contains(file) }
            .map { $0.name }
    }
}

private extension PBXTarget {
    func contains(_ file: Path) -> Bool {
        let outputFile = file.string.hasSuffix(".swift") ? file : file + defaultOutputName

        return (try? sourceFiles().contains { element in
            guard let source = try element.fullPath(sourceRoot: Path("")) else { return false }
            if source == outputFile {
                print(crayon.green.bold.on("FOUND: \(outputFile)"))
            } else {
                print(crayon.red.on(" \(source) =/= \(outputFile)"))
            }
            return source == outputFile
        }) ?? false
    }
}
