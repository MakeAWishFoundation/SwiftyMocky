import Foundation
import Commander
import PathKit
import SwiftyMockyCLICore
import Crayon

print("Hello, world!")

extension String {
    var intValue: Int? {
        return Int(self)
    }
}

Group { main in
    let pwd = Path(ProcessInfo.processInfo.environment["PWD"] ?? "")

    main.command(
        "generate",
        Argument("YAML config path"),
        Flag("disableCache", default: false, description: "Disables cache"),
        Flag("verbose", default: false, description: "Additional output")
    ) { (config: String, disableCache: Bool, verbose: Bool) in

        let command = GenerateCommand(
            root: Path(ProcessInfo.processInfo.environment["PWD"] ?? ""),
            config: Path(config)
        )

        do {
            print("running command")
            try command.run(disableCache: disableCache, verbose: verbose)
        } catch {
            print("Failed!!! Error: \(error)")
        }
    }

    main.command(
        "doctor",
        Argument("YAML config path")
    ) { (config: String) in

        let command = ReadSourceryConfigurationCommand(config: Path(config))

        do {
            print("running command")
            try command.run()
        } catch {
            print("Failed!!! Error: \(error)")
        }
    }

    main.command(
        "test"
    ) {

        let path = Path(ProcessInfo.processInfo.environment["PWD"] ?? "")
        let command = TestCommand(root: path)

        do {
            print("running command")
            try command.run()
        } catch {
            print("Failed!!! Error: \(error)")
        }
    }

    main.command(
        "setup"
    ) { (parser: ArgumentParser) in
        let path = parser.remainder.last ?? ""

        do {
            let project = try ProjectSetup(
                project: Path(path),
                at: pwd
            )
            // 1. Verify if there is already a Mockfile
            // 2. Migrate if needed
            // 3. New Setup

            try project.initializeNewMockfile()

        } catch {
            print(crayon.bold.red.on("Error: \(error)"))
        }
    }
}
.run()
