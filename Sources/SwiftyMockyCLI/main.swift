import Foundation
import Commander
import PathKit
import SwiftyMockyCLICore
import Crayon

let ver = "v0.0.2"

struct Messages {
    struct Setup {
        static let description = "if more than one xcodeproj in directory, add a selected project path: mocky setup <project>.xcodeproj"
    }
    struct Migrate {
        static let description = "migrate existing SwiftyMocky yml configurations into Mockfile™"
        static let noConfigurations = "No migration possible, not found any legacy yml configuration files in this directory."
    }
    struct Autoimport {
        static let description = "scans sources and automatically resolves imports for the mocks"
    }
    struct Generate {
        static let description = "generate mocks. Allowed flags: --disableCache and --verbose"
    }
    struct Doctor {
        static let description = "run to inspect status of SwiftyMocky setup"
    } 
}

func handle(_ error: Error) {
    Message.failure("Error: \(error)")
}

Message.swiftyMockyLabel("v0.0.2")

Group() { main in
    let pwd = Path(ProcessInfo.processInfo.environment["PWD"] ?? "")

    main.command("setup", description: Messages.Setup.description) { (parser: ArgumentParser) in
        let projectPath = parser.remainder.last ?? ""

        do {
            let project = try ProjectSetupController(
                project: Path(projectPath),
                at: pwd
            )
            let migration = try MigrationController(project: project.project, at: pwd)

            // 1. Verify if there is already a Mockfile
            if project.mockfileExists {
                Message.warning("Mockfile™ already exists.")
                Message.just("""
                    Available options:
                        - continue (you will be prompted about overriding)
                        - cancel, and setup manually
                    """
                )
                // Read option
                Message.empty()
                Message.subheader("Do you want to continue?")
                switch BoolOption.select() {
                case .yes:
                    break  // Continue flow
                case .no:
                    return // Finish now
                }
            }

            if migration.migrationPossible() {
                Message.success("Migration possible.")
                Message.just("""
                    Existing SwiftyMocky yml configurations found.
                    Available options:
                        - migrate (you will migrate existing yml configurations)
                        - setup as new
                    """
                )
                // Read option
                Message.empty()
                Message.subheader("Do you want to migrate?")
                switch BoolOption.select() {
                case .yes:
                    try migration.migrate()
                case .no:
                    try project.initializeAsANewMockfile()
                }
            } else {
                try project.initializeAsANewMockfile()
            }
            Message.empty()
        } catch {
            handle(error)
        }
    }

    main.command("migrate", description: Messages.Migrate.description) { (parser: ArgumentParser) in
        let projectPath = parser.remainder.last ?? ""
        do {
            let setup = try MigrationController(project: Path(projectPath), at: pwd)

            guard setup.migrationPossible() else {
                return Message.failure(Messages.Migrate.noConfigurations)
            }

            try setup.migrate()
            Message.empty()
        } catch {
            handle(error)
        }
    }

    main.command("autoimport", description: Messages.Autoimport.description) { (parser: ArgumentParser) in
        let mockName = parser.remainder.last

        do {
            let command = try GenerationController(root: pwd)
            if let name = mockName {
                try command.updateImports(forMockNamed: name)
            } else {
                try command.updateAllImports()
            }
        } catch {
            handle(error)
        }
    }

    main.command("generate",
        Flag("disableCache", default: false, description: "Disables cache"),
        Flag("verbose", default: false, description: "Additional output"),
        description: Messages.Generate.description
    ) { (disableCache: Bool, verbose: Bool) in

        // 1. Generate using Mockfile
        // 2. Generate using legacy yml configs
        do {
            Message.info("Running at: \(pwd)")
            let command = try GenerationController(root: pwd)
            try command.generate(disableCache: disableCache, verbose: verbose)
        } catch {
            handle(error)
        }
    }

    main.command("doctor", description: Messages.Doctor.description) { (parser: ArgumentParser) in
        let projectPath = parser.remainder.last ?? ""

        do {
            let inspector = try InspectionController(project: Path(projectPath), at: pwd)

            inspector.inspectTools()
            inspector.inspectMockfile()
            Message.empty()
        } catch {
            handle(error)
        }
    }
}
.run()
