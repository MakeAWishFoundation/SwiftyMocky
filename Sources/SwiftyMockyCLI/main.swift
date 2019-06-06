import Foundation
import Commander
import PathKit
import SwiftyMockyCLICore

let application = Application()

Message.swiftyMockyLabel("SwiftyMocky CLI v\(application.version)")

Group() { main in

    // MARK: - Properties

    let verbose = Flag("verbose", flag: "v", description: Messages.Generate.verbose)
    let disableCache = Flag("disableCache", description: Messages.Generate.disableCache)
    let watch = Flag("watch", flag: "w", description: Messages.Generate.watcher)

    // MARK: - Commands

    main.command("init", description: Messages.Setup.initDescription) {
        application.initialize()
    }

    main.command("generate", description: Messages.Generate.description) { (parser: ArgumentParser) in
        let isVerbose = try verbose.parse(parser)
        let isCacheDisabled = try disableCache.parse(parser)
        let isWatched = try watch.parse(parser)

        if let named = parser.remainder.last {
            application.generate(
                mock: named,
                disableCache:
                isCacheDisabled,
                verbose: isVerbose,
                watch: isWatched
            )
        } else {
            application.generate(
                disableCache: isCacheDisabled,
                verbose: isVerbose
            )
        }
    }

    main.command("watch", description: Messages.Generate.watcher) { (parser: ArgumentParser) in
        let isVerbose = try verbose.parse(parser)
        let isCacheDisabled = try disableCache.parse(parser)

        guard let named = parser.remainder.last else {
            return Message.failure("No mock name specified")
        }

        application.generate(
            mock: named,
            disableCache:
            isCacheDisabled,
            verbose: isVerbose,
            watch: true
        )
    }

    #if os(macOS)
    main.command("setup", description: Messages.Setup.description) { (parser: ArgumentParser) in
        application.setup(project: parser.remainder.last)
    }

    main.command("migrate", description: Messages.Migrate.description) { (parser: ArgumentParser) in
        application.migrate(project: parser.remainder.last)
    }

    main.command("autoimport", description: Messages.Autoimport.description) { (parser: ArgumentParser) in
        application.autoimport(forMock: parser.remainder.last)
    }

    main.command("doctor", description: Messages.Doctor.description) { (parser: ArgumentParser) in
        application.doctor(project: parser.remainder.last)
    }
    #endif

    #if DEBUG
    main.command("assetize", description: Messages.Tools.assetizeDescription) {
        let pwd = Path(ProcessInfo.processInfo.environment["PWD"] ?? "")
        application.assetizeTemplates(
            mockTemplate: pwd + "Sources/Templates/Mock.swifttemplate", 
            allTypesTemplate: pwd + "Templates/AllTypes.swifttemplate",
            template: pwd + "Templates/Assets.template", 
            output: pwd + "Sources/SwiftyMockyCLICore/Assets/Assets.swift"
        )
    }
    #endif
}
.run()
