import Foundation

public struct Messages {
    public struct Setup {
        public static let initDescription = "Creates template of Mockfile to fill"
        public static let description = "if more than one xcodeproj in directory, add a selected project path: mocky setup <project>.xcodeproj"
    }
    public struct Migrate {
        public static let description = "migrate existing SwiftyMocky yml configurations into Mockfile™"
        public static let noConfigurations = "No migration possible, not found any legacy yml configuration files in this directory."
    }
    public struct Autoimport {
        public static let description = "scans sources and automatically resolves imports for the mocks"
    }
    public struct Generate {
        public static let description = """
            generate mocks. Usage 'swiftymocky <options> <optional mock name>'
                                Allowed flags:
                                    --disableCache      \(Messages.Generate.disableCache)
                                    --verbose, -v       \(Messages.Generate.verbose)
                                    --watch, -w         \(Messages.Generate.watcher)
            """
        public static let verbose = "additional sourcery debug info"
        public static let disableCache = "disables using cahche"
        public static let watcher = "run in watcher mode, allowed only if mock name specified"
    }
    public struct Doctor {
        public static let description = "run to inspect status of SwiftyMocky setup"
    }
}
