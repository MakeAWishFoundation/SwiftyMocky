import Foundation
import Commander
import PathKit
import SwiftyMockyCLICore
import Crayon

print(crayon.bold.on("╔════════════════════════╗"))
print(crayon.bold.on("║ SwiftyMocky CLI v0.0.1 ║"))
print(crayon.bold.on("╚════════════════════════╝"))
print("")

func handle(_ error: Error) {
    print(crayon.bold.red.on("Error: \(error)"))
}

Group { main in
    let pwd = Path(ProcessInfo.processInfo.environment["PWD"] ?? "")

    main.command("setup") { (parser: ArgumentParser) in
        let path = parser.remainder.last ?? ""

        do {
            let project = try ProjectSetup(
                project: Path(path),
                at: pwd
            )

            // 1. Verify if there is already a Mockfile
            if project.mockfileExists {
                print("❕ Mockfile already exists.")
                print("""
                    Available options:
                        - continue (you will be prompted about overriding)
                        - cancel, and setup manually
                    """)
            }

            // 2. Migrate if needed


            // 3. New Setup

            try project.initializeAsANewMockfile()

        } catch {
            handle(error)
        }
    }

    main.command(
        "generate",
        Flag("disableCache", default: false, description: "Disables cache"),
        Flag("verbose", default: false, description: "Additional output")
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

    main.command("autoimport") {
        do {
            print(pwd)
            let command = try GenerateCommand(root: pwd)
            try command.updateAllImports()
        } catch {
            handle(error)
        }
    }

    main.command("doctor") {

    }
}
.run()

