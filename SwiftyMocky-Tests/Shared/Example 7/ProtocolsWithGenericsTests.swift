//
//  ProtocolsWithGenericsTests.swift
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
#else
    @testable import Mocky_Example_macOS
#endif

class ProtocolsWithGenericsTests: XCTestCase {

    func test_protocol_with_generic_methods() {
        let mock = ProtocolWithGenericMethodsMock()

        // For generics - you have to use .any(ValueType.Type) to avoid ambiguity
        Given(mock, .methodWithGeneric(lhs: .any(Int.self), rhs: .any(Int.self), willReturn: false))
        Given(mock, .methodWithGeneric(lhs: .any(String.self), rhs: .any(String.self), willReturn: true))
        // In that case it is enough to specify type for only one elemen, so the type inference could do the rest
        Given(mock, .methodWithGeneric(lhs: .value(1), rhs: .any, willReturn: true))

        XCTAssertEqual(mock.methodWithGeneric(lhs: 1, rhs: 0), true)
        XCTAssertEqual(mock.methodWithGeneric(lhs: 0, rhs: 1), false)
        XCTAssertEqual(mock.methodWithGeneric(lhs: "0", rhs: "1"), true)

        // Same applies to verify - specify type to avoid ambiguity
        Verify(mock, 2, .methodWithGeneric(lhs: .any(Int.self), rhs: .any(Int.self)))
        Verify(mock, 1, .methodWithGeneric(lhs: .any(String.self), rhs: .any(String.self)))
    }

    func test_protocol_with_associated_types() {
        let mock = ProtocolWithAssociatedTypeMock<[Int]>()
        Given(mock, .sequence(getter: [1,2,3]))

        // There is autocomplete issue, so in order to get autocomplete for all available methods
        // Use full <MockName>.Given. ... syntax
        Given(mock, ProtocolWithAssociatedTypeMock.Given.methodWithType(t: .any, willReturn: false))
        // It works slightly better, when using given directly on mock instance
        mock.given(ProtocolWithAssociatedTypeMock<[Int]>.Given.methodWithType(t: .value([1,1,1]), willReturn: true))

        XCTAssertTrue(mock.methodWithType(t: [1,1,1]))
        XCTAssertFalse(mock.methodWithType(t: [2,2]))

        // Similar here
        Verify(mock, ProtocolWithAssociatedTypeMock.Verify.methodWithType(t: .value([1,1,1])))
        // And also here, using method on instance works slightly better when comes to types inference
        mock.verify(ProtocolWithAssociatedTypeMock<[Int]>.Verify.methodWithType(t: .value([2,2])))
    }
}
