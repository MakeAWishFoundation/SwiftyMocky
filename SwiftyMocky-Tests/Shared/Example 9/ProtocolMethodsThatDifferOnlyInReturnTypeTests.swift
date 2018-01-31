//
//  ProtocolMethodsThatDifferOnlyInReturnTypeTests.swift
//  Mocky
//
//  Created by Andrzej Michnia on 31.01.2018.
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

class ProtocolMethodsThatDifferOnlyInReturnTypeTests: XCTestCase {
    func test_simple_case() {
        let mock = ProtocolMethodsThatDifferOnlyInReturnTypeMock()

        Given(mock, .foo(bar: .any, willReturn: 1))
        Given(mock, .foo(bar: .value("sth"), willReturn: 2))
        Given(mock, .foo(bar: .any, willReturn: "any"))

        Verify(mock, .never, .foo(bar: .any, returning: Int.self))
        Verify(mock, .never, .foo(bar: .any, returning: String.self))

        XCTAssertEqual(mock.foo(bar: "aaa"), 1)

        Verify(mock, 1, .foo(bar: .any, returning: Int.self))
        Verify(mock, .never, .foo(bar: .any, returning: String.self))

        XCTAssertEqual(mock.foo(bar: "sth"), 2)
        XCTAssertEqual(mock.foo(bar: "sth"), "any")

        Verify(mock, 2, .foo(bar: .any, returning: Int.self))
        Verify(mock, 1, .foo(bar: .any, returning: String.self))
    }
}
