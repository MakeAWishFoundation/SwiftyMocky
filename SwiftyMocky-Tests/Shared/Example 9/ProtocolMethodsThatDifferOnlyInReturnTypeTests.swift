//
//  ProtocolMethodsThatDifferOnlyInReturnTypeTests.swift
//  Mocky
//
//  Created by Andrzej Michnia on 31.01.2018.
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

    func test_generic_case() {
        let mock = ProtocolMethodsGenericThatDifferOnlyInReturnTypeMock()

        Matcher.default.register(A.self) { lhs,rhs in
            return lhs.id == rhs.id
        }
        Matcher.default.register(B.self) { lhs,rhs in
            return lhs.id == rhs.id
        }

        Given(mock, .foo(bar: .any(A.self), willReturn: Float(0)))
        Given(mock, .foo(bar: .any(B.self), willReturn: Double(1)))
        Given(mock, .foo(bar: .any(Int.self), willReturn: 3))
        Given(mock, .foo(bar: .any(String.self), willReturn: [1, 2]))
        Given(mock, .foo(bar: .any(String.self), willReturn: [1, 2, 3] as Set))

        Verify(mock, .never, .foo(bar: .any(A.self), returning: Float.self))
        Verify(mock, .never, .foo(bar: .any(Int.self), returning: Int.self))
        Verify(mock, .never, .foo(bar: .any(String.self), returning: [Int].self))
        Verify(mock, .never, .foo(bar: .any(String.self), returning: Set<Int>.self))

        let v1: Float = mock.foo(bar: A(0))
        XCTAssertEqual(v1, 0)
        let v2: Double = mock.foo(bar: B(1))
        XCTAssertEqual(v2, 1)
        let v3: Set<Int> = mock.foo(bar: "0")
        XCTAssertEqual(v3, [1, 2, 3])

        Verify(mock, 1, .foo(bar: .any(A.self), returning: Float.self))
        Verify(mock, .never, .foo(bar: .any(Int.self), returning: Int.self))
        Verify(mock, .never, .foo(bar: .any(String.self), returning: [Int].self))
        Verify(mock, 1, .foo(bar: .any(String.self), returning: Set<Int>.self))
    }
}
