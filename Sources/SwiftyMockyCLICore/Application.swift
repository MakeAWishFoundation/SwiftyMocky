import Foundation
import PathKit
import Commander

public class Application {

    // MARK: - Properties

    public let version = "3.5.0"
    public var pwd = Path(ProcessInfo.processInfo.environment["PWD"] ?? "")
    public var handle: (Error) -> Void = { error in
        switch error {
        case let error as MockyError:
            Message.failure(Messages.message(for: error))
        default:
            Message.failure("Error: \(error)")
        }
        exit(1)
    }

    // MARK: - Lifecycle

    public init() { 
    }

    // MARK: - Commands

    public func generate(disableCache: Bool, verbose: Bool) {
        do {
            Message.info("Running at: \(pwd)")
            let command = try Instance.factory.resolveGenerationCommand(root: pwd)
            try command.generate(disableCache: disableCache, verbose: verbose)
        } catch {
            handle(error)
        }
    }

    public func generate(mock named: String, disableCache: Bool, verbose: Bool, watch: Bool = false) {
        do {
            Message.info("Running at: \(pwd)")
            let command = try Instance.factory.resolveGenerationCommand(root: pwd)
            try command.generate(mockName: named, disableCache: disableCache, verbose: verbose, watch: watch)
        } catch {
            handle(error)
        }
    }

    public func initialize() {
        let mockfilePath = (pwd + "Mockfile")
        guard !mockfilePath.exists else {
            Message.failure("Mockfile already exists!")
            return handle(MockyError.overrideWarning)
        }

        do {
            try mockfilePath.write(Assets.mockfileTemplate)
            Message.success("Successfully generated Mockfile")
            Message.hint("Use 'doctor' to validate it, or update manually. You can use 'autoimport' to resolve imports automatically")
        } catch {
            handle(error)
        }
    }

    #if os(macOS)
    public func setup(project path: String?) {
        let projectPath = path ?? ""

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

    public func migrate(project path: String?) {
        let projectPath = path ?? ""
        do {
            let setup = try MigrationController(
                project: Path(projectPath),
                at: pwd
            )

            guard setup.migrationPossible() else {
                return Message.failure(Messages.Migrate.noConfigurations)
            }

            try setup.migrate()
            Message.empty()
        } catch {
            handle(error)
        }
    }

    public func autoimport() {
        do {
            let command = try Instance.factory.resolveGenerationCommand(root: pwd)
            try command.updateAllImports()
        } catch {
            handle(error)
        }
    }

    public func autoimport(forMock name: String?) {
        guard let name =  name else { return autoimport() }

        do {
            let command = try Instance.factory.resolveGenerationCommand(root: pwd)
            try command.updateImports(forMockNamed: name)
        } catch {
            handle(error)
        }
    }

    public func doctor(project path: String?) {
        let projectPath = path ?? ""

        do {
            let inspector = try InspectionController(project: Path(projectPath), at: pwd)

            inspector.inspectTools()
            inspector.inspectMockfile()
            Message.empty()
        } catch {
            handle(error)
        }
    }
    #endif

    // MARK: - Helpers and Debug

    public func assetizeTemplates(
        mockTemplate: Path, 
        allTypesTemplate: Path,
        template: Path, 
        output: Path
    ) {
        let allTypesName = "AllTypes.swifttemplate"
        let allTypesPlaceholder = "{{ \(allTypesName) }}"
        let allTypesContent = encoded(allTypesTemplate)
        Message.success("Encoded all types template")

        let mockName = "Mock.swifttemplate"
        let mockPlaceholder = "{{ \(mockName) }}"
        let mockContent = encoded(mockTemplate)
        Message.success("Encoded mock template")

        let prototypeName = "Prototype.swifttemplate"
        let prototypePlaceholder = "{{ \(prototypeName) }}"
        let prototypeTemplate = mockTemplate
        let prototypeContent = encoded(prototypeTemplate, replacing: "import SwiftyMocky", with: "import SwiftyPrototype")
        Message.success("Encoded prototype template")
        
        Message.info("Writing assets to `\(output)` ...")
        var assetsContents: String = try! template.read()
        assetsContents = assetsContents.replacingOccurrences(of: allTypesPlaceholder, with: allTypesContent)
        assetsContents = assetsContents.replacingOccurrences(of: mockPlaceholder, with: mockContent)
        assetsContents = assetsContents.replacingOccurrences(of: prototypePlaceholder, with: prototypeContent)
        try! output.write(assetsContents)
        Message.success("Done")
    }

    private func encoded(_ file: Path) -> String {
        let data: Data = try! file.read()
        return data.base64EncodedString()
    }

    private func encoded(_ file: Path, replacing: String, with other: String) -> String {
        let text: String = try! file.read()
        let replaced = text.replacingOccurrences(of: replacing, with: other)
        let data = replaced.data(using: .utf8) ?? Data()
        return data.base64EncodedString()
    }
}
