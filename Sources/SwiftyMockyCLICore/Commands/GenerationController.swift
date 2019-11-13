import Foundation
import ShellOut
import PathKit
import Commander
import Yams
import Crayon

public protocol GenerationCommand: AutoMockable {

    func generate(disableCache: Bool, verbose: Bool) throws
    func generate(mockName: String, disableCache: Bool, verbose: Bool, watch: Bool) throws
    func updateAllImports() throws
    func updateImports(forMockNamed name: String) throws
}

final class GenerationController: GenerationCommand {

    private let root: Path
    private let sourcery: Path
    private let temp: WorkingDirectory
    private var mockfile: Mockfile
    private let mockfilePath: Path
    private let outputHandle = ProxyFileHandle()

    // MARK: - Lifecycle

    init(root: Path, sourcery: Path = kDefaultSourceryCommand) throws {
        self.root = root
        self.temp = WorkingDirectory(root: root)
        self.mockfilePath = root + "Mockfile"
        self.mockfile = try Mockfile(path: mockfilePath)
        self.sourcery = Path(mockfile.sourceryCommand ?? sourcery.string)
    }

    init(root: Path, mockfile: Mockfile, sourcery: Path = kDefaultSourceryCommand) {
        self.root = root
        self.temp = WorkingDirectory(root: root)
        self.mockfilePath = root + "Mockfile"
        self.mockfile = mockfile
        self.sourcery = Path(mockfile.sourceryCommand ?? sourcery.string)
    }

    // MARK: - Generation

    func generate(disableCache: Bool = false, verbose: Bool = false) throws {
        // Create temporary build directory
        try temp.createDirIfNeeded()
        try Assets.swifttemplate.mock.write(to: temp.template)

        // Generate mocks for every MockConfiguration
        try mockfile.allMembers.forEach { key in
            guard let mock = mockfile[dynamicMember: key] else { return }
            try writeTemplete(for: mock)
            Message.actionHeader("Processing mock: \(key) ...")
            try generate(mock, disableCache, verbose, false)
        }

        // Cleanup
        try cleanup()
    }

    func generate(mockName: String, disableCache: Bool, verbose: Bool, watch: Bool) throws {
        // Create temporary build directory
        try temp.createDirIfNeeded()
        try Assets.swifttemplate.mock.write(to: temp.template)

        // Cleanup
        defer { try? cleanup() }

        // Generate mocks for every MockConfiguration
        guard let mock = mockfile[dynamicMember: mockName] else {
            throw MockyError.mockNotFound
        }

        try writeTemplete(for: mock)

        if watch {
            Message.actionHeader("Watching mock: \(mockName) ...")
        } else {
            Message.actionHeader("Processing mock: \(mockName) ...")
        }

        do { 
            try generate(mock, disableCache, verbose, watch) 
            try cleanup()
        } catch {
            try? cleanup()
            throw error
        }
    }

    func generate(_ mock: MockConfiguration, _ disableCache: Bool, _ verbose: Bool, _ watch: Bool) throws {
        let generateMocks = mock.configuration(template: temp.template)
        try temp.create(config: generateMocks)
        var arguments = [String]()

        arguments += ["--config", temp.config.string]
        
        if disableCache {
            arguments += ["--disableCache"]
        }
        if verbose {
            arguments += ["--verbose"]
        }
        if watch {
            arguments += ["--watch"]
        }

        #if os(macOS)
        try shellOut(
            to: sourcery.string,
            arguments: arguments,
            at: root.string,
            outputHandle: outputHandle
        )
        #else 
        let resultString = try shellOut(
            to: sourcery.string,
            arguments: arguments,
            at: root.string
        )
        print(resultString)
        #endif

        if missingAutoMockable(for: mock) {
            Message.warning("No mocks generated, haven't found any \'AutoMockable\' protocols.")
            let resolutions = [
                "(preferred) inherit from any protocol named \'AutoMockable\' (you need to define it first)",
                "annotate protocol definition with \'//sourcery: AutoMockable\'"
            ]
            Message.resolutions(array: resolutions, title: "In order to generate mocks for your protocols:")
        } else {
            Message.success("Generation done.")
        }

        try processCustomSourceryConfigurations(mock, disableCache, verbose, watch)
    }

    func processCustomSourceryConfigurations(
        _ mock: MockConfiguration, 
        _ disableCache: Bool, 
        _ verbose: Bool, 
        _ watch: Bool
    ) throws {
        guard !mock.sourcery.isEmpty else { return }

        func launchSourcery(config path: String) throws {
            var arguments: [String] = ["--config", path]
            
            if disableCache {
                arguments += ["--disableCache"]
            }
            if verbose {
                arguments += ["--verbose"]
            }
            if watch {
                arguments += ["--watch"]
            }

            #if os(macOS)
            try shellOut(
                to: sourcery.string,
                arguments: arguments,
                at: root.string,
                outputHandle: outputHandle
            )
            #else 
            let resultString = try shellOut(
                to: sourcery.string,
                arguments: arguments,
                at: root.string
            )
            print(resultString)
            #endif
        }

        let total = mock.sourcery.count
        
        try mock.sourcery.enumerated().forEach { (offset, configPath) in
            Message.info("\(offset + 1)/\(total) Processing custom Sourcery configuration at: \(configPath)")
            try launchSourcery(config: configPath)
        }

        Message.success("Finished processing custom Sourcery configurations")
    }

