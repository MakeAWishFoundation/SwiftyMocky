//
//  ProtocolsWithCollectionsTests.swift
//  Mocky_Tests
//
//  Created by Andrzej Michnia on 16.11.2017.
//  Copyright © 2017 MakeAWishFoundation. All rights reserved.
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

class ProtocolsWithCollectionsTests: XCTestCase {
    
    func test_protocol_with_array() {
        let mock = SimpleProtocolUsingCollectionsMock()

        // When handling sequence of equatable, all works by default
        Given(mock, .getArray(willReturn: [1,2,3]))
        XCTAssertEqual(mock.getArray(), [1,2,3])
        Verify(mock, .getArray())

        // First always handle most explicit given
        Given(mock, .map(array: .value(["a","b","c"]), param: .value(1), willReturn: [1:"1abc"]))
        // If two have same level of explicity, order of setup matters (LIFO)
        Given(mock, .map(array: .value(["a","b","c"]), param: .any, willReturn: [1:"abc"]))
        Given(mock, .map(array: .any, param: .value(1), willReturn: [1:"1"]))

        XCTAssertEqual(mock.map(array: ["a","b","c"], param: 1)[1], "1abc")
        XCTAssertEqual(mock.map(array: ["any array"], param: 1)[1], "1")
        XCTAssertEqual(mock.map(array: ["a","b","c"], param: 2)[1], "abc")

        Verify(mock, 3, .map(array: .any, param: .any)) // total three invocations should be performed
    }

    func test_protocol_with_set() {
        let mock = SimpleProtocolUsingCollectionsMock()

        // Set<Int> is a Sequence of equatable, so it should work by default
        Given(mock, .verify(set: .value(Set<Int>(arrayLiteral: 1,2,3)), willReturn: true))
        Given(mock, .verify(set: .any, willReturn: false))

        XCTAssertEqual(mock.verify(set: Set<Int>(arrayLiteral: 1,2,3)), true)
        XCTAssertEqual(mock.verify(set: Set<Int>(arrayLiteral: 1,2,4)), false)
        XCTAssertEqual(mock.verify(set: Set<Int>(arrayLiteral: 0)), false)

        Verify(mock, 3, .verify(set: .any))
    }

    func test_protocol_with_dictionary() {
        let mock = SimpleProtocolUsingCollectionsMock()

#if swift(>=4.1)
#else
        Matcher.default.register([Int: String].Element.self) { $0 == $1 }
#endif

        // Set<Int> is a Sequence of equatable, so it should work by default
        Given(mock, .use(dictionary: .value([1:"abc"]), willReturn: [2:"def"]))
        Given(mock, .use(dictionary: .any, willReturn: [0:""]))

        XCTAssertEqual(mock.use(dictionary: [1:"abc"]), [2:"def"])
        XCTAssertEqual(mock.use(dictionary: [1:"abcd"]), [0:""])
        XCTAssertEqual(mock.use(dictionary: [2:"qwert"]), [0:""])

        Verify(mock, 3, .use(dictionary: .any))
    }
}
