//
//  TestObserver.swift
//  Pods
//
//  Created by przemyslaw.wosko on 29/09/2018.
//

import Foundation
#if Mocky
import XCTest

/// Used for observing tests and handling internal library errors.
public class SwiftyMockyTestObserver: NSObject, XCTestObservation {
    /// [Internal] Current test case
    private static var currentTestCase: XCTestCase?
    /// [Internal] Setup observing once
    private static let setupBlock: (() -> Void) = {
        XCTestObservationCenter.shared.addTestObserver(SwiftyMockyTestObserver())
        return {}
    }()

    /// Call this method to setup custom error handling for SwiftyMocky, that allows to gracefully handle missing stub fatal errors.
    /// In general it should be done automatically and there should be no reason to call it directly.
    @objc public static func setup() {
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

    /// [Internal] used to notify that stub return value was not found. Do not call it directly.
    ///
    /// - Parameters:
    ///   - message: Message
    ///   - file: File
    ///   - line: Line
    public static func handleMissingStubError(message: String, file: StaticString, line: UInt) {
        guard let testCase = SwiftyMockyTestObserver.currentTestCase else {
            XCTFail(message, file: file, line: line)
            return
        }

        let continueAfterFailure = testCase.continueAfterFailure
        defer { testCase.continueAfterFailure = continueAfterFailure }
        testCase.continueAfterFailure = false
        if let failingLine = FilesExlorer().findTestCaseLine(testCase: testCase, file: file) {
            testCase.recordFailure(withDescription: message, inFile: file.description, atLine: Int(failingLine), expected: false)
        } else {
            XCTFail(message, file: file, line: line)
        }
    }
}

/// [Internal] Internal dependency that looks for line of test case, that caused test failure.
private class FilesExlorer {
    /// Parses test case file to get line number assigned with test
    ///
    /// - Parameter testCase: Test case
    /// - Parameter file: File we should look in
    /// - Returns: Line number or nil, if unable to find
    func findTestCaseLine(testCase: XCTestCase, file: StaticString) -> UInt? {
        guard let content = getFileContent(file: file.description),
            let methodName = getNameOfExtecutedTestCase(testCase) else { return nil }
        let lines = content.components(separatedBy: "\n")
        let offset = lines.enumerated().first { (index, line) -> Bool in
            return line.contains(methodName)
            }?.offset
        guard let line = offset else { return nil }
        let lineAdditionalOffset: UInt = 2 // just to show error within test case, below the name.
        return UInt(line) + lineAdditionalOffset
    }

    private func getNameOfExtecutedTestCase(_ testCase: XCTestCase) -> String? {
        return testCase.name.components(separatedBy: " ")[1].components(separatedBy: "]").first
    }

    private func getFileContent(file: String) -> String? {
        // TODO: look for file encoding from file attributes
        guard let fileData = FileManager().contents(atPath: file) else { return nil }
        return String(data: fileData, encoding: .utf8)
    }
}
#else
public class SwiftyMockyTestObserver: NSObject {
    /// [Internal] No setup whatsoever
    @objc public static func setup() {
        // Empty on purpose
    }
}
#endif
