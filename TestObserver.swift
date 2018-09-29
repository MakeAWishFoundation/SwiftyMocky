//
//  TestObserver.swift
//  Pods
//
//  Created by przemyslaw.wosko on 29/09/2018.
//

import Foundation
import XCTest

public class TestObserver: NSObject, XCTestObservation {
    // This init is called first thing as the test bundle starts up and before any test
    // initialization happens
    public override init() {
        super.init()
        // We don't need to do any real work, other than register for callbacks
        // when the test suite progresses.
        // XCTestObservation keeps a strong reference to observers
        XCTestObservationCenter.shared.addTestObserver(TestObserver())

    }

    func testCaseWillStart(_ testCase: XCTestCase) {

    }

    var duplicated: [String?: Int] = [:]

    //    func testCase(_ testCase: XCTestCase, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: Int) {
    //
    //        let testName = testCase.name.components(separatedBy: " ")[1].components(separatedBy: "]").first!
    //        let description = Thread.callStackSymbols.filter({ $0.contains(testName) }).last!
    //        let line = description.components(separatedBy: " + ").last!
    //        let fileLine = Int(line)!
    //        if !duplicated.contains(where: { $0.key == filePath && $0.value == lineNumber }) { // TODO: Remove that faulty logic
    //            duplicated[filePath] = lineNumber
    //            testCase.recordFailure(withDescription: description, inFile: filePath!, atLine: fileLine, expected: false)
    //        }
    //    }

    func testCaseDidFinish(_ testCase: XCTestCase) {

    }
}
