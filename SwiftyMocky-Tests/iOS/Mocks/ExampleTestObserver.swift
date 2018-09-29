//
//  ExampleTestObserver.swift
//  Mocky_Tests_iOS
//
//  Created by przemyslaw.wosko on 29/09/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import XCTest

public class ExampleTestObserver: NSObject, XCTestObservation {
    // This init is called first thing as the test bundle starts up and before any test

    private static var currentTestCase: XCTestCase?

    static public func setup() {
        XCTestObservationCenter.shared.addTestObserver(ExampleTestObserver())
    }

    public func testCaseWillStart(_ testCase: XCTestCase) {
        ExampleTestObserver.currentTestCase = testCase
    }

    public func testCaseDidFinish(_ testCase: XCTestCase) {
        ExampleTestObserver.currentTestCase = nil
    }

    static func handleMissingStubError(message: String, file: StaticString, line: UInt) {

        guard let testCase = ExampleTestObserver.currentTestCase else { return }
        let continueAfterFailure = testCase.continueAfterFailure
        defer { testCase.continueAfterFailure = continueAfterFailure }
        testCase.continueAfterFailure = false
        if let failingLine = CallStackWrapper().findTestCaseLine(testCase: testCase) {
            testCase.recordFailure(withDescription: message, inFile: file.description, atLine: Int(failingLine), expected: false)
            XCTFail(message, file: file, line: line)
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
