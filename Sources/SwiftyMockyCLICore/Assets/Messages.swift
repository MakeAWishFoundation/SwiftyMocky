import Foundation

public struct Messages {
    public struct Setup {
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
        public static let description = "generate mocks. Allowed flags: --disableCache and --verbose"
    }
    public struct Doctor {
        public static let description = "run to inspect status of SwiftyMocky setup"
    }
}
