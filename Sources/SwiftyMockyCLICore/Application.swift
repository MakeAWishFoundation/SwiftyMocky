import Foundation
import PathKit
import Commander

public class Application {

    // MARK: - Properties

    public let version = "0.0.3"
    public var pwd = Path(ProcessInfo.processInfo.environment["PWD"] ?? "")
    public var handle: (Error) -> Void = { error in
        Message.failure("Error: \(error)")
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

    public func encode(file: String, output: String) {
        let filePath = Path(file)
        guard filePath.exists, filePath.isFile else { return }

        let data: Data = try! filePath.read()
        let encoded = data.base64EncodedString()
        let outputPath = pwd + output
        try! outputPath.write(encoded)
        Message.success("Done")
    }

    public func assetizeTemplates(templates: Path, template: Path, output: Path) {
        let allTypesName = "AllTypes.swifttemplate"
        let allTypesPlaceholder = "{{ \(allTypesName) }}"
        let allTypesTemplate = templates + allTypesName
        let allTypesContent = encoded(allTypesTemplate)
        Message.success("Encoded all types template")

        let mockName = "Mock.swifttemplate"
        let mockPlaceholder = "{{ \(mockName) }}"
        let mockTemplate = templates + mockName
        let mockContent = encoded(mockTemplate)
        Message.success("Encoded mock template")
        
        Message.info("Writing assets to `\(output)` ...")
        var assetsContents: String = try! template.read()
        assetsContents = assetsContents.replacingOccurrences(of: allTypesPlaceholder, with: allTypesContent)
        assetsContents = assetsContents.replacingOccurrences(of: mockPlaceholder, with: mockContent)
        try! output.write(assetsContents)
        Message.success("Done")
    }

    private func encoded(_ file: Path) -> String {
        let data: Data = try! file.read()
        return data.base64EncodedString()
    }
}
