//
//  SimpleProtocolsTests.swift
//  Mocky_Tests
//
//  Created by Andrzej Michnia on 16.11.2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import SwiftyMocky
@testable import Mocky_Example

class SimpleProtocolsTests: XCTestCase {
    func test_simpleProtocol_simpleMethod() {
        let mock = SimpleProtocolWithMethodsMock()

        Verify(mock, 0, .simpleMethod()) // Should be 0

        mock.simpleMethod()
        Verify(mock, .simpleMethod()) // Should be 1+

        mock.simpleMethod()
        mock.simpleMethod()
        mock.simpleMethod()

        Verify(mock, .simpleMethod()) // Should be 1+
        Verify(mock, 4, .simpleMethod()) // Should be invoked exactly 4 times
    }

    func test_simpleProtocol_methodThatReturns() {
        let mock = SimpleProtocolWithMethodsMock()

        Verify(mock, 0, .simpleMehtodThatReturns()) // Should be 0

        Given(mock, .simpleMehtodThatReturns(willReturn: 0))
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 0, "Should return 0")

        Given(mock, .simpleMehtodThatReturns(willReturn: 3))
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 3, "Should return 3")

        mock.given(.simpleMehtodThatReturns(willReturn: -15)) // Can use given directy on mock instance
        XCTAssertEqual(mock.simpleMehtodThatReturns(), -15, "Should return -15")

        Verify(mock, 3, .simpleMehtodThatReturns())
        mock.verify(.simpleMehtodThatReturns(), count: 3) // Can use vrify directly on mock instance
    }

    func test_simpleProtocol_methodsThatReturns_attributes() {
        let mock = SimpleProtocolWithMethodsMock()

        Verify(mock, 0, .simpleMehtodThatReturns(param: .any)) // Should be 0

        // Regardless of registrations order, first will check most explicit given values
        Given(mock, .simpleMehtodThatReturns(param: .value("a"), willReturn: "A"))
        Given(mock, .simpleMehtodThatReturns(param: .value("b"), willReturn: "B"))
        Given(mock, .simpleMehtodThatReturns(param: .any, willReturn: "default"))

        XCTAssertEqual(mock.simpleMehtodThatReturns(param: "any parameter"), "default")
        XCTAssertEqual(mock.simpleMehtodThatReturns(param: "a"), "A")
        XCTAssertEqual(mock.simpleMehtodThatReturns(param: "b"), "B")
        XCTAssertEqual(mock.simpleMehtodThatReturns(param: "any parameter"), "default")

        Verify(mock, 4, .simpleMehtodThatReturns(param: .any)) // Total method invocations count should be 4
        Verify(mock, 2, .simpleMehtodThatReturns(param: .value("any parameter"))) // Should be called twice wth "any parameter"
        Verify(mock, 1, .simpleMehtodThatReturns(param: .value("a")))
        Verify(mock, 1, .simpleMehtodThatReturns(param: .value("b")))
    }

    func test_simpleProtocol_methodsThatReturns_optionalAttributes() {
        let mock = SimpleProtocolWithMethodsMock()

        Verify(mock, 0, .simpleMehtodThatReturns(optionalParam: .any)) // Should be 0

        // When same level of explicity - last given is matched first
        Given(mock, .simpleMehtodThatReturns(optionalParam: .value(nil), willReturn: nil))
        XCTAssertEqual(mock.simpleMehtodThatReturns(optionalParam: nil), nil)
        Given(mock, .simpleMehtodThatReturns(optionalParam: .value("some"), willReturn: "not nil"))
        Given(mock, .simpleMehtodThatReturns(optionalParam: .value(nil), willReturn: "is nil"))

        XCTAssertNotEqual(mock.simpleMehtodThatReturns(optionalParam: nil), nil)
        XCTAssertEqual(mock.simpleMehtodThatReturns(optionalParam: nil), "is nil")
        XCTAssertEqual(mock.simpleMehtodThatReturns(optionalParam: "some"), "not nil")

        Verify(mock, 4, .simpleMehtodThatReturns(optionalParam: .any))
        Verify(mock, 3, .simpleMehtodThatReturns(optionalParam: .value(nil)))
    }

    func test_simpleProtocol_with_properties() {
        let mock = SimpleProtocolWithPropertiesMock()

        // We should set all initial values for non optional parameters and implicitly unwrapped optional parameters
        mock.property = "some property"
        mock.propertyGetOnly = "get only ;)"
        mock.propertyImplicit = 1

        XCTAssertEqual(mock.property, "some property")
        XCTAssertEqual(mock.propertyGetOnly, "get only ;)")
        XCTAssertEqual(mock.propertyOptional, nil)
        XCTAssertEqual(mock.propertyImplicit, 1)

        mock.propertyOptional = 2
        XCTAssertEqual(mock.propertyOptional, 2)
    }

    func test_simpleProtocol_with_both() {
        let mock = SimpleProtocolWithBothMethodsAndPropertiesMock()

        // We should set all initial values for non optional parameters and implicitly unwrapped optional parameters
        mock.property = "some property"
        Given(mock, .simpleMethod(willReturn: "some return value"))

        XCTAssertEqual(mock.property, "some property")
        XCTAssertEqual(mock.simpleMethod(), "some return value")

        Verify(mock, .simpleMethod())
    }
}
