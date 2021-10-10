import Foundation
#if canImport(XCTest)
import XCTest

/// Used for observing tests and handling internal library errors.
public class SwiftyMockyTestObserver: NSObject, XCTestObservation {
    /// [Internal] Current test case
    private static var currentTestCase: XCTestCase?
    /// [Internal] Setup observing once
    private static let setupBlock: (() -> Void) = {
        Matcher.fatalErrorHandler = SwiftyMockyTestObserver.handleFatalError
        let addObserver = { XCTestObservationCenter.shared.addTestObserver(SwiftyMockyTestObserver()) }
        if Thread.isMainThread {
            addObserver()
        } else {
            DispatchQueue.main.async {
                addObserver()
            }
        }
        return {}
    }()

    /// Call this method to setup custom error handling for SwiftyMocky, that allows to gracefully handle missing stub fatal errors.
    /// In general it should be done automatically and there should be no reason to call it directly.
    public static func setup() {
        setupBlock()
    }

    /// [Internal] Observer for test start
    ///
    /// - Parameter testCase: current test
    public func testCaseWillStart(_ testCase: XCTestCase) {
        SwiftyMockyTestObserver.currentTestCase = testCase
    }

    /// [Internal] Observer for test finished
    ///
    /// - Parameter testCase: current test
    public func testCaseDidFinish(_ testCase: XCTestCase) {
        SwiftyMockyTestObserver.currentTestCase = nil
    }

    /// [Internal] used to notify about internal error. Do not call it directly.
    ///
    /// - Parameters:
    ///   - message: Message
    ///   - file: File
    ///   - line: Line
    public static func handleFatalError(message: String, file: StaticString, line: UInt) {
        guard let testCase = SwiftyMockyTestObserver.currentTestCase else {
            return XCTFail(message, file: file, line: line)
        }

        let continueAfterFailure = testCase.continueAfterFailure
        defer { testCase.continueAfterFailure = continueAfterFailure }
        testCase.continueAfterFailure = false
        let methodName = getNameOfExtecutedTestCase(testCase)
        if let name = methodName, let failingLine = FilesExlorer().findTestCaseLine(for: name, file: file) {
            testCase.record(XCTIssue(
                type: .system,
                compactDescription: message,
                detailedDescription: nil,
                sourceCodeContext: .init(location: .init(filePath: file.description, lineNumber: Int(failingLine))),
                associatedError: nil,
                attachments: []
            ))
        } else if let name = methodName {
            XCTFail("\(name) - \(message)", file: file, line: line)
        } else {
            XCTFail(message, file: file, line: line)
        }
    }

    /// [Internal] Geting name of current test
    ///
    /// - Parameter testCase: Test case
    /// - Returns: Name
    private static func getNameOfExtecutedTestCase(_ testCase: XCTestCase) -> String? {
        return testCase.name.components(separatedBy: " ")[1].components(separatedBy: "]").first
    }
}

/// [Internal] Internal dependency that looks for line of test case, that caused test failure.
private class FilesExlorer {
    /// Parses test case file to get line number assigned with test
    ///
    /// - Parameter testCase: Test case
    /// - Parameter file: File we should look in
    /// - Returns: Line number or nil, if unable to find
    func findTestCaseLine(for methodName: String, file: StaticString) -> UInt? {
        guard let content = getFileContent(file: file.description) else {
            return nil
        }
        let lines = content.components(separatedBy: "\n")
        let offset = lines.enumerated().first { (index, line) -> Bool in
            return line.contains(methodName)
        }?.offset
        guard let line = offset else { return nil }
        let lineAdditionalOffset: UInt = 2 // just to show error within test case, below the name.
        return UInt(line) + lineAdditionalOffset
    }

    private func getFileContent(file: String) -> String? {
        // TODO: look for file encoding from file attributes
        guard let fileData = FileManager().contents(atPath: file) else { return nil }
        return String(data: fileData, encoding: .utf8) ?? String(data: fileData, encoding: .utf16)
    }
}

#else

public class SwiftyMockyTestObserver: NSObject {
    /// [Internal] No setup whatsoever
    @objc public static func setup() {
        // Empty on purpose
    }

    public static func handleFatalError(message: String, file: StaticString, line: UInt) {
        // Empty on purpose
    }
}
#endif
