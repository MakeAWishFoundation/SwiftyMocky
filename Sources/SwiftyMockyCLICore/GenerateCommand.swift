import Foundation
import ShellOut
import PathKit
import Commander
import Yams
import Crayon

public var defaultSourceryCommand = Path("mint run krzysztofzablocki/Sourcery@0.16.1 sourcery")

public class GenerateCommand {

    private let root: Path
    private let sourcery: Path
    private let temp: Temp
    private var mockfile: Mockfile
    private let mockfilePath: Path

    private let outputHandle = ProxyFileHandle()

    // TODO: This is temporary solution, use global resources path
    private var mockTemplate: Path { return root + Path("Sources/Templates") }
    private var typesTemplate: Path { return root + Path("Sources/TypesTemplates") }

    // MARK: - Lifecycle

    public init(root: Path, sourcery: Path = defaultSourceryCommand) throws {
        self.root = root
        self.sourcery = sourcery
        self.temp = Temp(root: root)
        self.mockfilePath = root + "Mockfile"
        self.mockfile = try Mockfile(path: mockfilePath)
    }

    // MARK: - Actions

    public func generate(disableCache: Bool = false, verbose: Bool = false) throws {
        // Create temporary build directory
        try temp.createDir()

        // Generate mocks for every Mock
        try mockfile.allMembers.forEach { key in
            guard let mock = mockfile[dynamicMember: key] else { return }

            print(crayon.bold.bgBlue.whiteBright.on("Processing mock: \(key) ..."))
            try generate(mock, disableCache, verbose)
        }

        // Cleanup
        try cleanup()
    }

    public func updateAllImports() throws {
        try updateImports(into: &mockfile)
        let setup = MockfileSetup(path: mockfilePath, mockfile: mockfile)
        try setup.save()
    }

    public func updateImports(forMockNamed name: String) throws {
        guard var mock = mockfile[dynamicMember: name] else { return }

        try updateImports(into: &mock)
        mockfile[dynamicMember: name] = mock

        let setup = MockfileSetup(path: mockfilePath, mockfile: mockfile)
        try setup.save()
    }

    public func cleanup() throws {
        try temp.cleanup()
    }

    private func generate(_ mock: Mock, _ disableCache: Bool, _ verbose: Bool) throws {
        let generateMocks = mock.configuration(template: mockTemplate)
        try temp.create(config: generateMocks)
        var arguments = [String]()

        arguments += Arg(temp.tempConfig.string, name: "--config")
        arguments += Arg(disableCache, name: "--disableCache")
        arguments += Arg(verbose, name: "--verbose")

        try shellOut(
            to: sourcery.string,
            arguments: arguments,
            at: root.string,
            outputHandle: outputHandle
        )
        print(crayon.bold.on("... Done."))
    }

    // MARK: - Extraction

    func updateImports(into mockfile: inout Mockfile) throws {
        // Create temporary build directory
        try temp.createDir()

        try mockfile.allMembers.forEach { key in
            guard var mock = mockfile[dynamicMember: key] else { return }

            print(crayon.bold.bgBlue.whiteBright.on("Extracting imports from mock: \(key) ..."))
            try updateImports(into: &mock)
            mockfile[dynamicMember: key] = mock
        }

        // Cleanup
        try cleanup()
    }

    func updateImports(into mock: inout Mock) throws {
        let typesFilePath = temp.tempDirectory + Path("types.yaml")
        try? typesFilePath.delete()
        let config = mock.configuration(template: typesTemplate)
        try temp.create(config: config, output: typesFilePath.absolute().string)

        var arguments = [String]()

        arguments += Arg(temp.tempConfig.string, name: "--config")

        try shellOut(
            to: sourcery.string,
            arguments: arguments,
            at: root.string,
            outputHandle: outputHandle
        )

        let resultsYaml: String = try typesFilePath.read().replacingOccurrences(of: "//", with: "#")

        struct TypesList: Codable {
            let types: [String]
        }

        let list: TypesList = try YAMLDecoder().decode(from: resultsYaml)
        let types = list.types
        print(crayon.bold.on("  -> Found \(types.count) types."))

        let files = try root.files(for: mock.sources)
        print(crayon.bold.on("  -> Found \(files.count) files to scan."))

        let importsSet: Set<String> = files.reduce(into: Set()) { result, path in
            guard let contents: String = try? path.read() else { return }
            guard contents.containsDeclaration(forAnyOf: types) else { return }

            contents.importStatements().forEach { result.insert($0) }
        }
        let imports = importsSet.map { $0 }

        print(crayon.bold.on("  -> Found \(imports.count) import statements."))
        mock.import = imports
    }

}

class Temp {

    var tempDirectory: Path { return root + Path(".mocky") }
    var tempConfig: Path { return root + Path(".mocky/.config.yml.tmp") }

    private let root: Path

    init(root: Path) {
        self.root = root
    }

    func createDir() throws {
        try? tempDirectory.delete()
        try tempDirectory.mkdir()
    }

    func create(config: LegacyConfiguration, output: String? = nil) throws {
        let includes = config.sources.include.map { ".\($0)" }
        let excludes = config.sources.exclude?.map { ".\($0)" }
        let templates = config.templates
        let updatedConfig = LegacyConfiguration(
            sources: Mock.Sources(
                include: includes,
                exclude: excludes
            ),
            templates: templates,
            output: output ?? ("." + config.output),
            args: config.args
        )
        try? tempConfig.delete()
        let yaml: String = try YAMLEncoder().encode(updatedConfig)
        try tempConfig.write(yaml)
    }

    func cleanup() throws {
        try? tempDirectory.delete()
        try? tempConfig.delete()
    }
}

private extension Path {

    func files(for sources: Mock.Sources) throws -> [Path] {
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
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
