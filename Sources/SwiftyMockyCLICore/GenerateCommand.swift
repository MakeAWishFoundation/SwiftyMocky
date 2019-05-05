import Foundation
import ShellOut
import PathKit
import Commander

public class GenerateCommand {

    public static var mintSourceryRun: Path = "mint run krzysztofzablocki/Sourcery sourcery"

    private let root: Path
    private let config: Path
    private let sourcery: Path

    /// Initializes new generate command action
    ///
    /// - Parameters:
    ///   - root: Root directory
    ///   - config: YAML config path
    ///   - sourcery: Sourcery command (or path to binary)
    public init(root: Path, config: Path, sourcery: Path = GenerateCommand.mintSourceryRun) {
        self.root = root
        self.config = config
        self.sourcery = sourcery
    }

    /// Generates mocks
    ///
    /// - Throws: Command error if sourcery fails generation
    public func run(disableCache: Bool = false, verbose: Bool = false) throws {
        var arguments = [String]()

        arguments += Arg(config.absolute().string, name: "--config")
        arguments += Arg(disableCache, name: "--disableCache")
        arguments += Arg(verbose, name: "--verbose")

        try shellOut(
            to: sourcery.string,
            arguments: arguments,
            at: root.string,
            outputHandle: FileHandle.standardOutput
        )
    }
}
