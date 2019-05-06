import Foundation
import Yams
import PathKit
import Commander
import xcodeproj
import Crayon

// MARK: - Migration

public class MigrationCommand {

    public var mockfileExists: Bool { return mockfile.existis }

    private let root: Path
    private let mockfile: MockfileSetup
    private let generate: GenerateCommand

    // MARK: - Lifecycle

    public init(root: Path) throws {
        self.root = root
        mockfile = try MockfileSetup(path: root + "Mockfile")
        generate = GenerateCommand(root: root, mockfile: mockfile.mockfile)
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
            let mock = Mock(config: config)
            mockfile.add(mock: mock, for: name)
        }

        try mockfile.save()
        print("✅ 🎉 " + crayon.bold.on("Migration completed!"))

        // Ask for removing old configuration files
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
