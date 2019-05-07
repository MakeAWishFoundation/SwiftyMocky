import Foundation
import Commander
import PathKit
import SwiftyMockyCLICore
import Crayon

let ver = "v0.0.2"

print(crayon.bold.on("╔════════════════════════╗"))
print(crayon.bold.on("║ SwiftyMocky CLI \(ver) ║"))
print(crayon.bold.on("╚════════════════════════╝"))
print("")

struct Messages {
    struct Setup {
        static let description = "if more than one xcodeproj in directory, add a selected project path: mocky setup <project>.xcodeproj"
    }
    struct Migrate {
        static let description = "migrate existing SwiftyMocky yml configurations into Mockfile"
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
    print(crayon.bold.red.on("Error: \(error)"))
}

Group() { main in
    let pwd = Path(ProcessInfo.processInfo.environment["PWD"] ?? "")

    main.command("setup", description: Messages.Setup.description) { (parser: ArgumentParser) in
        let path = parser.remainder.last ?? ""

        do {
            let project = try ProjectSetupCommand(
                project: Path(path),
                at: pwd
            )
            let migration = try MigrationCommand(root: pwd)

            // 1. Verify if there is already a Mockfile
            if project.mockfileExists {
                print("❕ Mockfile already exists.")
                print("""
                    Available options:
                        - continue (you will be prompted about overriding)
                        - cancel, and setup manually
                    """)
                // Read option
                print(crayon.bold.on("\nDo you want to continue?"))
                switch BoolOption.select() {
                case .yes:
                    break  // Continue flow
                case .no:
                    return // Finish now
                }
            }

            if migration.migrationPossible() {
                print("✅  Migration possible.")
                print("""
                    Existing SwiftyMocky yml configurations found.
                    Available options:
                        - migrate (you will migrate existing yml configurations)
                        - setup as new
                    """)
                // Read option
                print(crayon.bold.on("\nDo you want to migrate?"))
                switch BoolOption.select() {
                case .yes:
                    try migration.migrate()
                case .no:
                    try project.initializeAsANewMockfile()
                }
            } else {
                try project.initializeAsANewMockfile()
            }
        } catch {
            handle(error)
        }
    }

    main.command("migrate", description: Messages.Migrate.description) {
        do {
            let setup = try MigrationCommand(root: pwd)

            guard setup.migrationPossible() else {
                print(crayon.red.bold.on(
                    "No migration possible, not found any legacy yml configuration files in this directory."
                ))
                return
            }

            try setup.migrate()
        } catch {
            handle(error)
        }
    }

    main.command("autoimport", description: Messages.Autoimport.description) {
        do {
            print(pwd)
            let command = try GenerateCommand(root: pwd)
            try command.updateAllImports()
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
            print(pwd)
            let command = try GenerateCommand(root: pwd)
            try command.generate(disableCache: disableCache, verbose: verbose)
        } catch {
            handle(error)
        }
    }

    main.command("doctor", description: Messages.Doctor.description) {
        // TODO: Add doctor feature
    }
}
.run()
