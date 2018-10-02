//
//  ProtocolWithInitializersTests.swift
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

class ProtocolWithInitializersTests: XCTestCase {
    func test_protocol_with_initializers() {
        // You can use all defined initializers
        let mock1 = ProtocolWithInitializersMock(param: 1)
        let mock2 = ProtocolWithInitializersMock(param: 2, other: "something")

        // Please hav in mind, that they are only to satisfy protocol requirements
        // there is no logic behind that, and so all properties has to be set manually anyway
        Given(mock1, .param(getter: 1))
        Given(mock1, .other(getter: ""))
        XCTAssertEqual(mock1.param, 1)
        XCTAssertEqual(mock1.other, "")
        Given(mock2, .param(getter: 2))
        Given(mock2, .other(getter: "something"))
        XCTAssertEqual(mock2.param, 2)
        XCTAssertEqual(mock2.other, "something")
    }
}
