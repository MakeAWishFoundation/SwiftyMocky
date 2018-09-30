//
//  TestObserver.swift
//  Pods
//
//  Created by przemyslaw.wosko on 29/09/2018.
//

import Foundation
#if Mocky
import XCTest

public class SwiftyMockyTestObserver: NSObject, XCTestObservation {
    private static var currentTestCase: XCTestCase?
    private static let setupBlock: (() -> Void) = {
        XCTestObservationCenter.shared.addTestObserver(SwiftyMockyTestObserver())
        return {}
    }()

    /// Call this method to setup custom error handling for SwiftyMocky, that allows to gracefully handle missing stub fatal errors.
    @objc public static func setup() {
        setupBlock()
    }

    public func testCaseWillStart(_ testCase: XCTestCase) {
        SwiftyMockyTestObserver.currentTestCase = testCase
    }

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

private class CallStackWrapper {
    func findTestCaseLine(testCase: XCTestCase) -> UInt? {
        guard
            let testName = testCase.name.components(separatedBy: " ")[1].components(separatedBy: "]").first,
            let description = Thread.callStackSymbols.filter({ $0.contains(testName) }).last,
            let line = description.components(separatedBy: " + ").last else { return nil }
        return UInt(line)
    }
}
#else
public class SwiftyMockyTestObserver: NSObject {
    @objc public static func setup() {
        // Empty on purpose
    }
}
#endif
