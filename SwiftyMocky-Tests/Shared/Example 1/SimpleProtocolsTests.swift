//
//  SimpleProtocolsTests.swift
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
#elseif os(macOS)
    @testable import Mocky_Example_macOS
#endif

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
        Verify(mock, .never, .simpleMehtodThatReturns())

        Given(mock, .simpleMehtodThatReturns(willReturn: 0))
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 0, "Should return 0")

        Given(mock, .simpleMehtodThatReturns(willReturn: 3))
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 3, "Should return 3")

        mock.given(.simpleMehtodThatReturns(willReturn: -15)) // Can use given directy on mock instance
        XCTAssertEqual(mock.simpleMehtodThatReturns(), -15, "Should return -15")

        Verify(mock, 3, .simpleMehtodThatReturns())
        mock.verify(.simpleMehtodThatReturns(), count: 3) // Can use vrify directly on mock instance
    }

    func test_simpleProtocol_methodThatReturns_attributes_verifyMatching() {
        let mock = SimpleProtocolWithMethodsMock()

        Verify(mock, 0, .simpleMehtodThatReturns(param: .any)) // Should be 0

        Given(mock, .simpleMehtodThatReturns(param: .matching({ $0.contains("a") }), willReturn: "1"))
        Given(mock, .simpleMehtodThatReturns(param: .matching({ $0 == "aaa" }), willReturn: "3"))
        Given(mock, .simpleMehtodThatReturns(param: .any, willReturn: "no a at all"))

        XCTAssertEqual(mock.simpleMehtodThatReturns(param: "qqq"), "no a at all")
        XCTAssertEqual(mock.simpleMehtodThatReturns(param: "aaa"), "3")
        XCTAssertEqual(mock.simpleMehtodThatReturns(param: "aas"), "1")
        XCTAssertEqual(mock.simpleMehtodThatReturns(param: "Makaron"), "1")
        XCTAssertEqual(mock.simpleMehtodThatReturns(param: "kotlet"), "no a at all")

        Verify(mock, 2, .simpleMehtodThatReturns(param: .matching({ $0.count > 3 })))
        Verify(mock, 3, .simpleMehtodThatReturns(param: .matching({ $0.count == 3 })))
        Verify(mock, 5, .simpleMehtodThatReturns(param: .any))
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

        // Can use explicit values, or Count convenience static members as Count
        // Check property getters invocations
        Verify(mock, 0, .property)

        Verify(mock, .never, .property)
        // Check property setters invocations
        Verify(mock, .never, .property(set: .any))

        // We should set all initial values for non optional parameters and implicitly unwrapped optional parameters
        mock.property = "test"
        Given(mock, .propertyGetOnly(getter: "get only ;)"))
        Given(mock, .propertyOptional(getter: nil))
        mock.propertyImplicit = 1

        Verify(mock, .atLeastOnce, .property(set: .any))
        Verify(mock, .atLeastOnce, .property(set: .value("test")))

        XCTAssertEqual(mock.property, "test")
        XCTAssertEqual(mock.propertyGetOnly, "get only ;)")
        XCTAssertEqual(mock.propertyOptional, nil)
        XCTAssertEqual(mock.propertyImplicit, 1)

        // Verify getters were called

        // Verify setters with different cases
        for i in 1...3 {
            mock.propertyOptional = i
        }
        Verify(mock, 3, .propertyOptional(set: .any)) // Verify setter called exactly 3 times
        Verify(mock, .more(than: 2), .propertyOptional(set: .any))
        Verify(mock, .never, .propertyOptional(set: .value(0)))

        // Verify using mathcing
        mock.propertyImplicit = 2
        mock.propertyImplicit = 5
        mock.propertyImplicit = 7
        // Verify, that for given mock, with specific count, property get or set was called (with attributes matching)
        Verify(mock, .less(than: 2), .propertyImplicit(set: .matching({ $0! < 2 })))
        Verify(mock, .moreOrEqual(to: 4), .propertyImplicit(set: .matching({ $0! > 0 })))
        XCTAssertEqual(mock.propertyImplicit, 7)
    }

    func test_simpleProtocol_with_both() {
        let mock = SimpleProtocolWithBothMethodsAndPropertiesMock()

        // We should set all initial values for all parameters that will be used
        Given(mock, .property(getter: "some property"))
        Given(mock, .simpleMethod(willReturn: "some return value"))

        XCTAssertEqual(mock.property, "some property")
        XCTAssertEqual(mock.simpleMethod(), "some return value")

        Verify(mock, .simpleMethod())
        Verify(mock, .property)
        Given(mock, .simpleMethod(willReturn: "a","b","c","d"))
        XCTAssertEqual(mock.simpleMethod(), "a")
        XCTAssertEqual(mock.simpleMethod(), "b")
        XCTAssertEqual(mock.simpleMethod(), "c")
        XCTAssertEqual(mock.simpleMethod(), "d")
        XCTAssertEqual(mock.simpleMethod(), "a")
        XCTAssertEqual(mock.simpleMethod(), "b")
        XCTAssertEqual(mock.simpleMethod(), "c")
        XCTAssertEqual(mock.simpleMethod(), "d")
    }

    func test_simpleProtocol_that_inherits() {
        let mock = SimpleProtocolThatInheritsOtherProtocolsMock()

        Verify(mock, 0, .simpleMethod()) // Should be 0

        mock.simpleMethod()
        Verify(mock, .simpleMethod()) // Should be 1+

        mock.simpleMethod()
        mock.simpleMethod()
        mock.simpleMethod()

        Verify(mock, .simpleMethod()) // Should be 1+
        Verify(mock, 4, .simpleMethod()) // Should be invoked exactly 4 times

        // Can use explicit values, or Count convenience static members as Count
        // Check property getters invocations
        Verify(mock, 0, .property)

        Verify(mock, .never, .property)
        // Check property setters invocations
        Verify(mock, .never, .property(set: .any))

        // We should set all initial values for non optional parameters and implicitly unwrapped optional parameters
        mock.property = "test"
        Given(mock, .propertyGetOnly(getter: "get only ;)"))
        Given(mock, .propertyOptional(getter: nil))
        mock.propertyImplicit = 1

        Verify(mock, .atLeastOnce, .property(set: .any))
        Verify(mock, .atLeastOnce, .property(set: .value("test")))

        XCTAssertEqual(mock.property, "test")
        XCTAssertEqual(mock.propertyGetOnly, "get only ;)")
        XCTAssertEqual(mock.propertyOptional, nil)
        XCTAssertEqual(mock.propertyImplicit, 1)

        // Verify getters were called

        // Verify setters with different cases
        for i in 1...3 {
            mock.propertyOptional = i
        }
        Verify(mock, 3, .propertyOptional(set: .any)) // Verify setter called exactly 3 times
        Verify(mock, .more(than: 2), .propertyOptional(set: .any))
        Verify(mock, .never, .propertyOptional(set: .value(0)))

        // Verify using mathcing
        mock.propertyImplicit = 2
        mock.propertyImplicit = 5
        mock.propertyImplicit = 7
        // Verify, that for given mock, with specific count, property get or set was called (with attributes matching)
        Verify(mock, .less(than: 2), .propertyImplicit(set: .matching({ $0! < 2 })))
        Verify(mock, .moreOrEqual(to: 4), .propertyImplicit(set: .matching({ $0! > 0 })))
        XCTAssertEqual(mock.propertyImplicit, 7)
    }
}
