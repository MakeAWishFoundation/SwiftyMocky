//
//  TestObserver.swift
//  Pods
//
//  Created by przemyslaw.wosko on 29/09/2018.
//

import Foundation
import XCTest

public class SwiftyMockyTestObserver: NSObject, XCTestObservation {

    private static var currentTestCase: XCTestCase?

    private static let setupBlock: (() -> Void) = {
        XCTestObservationCenter.shared.addTestObserver(SwiftyMockyTestObserver())
        return {}
    }()

    /// Call this method to setup custom error handling for SwiftyMocky, that allows to gracefully handle missing stub fatal errors.
    /// May be called multiple times, recommended to set this up in Principal class for Unit test bundle, but can be also called in test case SetUp method.
    @objc public static func setup() {
        setupBlock()
    }

    public func testCaseWillStart(_ testCase: XCTestCase) {
        SwiftyMockyTestObserver.currentTestCase = testCase
    }

    public func testCaseDidFinish(_ testCase: XCTestCase) {
        SwiftyMockyTestObserver.currentTestCase = nil
    }

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

fileprivate class CallStackWrapper {

    func findTestCaseLine(testCase: XCTestCase) -> UInt? {
        guard
            let testName = testCase.name.components(separatedBy: " ")[1].components(separatedBy: "]").first,
            let description = Thread.callStackSymbols.filter({ $0.contains(testName) }).last,
            let line = description.components(separatedBy: " + ").last else { return nil }
        return UInt(line)
    }
}
