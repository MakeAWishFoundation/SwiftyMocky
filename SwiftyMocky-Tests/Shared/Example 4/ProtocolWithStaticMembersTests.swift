//
//  ProtocolWithStaticMembersTests.swift
//  Mocky_Tests
//
//  Created by Andrzej Michnia on 17.11.2017.
//  Copyright © 2017 MakeAWishFoundation. All rights reserved.
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

class ProtocolWithStaticMembersTests: XCTestCase {
    func test_protocol_with_static() {
        // Static members are handled similar way - but instead of instance
        // you pass its type to Verify and Given calls

        // Static properties should be set with default values - same as with instance ones
        Given(ProtocolWithStaticMembersMock.self, .staticProperty(getter: "value"))
        Given(ProtocolWithStaticMembersMock.self, .staticMethod(param: .value(0), willReturn: 1))
        Given(ProtocolWithStaticMembersMock.self, .staticMethod(param: .value(1), willReturn: 2))
        Given(ProtocolWithStaticMembersMock.self, .staticMethod(param: .any, willThrow: SimpleTestError.failure))

        XCTAssertEqual(ProtocolWithStaticMembersMock.staticProperty, "value")
        XCTAssertEqual(try? ProtocolWithStaticMembersMock.staticMethod(param: 0), 1)
        XCTAssertEqual(try? ProtocolWithStaticMembersMock.staticMethod(param: 1), 2)
        XCTAssertThrowsError(try ProtocolWithStaticMembersMock.staticMethod(param: -3))
        XCTAssertThrowsError(try ProtocolWithStaticMembersMock.staticMethod(param: 2))

        Verify(ProtocolWithStaticMembersMock.self, 4, .staticMethod(param: .any))
    }
}
