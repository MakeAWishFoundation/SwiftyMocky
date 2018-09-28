//
//  SubscriptsTests.swift
//  Mocky
//
//  Created by Andrzej Michnia on 28/09/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import SwiftyMocky
#if os(iOS)
@testable import Mocky_Example_iOS
#elseif os(tvOS)
@testable import Mocky_Example_tvOS
#elseif os(macOS)
@testable import Mocky_Example_macOS
#endif

class SubscriptsTests: SwiftyTestCase {
    func test_basic_subscript_usage() {
        let mock = ProtocolWithSubscriptsMock()

        Given(mock, .subscript(.any(Int.self), willReturn: ""))
        Given(mock, .subscript(0, willReturn: "0"))
        Given(mock, .subscript(1, willReturn: "1"))
        Given(mock, .subscript(2, willReturn: "2"))

        Verify(mock, .never, .subscript(.any(Int.self)))

        XCTAssertEqual(mock[0], "0")
        XCTAssertEqual(mock[1], "1")
        XCTAssertEqual(mock[2], "2")
        XCTAssertEqual(mock[3], "")
        XCTAssertEqual(mock[4], "")

        Verify(mock, 5, .subscript(.any(Int.self)))
        Verify(mock, .subscript(0))
        Verify(mock, .subscript(1))
        Verify(mock, .subscript(2))
        Verify(mock, .subscript(3))
        Verify(mock, .subscript(4))
    }

    func test_multi_argument_subscript_usage() {
        let mock = ProtocolWithSubscriptsMock()

        Given(mock, .subscript(.any, .any, willReturn: ""))
        Given(mock, .subscript(.matching({ $0 < 0 }), .any, willReturn: "left half"))
        Given(mock, .subscript(.matching({ $0 > 0 }), .any, willReturn: "right half"))
        Given(mock, .subscript(0, .any, willReturn: "on y axis"))
        Given(mock, .subscript(0, 0, willReturn: "point zero"))

        Verify(mock, .never, .subscript(.any, .any))

        XCTAssertEqual(mock[0,0], "point zero")
        XCTAssertEqual(mock[-1,1], "left half")
        XCTAssertEqual(mock[0,3], "on y axis")
        XCTAssertEqual(mock[3,2], "right half")

        Verify(mock, 4, .subscript(.any, .any))
        Verify(mock, 2, .subscript(0, .any))
    }

    func test_generic_subscripts() {
        
    }
}
