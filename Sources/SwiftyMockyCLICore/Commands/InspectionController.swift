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

        Message.subheader("Targets:")
        // 2. Target exists
        let allTargetsExists = verifyTargetsExists(for: mock)
        // 3. Targets contain output file
        let allTargetsContainsOutput = verifyTargetsIncludeOutput(for: mock)

        var targetsResolutions = Set<String>()

        if allTargetsExists {
            Message.success("Mock defines targets correctly")
        } else {
            Message.warning("Seems than not all targets defined in the Mockfile exists")
            targetsResolutions.insert("verify targets configuration your \'Mockfile™\'")
            targetsResolutions.insert("run \'swiftymocky setup\' and override configuration for this target (unsafe)")
        }

        if allTargetsContainsOutput {
            Message.success("All targets include \'\(mock.output)\' file.")
        } else {
            Message.warning("Some of the targets does not include generated mock")
            targetsResolutions.insert("open xcode project and add missing output files to respective unit tests targets")
            targetsResolutions.insert("verify targets configuration your \'Mockfile™\'")
        }

        if !targetsResolutions.isEmpty {
            Message.resolutions(array: targetsResolutions.map { $0 })
        }

        // 4. Sources folders exists
        verifySourcesFoldersExists(for: mock)
        // 5. Testable modules defined
        verifyTestableModulesDefined(for: mock)
        // 6. Imports defined
        verifyImportsDefined(for: mock)

        Message.unindent()
    }

    func verifyOutputExists(for mock: Mock) {
        let output = root + mock.output
        guard !output.exists else {
            return Message.success("Output file exists")
        }

        Message.warning("Output file \'\(output.abbreviate())\' does not exist")
        Message.hint("Output file would be auto generated upon running \'swiftymocky generate\'")
    }

    func verifyTargetsExists(for mock: Mock) -> Bool {
        guard !mock.targets.isEmpty else {
            Message.warning("Mock does not define targets")
            Message.hint("This is not an error, but lack of match between mock and targets will result in \'setup\' misbehaving as well as reduced info messages accuracy.")
            return false
        }

        let allTargetsExists = mock.targets.reduce(into: true) { result, targetName in
            let found = project.pbxproj.allUnitTestTargets.contains(where: { $0.name == targetName })
            if !found {
                Message.nok("Mock specified \'\(targetName)\' target which does not seem to exist.")
            }
            result = result && found
        }

        return allTargetsExists
    }

    func verifyTargetsIncludeOutput(for mock: Mock) -> Bool {
        guard !mock.targets.isEmpty else { return false }

        let allTargetsContainsOutput = project.pbxproj.allUnitTestTargets.reduce(into: true) { result, target in
            guard mock.targets.contains(target.name) else { return }

            do {
                let includes = try result && target.sourceFiles().contains(where: { file in
                    return file.relativePath()?.string == mock.output
                })
                if !includes {
                    Message.nok("Target \'\(target.name)\' does not include \'\(mock.output)\' file!")
                }
                result = result && includes
            } catch {
                Message.failure("Could not process \(project)! \(error)")
            }
        }

        return allTargetsContainsOutput
    }

    func verifySourcesFoldersExists(for mock: Mock) {
        Message.subheader("Sources:")
        let includes = mock.sources.include.map { Path($0) }.reduce(into: true) { result, path in
            guard !path.exists else { return }

            Message.nok("Included path \'\(path)\' does not exist!")
            result = false
        }

        let excludes = (mock.sources.exclude ?? []).map { Path($0) }.reduce(into: true) { result, path in
            guard !path.exists else { return }

            Message.nok("Excluded path \'\(path)\' does not exist!")
            result = false
        }

        if includes && excludes {
            Message.success("Sources are defined correctly")
        } else {
            Message.warning("Found issues with sources")
            Message.resolutions("verify Mockfile™ configuration", "remove unnecessary paths")
        }
    }

    func verifyTestableModulesDefined(for mock: Mock) {
        if !mock.testable.isEmpty {
            Message.success("Testable imports are defined")
        } else {
            Message.failure("Mock does not define any \'testable\' modules (@testable import <module>)")
            Message.resolutions(
                "verify Mockfile™ configuration", 
                "add testable modules manually",
                "run \'swiftymocky setup\' and override configuration (unsafe)"
            )
        }
    }

    func verifyImportsDefined(for mock: Mock) {
        if !mock.import.isEmpty {
            Message.success("Imports are defined")
        } else {
            Message.failure("Mock does not define any modules  to \'import\' (import <module>)")
            Message.resolutions(
                "run \'swiftymocky autoimport\' to automatically resolve modules that needs to be imported",
                "verify Mockfile™ configuration", 
                "add import manually",
                "run \'swiftymocky setup\' and override configuration (unsafe)"
            )
        }
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