    func missingAutoMockable(for mock: MockConfiguration) -> Bool {
        let output = Path(mock.output)
        do {
            return try output.read().contains("// SwiftyMocky: no AutoMockable found.")
        } catch {
            return false
        }
    }

    // MARK: - Auto Imports

    func updateAllImports() throws {
        try updateImports(into: &mockfile)
        let setup = MockfileInteractor(path: mockfilePath, mockfile: mockfile)
        try setup.save()
        Message.success("Imports updated.")
    }

    func updateImports(forMockNamed name: String) throws {
        guard var mock = mockfile[dynamicMember: name] else {
            throw MockyError.targetNotFound
        }

        Message.actionHeader("Extracting imports from mock: \(name) ...")
        try updateImports(into: &mock)
        mockfile[dynamicMember: name] = mock

        let setup = MockfileInteractor(path: mockfilePath, mockfile: mockfile)
        try setup.save()
        Message.success("Imports updated.")
    }

    func cleanup() throws {
        try temp.cleanup()
    }

    // MARK: - Extraction

    func updateImports(into mockfile: inout Mockfile) throws {
        // Create temporary build directory
        try temp.createDirIfNeeded()

        try mockfile.allMembers.forEach { key in
            guard var mock = mockfile[dynamicMember: key] else { return }

            Message.actionHeader("Extracting imports from mock: \(key) ...")
            try updateImports(into: &mock)
            mockfile[dynamicMember: key] = mock
        }
    }

    func updateImports(into mock: inout MockConfiguration) throws {
        // Create temporary build directory
        try temp.createDirIfNeeded()
        try Assets.swifttemplate.allTypes.write(to: temp.template)

        let typesFilePath = temp.path + Path("types.yaml")
        try? typesFilePath.delete()
        let config = mock.configuration(template: temp.template)
        try temp.create(config: config, output: typesFilePath.absolute().string)

        var arguments = [String]()

        arguments += ["--config", temp.config.string]

        #if os(macOS)
        try shellOut(
            to: sourcery.string,
            arguments: arguments,
            at: root.string,
            outputHandle: outputHandle
        )
        #else 
        let resultString = try shellOut(
            to: sourcery.string,
            arguments: arguments,
            at: root.string
        )
        print(resultString)
        #endif


        let resultsYaml: String = try typesFilePath.read().replacingOccurrences(of: "//", with: "#")

        struct TypesList: Codable {
            let types: [String]
        }

        Message.indent()

        guard let list: TypesList = try? YAMLDecoder().decode(from: resultsYaml) else {
            return Message.infoPoint("No AutoMockable types found!")
        }
        
        let types = list.types

        Message.infoPoint("Found \(types.count) types.")

        let files = try root.files(for: mock.sources)

        Message.infoPoint("Found \(files.count) files to scan.")

        let importsSet: Set<String> = files.reduce(into: Set()) { result, path in
            guard let contents: String = try? path.read() else { return }
            guard contents.containsDeclaration(forAnyOf: types) else { return }

            contents.importStatements().forEach { result.insert($0) }
        }
        let imports = importsSet.map { $0 }

        Message.infoPoint("Found \(imports.count) import statements.")

        mock.import = imports.sorted()

        Message.unindent()

        try cleanup()
    }

    // MARK: - Helpers

    func writeTemplete(for mock: MockConfiguration) throws {
        if mock.prototype {
            try Assets.swifttemplate.prototype.write(to: temp.template)
        } else {
            try Assets.swifttemplate.mock.write(to: temp.template)
        }
    }

}

private extension Path {

    func files(for sources: MockConfiguration.Sources) throws -> [Path] {
        var files = [Path]()
        let includes: [Path] = sources.include.map { Path($0) }
        let excludes: [Path] = sources.exclude?.map { Path($0) } ?? []

        for path in includes {
            files.append(contentsOf: try path.swiftFiles(excluding: excludes))
        }

        return files
    }

    func swiftFiles(excluding: [Path]) throws -> [Path] {
        guard !excluding.contains(self) else { return [] }

        if isDirectory {
            return try children().reduce(into: [], { result, path in
                result.append(contentsOf: try path.swiftFiles(excluding: excluding))
            })
        } else if self.extension == "swift" {
            return [self]
        } else {
            return []
        }
    }
}

private extension String {
    func containsDeclaration(forAnyOf types: [String]) -> Bool {
        for type in types {
            if !matches(for: "protocol( )+\(type)").isEmpty {
                return true
            }
        }
        return false
    }

    func importStatements() -> [String] {
        return matches(for: "import( )+[a-zA-Z0-9_\\.]+").map {
            $0.replacingOccurrences(of: "import ", with: "")
        }
    }

    func matches(for regex: String) -> [String] {
        let text = self
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            Message.failure("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
