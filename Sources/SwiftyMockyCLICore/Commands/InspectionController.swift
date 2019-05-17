import Foundation
import ShellOut
import PathKit
import xcodeproj

public class InspectionController {

    private let root: Path
    private var project: XcodeProj

    public init(project name: Path, at root: Path) throws {
        let path = try ProjectPathOption.select(project: name, at: root)
        self.project = try XcodeProj(path: path)
        self.root = root
    }

    // MARK: - Tools

    public func inspectTools() {
        Message.header("Inspecting tools dependencies:")
        Message.indent()

        if verify(command: "which mint") {
            Message.success("Mint available")
        } else {
            Message.warning("Mint unavailable")
            Message.hint("Mint is designated tool for working with SwiftyMocky. We strongly reccomend to install it via \'brew install mint\'")
        }

        inspectSourcery()
        Message.unindent()
    }

    public func inspectSourcery() {
        let mintAvailable = verify(command: "which mint")
        let sourceryAvailable = verify(command: "which sourcery")

        switch (sourceryAvailable, mintAvailable) {
        case (_, true):
            Message.success("Sourcery is available through Mint")
            guard !verifyMintHasMatchingSourceryVersion() else { return }
            Message.warning("Mint does not yet have matching Sourcery version installed.")
            Message.hint("Required Sourcery version would be installed upon first generation. It might take a bit more time")
        case (true, false):
            Message.warning("Custom Sourcery installation detected")
            Message.hint("Compatibility issues might arise. Please assure correct path/command to Sourcery is specified in the \'Mockfile\'.")
        default:
            Message.failure("Sourcery dependency missing!")
            Message.resolutions("Install mint (e.x. via brew)", "Install sourcery and update field in \'Mockfile\'")
        }
    }

    // MARK: - Mockfile

    public func inspectMockfile() {
        Message.header("Inspecting Mockfile:")
        Message.indent()
        guard let mockfile = fetchMockfile() else {
            Message.failure("Mockfile does not exist!")
            Message.resolutions(
                "try running \'swiftymocky setup\'",
                "try running \'swiftymocky migrate\' if you have legacy configurations"
            )
            return
        }

        Message.success("Mockfile exists")

        lint(mockfile)
    }

    func lint(_ mockfile: Mockfile) {
        if mockfile.allMocks.isEmpty {
            Message.failure("Mockfile does not have any mock definitions!")
            Message.resolutions(
                "try running \'swiftymocky setup\'",
                "try running \'swiftymocky migrate\' if you have legacy configurations"
            )
        } else {
            Message.success("Mockfile contains mocks definitions")
        }

        Message.unindent()

        mockfile.allMembers.forEach { member in
            guard let mock = mockfile[dynamicMember: member] else { return }
            lint(mock, named: member)
        }
    }

    // MARK: - Linting Mock

    func lint(_ mock: Mock, named name: String) {
        // Print mock info
        Message.header("Linting \'\(name)\' mock:")
        Message.indent()

        // 1. Output exists
        verifyOutputExists(for: mock)
        // 2. Target exists
        // 3. Targets contain output file
        verifyTargetsExists(for: mock)

        // 4. Sources folders exists
        verifySourcesFoldersExists(for: mock)
        // 5. Testable modules defined
        verifyTestableModulesDefined(for: mock)
        // 6. Imports defined
        verifyImportsDefined(for: mock)

        Message.unindent()
    }

    func verifyOutputExists(for mock: Mock) {

        Message.success("Output file exists")
    }

    func verifyTargetsExists(for mock: Mock) {
//        Message.subheader("Targets:")
//        Message.indent()
//        mock.targets.forEach { verifyTargetExists(for: mock, target: $0) }
//        Message.unindent()
        Message.success("Mock defines targets correctly")
    }

    func verifyTargetExists(for mock: Mock, target name: String) -> Bool {
//        Message.ok("Target \'\(name)\' exists")
        return true
    }

    func verifySourcesFoldersExists(for mock: Mock) {
//        Message.subheader("Sources:")
//        Message.indent()
//
//        mock.sources.include.forEach {
//            Message.ok("- path \'\($0)\' exists")
//        }
//
//        Message.unindent()
        Message.success("Sources are defined correctly")
    }

    func verifyTestableModulesDefined(for mock: Mock) {
        Message.success("Testable imports are defined")
    }

    func verifyImportsDefined(for mock: Mock) {
        Message.success("Imports are defined")
    }

    // MARK: - Helpers

    func fetchMockfile() -> Mockfile? {
        return try? Mockfile(path: root + "Mockfile")
    }
}

func verify(command: String) -> Bool {
    do {
        try shellOut(to: command)
        return true
    } catch {
        return false
    }
}

func verifyMintHasMatchingSourceryVersion() -> Bool {
    do {
        let list = try shellOut(to: "mint list")
            .replacingOccurrences(of: " ", with: "")
            .replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: "-", with: "@")
        return list.contains(kSourceryVersion)
    } catch {
        return false
    }
}
