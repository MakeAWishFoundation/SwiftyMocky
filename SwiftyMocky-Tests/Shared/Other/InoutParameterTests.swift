//
//  InoutParameterTests.swift
//  Mocky
//
//  Created by Andrzej Michnia on 17/02/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import SwiftyMocky
#if os(iOS)
@testable import Mocky_Example_iOS
#elseif os(tvOS)
@testable import Mocky_Example_tvOS
#else
@testable import Mocky_Example_macOS
#endif

class InoutParameterTests: XCTestCase {

    func testBaseInoutTest() {
        let mock = InoutProtocolMock()

        Given(mock, .returnAndInOut(value: .any, willReturn: "0"))
        Given(mock, .returnAndInOut(value: 1, willReturn: "1"))
        Given(mock, .returnAndInOut(value: 2, willReturn: "2"))

        Verify(mock, .never, .returnAndInOut(value: .any))

        var value = 0
        XCTAssertEqual("0", mock.returnAndInOut(value: &value))
        value = 1
        XCTAssertEqual("1", mock.returnAndInOut(value: &value))
        value = 2
        XCTAssertEqual("2", mock.returnAndInOut(value: &value))
        value = 3
        XCTAssertEqual("0", mock.returnAndInOut(value: &value))

        Verify(mock, 4, .returnAndInOut(value: .any))
        Verify(mock, .once, .returnAndInOut(value: 2))
        Verify(mock, .never, .returnAndInOut(value: 5))
    }

    func testPerformWithInoutParams() {
        let mock = InoutProtocolMock()

        Given(mock, .returnAndInOut(value: .any, willReturn: "A"))
        Perform(mock, .returnAndInOut(value: .any, perform: { (value: inout Int) in
            value += 1
        }))

        var value = 0
        XCTAssertEqual(value, 0)
        XCTAssertEqual(mock.returnAndInOut(value: &value), "A")
        XCTAssertEqual(value, 1)
        XCTAssertEqual(mock.returnAndInOut(value: &value), "A")
        XCTAssertEqual(value, 2)
        XCTAssertEqual(mock.returnAndInOut(value: &value), "A")
        XCTAssertEqual(value, 3)
    }
}
