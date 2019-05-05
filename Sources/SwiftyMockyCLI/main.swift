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
            let targets = try project.findTestTargets()
            let numbers = targets.enumerated()
                .map { "\($0.0 + 1)" }
                .joined(separator: ",")

            repeat {
                let targetsOverview = targets
                    .map { $0.name }
                    .enumerated()
                    .map { "  \($0 + 1)) \($1)" }
                    .joined(separator: "\n")

                print("Found targets: ")
                print(targetsOverview)
                print("\n")

                var option: Int?
                repeat {
                    print("Select target: (\(numbers)):")
                    option = readLine()?.intValue
                } while(option == nil || option! <= 0 || option! > targets.count)

                let selected = option! - 1

                try project.selected(target: targets[selected])
            } while (true)

        } catch {
            print("Failed!!! Error: \(error)")
        }
    }
}
.run()
