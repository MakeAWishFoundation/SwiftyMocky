//
//  SubscriptsTests.swift
//  Mocky
//
//  Created by Andrzej Michnia on 28/09/2018.
//  Copyright © 2018 MakeAWishFoundation. All rights reserved.
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

class SubscriptsTests: XCTestCase {

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
        let mock = ProtocolWithSubscriptsMock()

        Given(mock, .subscript(with: .value([1,2,3]), willReturn: true))
        Given(mock, .subscript(with: .any([Int].self), willReturn: false))
        Given(mock, .subscript(with: .any([String].self), willReturn: true))

        XCTAssertTrue(mock[with: [1,2,3]])
        XCTAssertFalse(mock[with: [1,2]])
        XCTAssertFalse(mock[with: [2,6,7,8]])
        XCTAssertFalse(mock[with: [1]])
        XCTAssertTrue(mock[with: [""]])
        XCTAssertTrue(mock[with: [String]()])
    }

    func test_generic_setter_subscripts() {
        let mock = ProtocolWithSubscriptsMock()
        Matcher.default.register(CustomStruct.Type.self)
        Matcher.default.register(CustomStruct.self)

        mock[0,CustomStruct.self] = CustomStruct(value: 0)
        mock[1,CustomStruct.self] = CustomStruct(value: 1)
        mock[2,CustomStruct.self] = CustomStruct(value: 2)
        Verify(mock, 3, .subscript(.any, .any, set: .any(CustomStruct.self)))
        Verify(mock, 1, .subscript(0, .value(CustomStruct.self), set: .any))
        Verify(mock, 1, .subscript(.any, .value(CustomStruct.self), set: .value(CustomStruct(value: 0))))
        Verify(mock, 1, .subscript(.any, .value(CustomStruct.self), set: .value(CustomStruct(value: 1))))
        Verify(mock, 1, .subscript(.any, .value(CustomStruct.self), set: .value(CustomStruct(value: 2))))
    }

    func test_subscripts_verify_when_differ_only_in_return_type() {
        let mock = ProtocolWithSubscriptsMock()

        Given(mock, .subscript(same: 0, willReturn: true, false, true), .drop)
        Given(mock, .subscript(same: .any, willReturn: false))

        XCTAssertFalse(mock[same: 1])
        XCTAssertTrue(mock[same: 0])
        XCTAssertFalse(mock[same: 0])
        XCTAssertTrue(mock[same: 0])
        XCTAssertFalse(mock[same: 2])
        XCTAssertFalse(mock[same: 0])
        XCTAssertFalse(mock[same: 0])

        Given(mock, .subscript(same: 1, willReturn: 1,2,3))
        Given(mock, .subscript(same: .any, willReturn: 0))

        XCTAssertEqual(mock[same: 0], 0)
        XCTAssertEqual(mock[same: 1], 1)
        XCTAssertEqual(mock[same: 1], 2)
        XCTAssertEqual(mock[same: 1], 3)
        XCTAssertEqual(mock[same: 3], 0)
        XCTAssertEqual(mock[same: 1], 1)

        // See if we can tell them apart
        Verify(mock, 7, .subscript(same: .any, returning: Bool.self))
        Verify(mock, 5, .subscript(same: .value(0), returning: Bool.self))
        Verify(mock, .never, .subscript(same: 3, returning: Bool.self))

        Verify(mock, 6, .subscript(same: .any, returning: Int.self))
        Verify(mock, 4, .subscript(same: 1, returning: Int.self))
        Verify(mock, .never, .subscript(same: 2, returning: Int.self))
    }
}

struct CustomStruct: Equatable {
    let value: Int

    static func == (lhs: CustomStruct, rhs: CustomStruct) -> Bool {
        return lhs.value == rhs.value
    }
}
