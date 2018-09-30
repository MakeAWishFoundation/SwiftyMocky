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
        if let failingLine = CallStackWrapper().findTestCaseLine(testCase: testCase) {
            testCase.recordFailure(withDescription: message, inFile: file.description, atLine: Int(failingLine), expected: false)
        } else {
            XCTFail(message, file: file, line: line)
        }
    }
}

/// [Internal] Wrapper for parsing call stack to get relevant line number
private class CallStackWrapper {
    /// Parses call stack symbols to get line number assigned with test
    ///
    /// - Parameter testCase: Test case
    /// - Returns: Line number or nil, if unable to find
    func findTestCaseLine(testCase: XCTestCase) -> UInt? {
        guard
            let testName = testCase.name.components(separatedBy: " ")[1].components(separatedBy: "]").first,
            let description = Thread.callStackSymbols.filter({ $0.contains(testName) }).last,
            let line = description.components(separatedBy: " + ").last else { return nil }
        return UInt(line)
    }
}
#else
@available(*, unavailable, message: "Test observer is only available when using SwiftyMocky in Test target!")
public class SwiftyMockyTestObserver: NSObject {
    /// [Internal] No setup whatsoever
    @available(*, unavailable, message: "Test observer is only available when using SwiftyMocky in Test target!")
    @objc public static func setup() {
        // Empty on purpose
    }
}
#endif
