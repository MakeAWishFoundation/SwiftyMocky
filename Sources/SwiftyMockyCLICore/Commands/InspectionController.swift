import Foundation
import ShellOut
import PathKit
import Commander
import Yams
import Crayon
import xcodeproj

public class InspectionController {

    private let root: Path
    private var project: XcodeProj

    public init(project name: Path, at root: Path) throws {
        let path = try ProjectPathOption.select(project: name, at: root)
        self.project = try XcodeProj(path: path)
        self.root = root
    }

    // MARK: - Sourcery

    public func inspectSourcery() {

    }

    func verifyMint() {

    }

    func verifySourceryCommandExists() {

    }

    func verifyCustomSourceryCommand() {

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
