import Foundation
import Yams
import PathKit
import Commander
import XcodeProj
import Crayon

// MARK: - Migration

public class MigrationController {

    public var mockfileExists: Bool { return mockfile.existis }

    private let root: Path
    private var project: XcodeProj
    private let mockfile: MockfileInteractor
    private let generate: GenerationController

    // MARK: - Lifecycle

    public init(project name: Path, at root: Path) throws {
        self.root = root

        let path = try ProjectPathOption.select(project: name, at: root)
        project = try XcodeProj(path: path)
        mockfile = try MockfileInteractor(path: root + "Mockfile")
        generate = GenerationController(root: root, mockfile: mockfile.mockfile)
    }

    public init(project: XcodeProj, at root: Path) throws {
        self.root = root
        self.project = project
        self.mockfile = try MockfileInteractor(path: root + "Mockfile")
        self.generate = GenerationController(root: root, mockfile: mockfile.mockfile)
    }

    // MARK: - Actions

    public func save() throws {
        Message.just("Saving Mockfile™...")
        try mockfile.save()
        Message.success("Mockfile™ saved.")
    }

    public func migrationPossible() -> Bool {
        return (try? root.children().contains { LegacyConfiguration(path: $0) != nil }) ?? false
    }

    public func migrate() throws {
        guard migrationPossible() else { return }

        Message.list()
        Message.header("Migrating existing configuration to a new Mockfile™ at \'\(root)/Mockfile\'")

        let configurations: [(LegacyConfiguration, String)] = try root
        .children()
        .compactMap { path in
            guard let config = LegacyConfiguration(path: path) else { return nil }
            return (config: config, name: path.lastComponentWithoutExtension)
        }

        Message.infoPoint("Found \(configurations.count) existing configuration files")

        configurations.forEach { (config, name) in
            var mock = MockConfiguration(config: config)
            mock.targets = project.targets(for: Path(mock.output))
            // File pointing path
            mock.output = {
                if mock.output.hasSuffix(".swift") {
                    return mock.output
                } else {
                    return (Path(mock.output) + "Mock.generated.swift").string
                }
            }()
            // Should contain relative or absolute path
            mock.output = {
                if mock.output.hasPrefix("/") || mock.output.hasPrefix(".") {
                    return mock.output
                } else {
                    return "./\(mock.output)"
                }
            }()
            mockfile.add(mock: mock, for: name)
        }

        try mockfile.save()

        Message.empty()
        Message.success("Migration completed! 🎉")

        // Ask for removing old configuration files
        Message.empty()
        Message.warning("Do you want to remove old configurations?")

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
            return source == outputFile
        }) ?? false
    }
}
