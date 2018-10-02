//
//  PropertiesHandlingTests.swift
//  Mocky
//
//  Created by Andrzej Michnia on 25/09/2018.
//  Copyright © 2018 MakeAWishFoundation. All rights reserved.
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

class PropertiesHandlingTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_simple_given_scenario() {
        let mock = SimpleProtocolWithBothMethodsAndPropertiesMock()

        Verify(mock, .never, .property) // Verify we start with fresh counter
        Given(mock, .property(getter: "1","2","3"))
        Verify(mock, .never, .property) // Check if given do not change count
        XCTAssertEqual(mock.property, "1")
        Verify(mock, 1, .property)
        XCTAssertEqual(mock.property, "2")
        XCTAssertEqual(mock.property, "3")
        XCTAssertEqual(mock.property, "1")
        Verify(mock, 4, .property)
    }

    func test_property_drop_policy_fails() {
        let mock = SimpleProtocolWithPropertiesMock()

        Given(mock, .property(getter: "1", "2", "nextWillFail"), .drop)

        XCTAssertFalse(mock.property.isEmpty)
        XCTAssertFalse(mock.property.isEmpty)
        XCTAssertFalse(mock.property.isEmpty)
//        XCTAssertFalse(mock.property.isEmpty) // if uncommented this will fail - that's correct behaviour
    }

    func test_property_given_policy() {
        let mock = SimpleProtocolWithPropertiesMock(stubbing: .drop)

        Given(mock, .weakProperty(getter: nil), .wrap)
        Verify(mock, .never, .weakProperty)

        for _ in 1...20 {
            XCTAssert(mock.weakProperty == nil)
        }

        Verify(mock, 20, .weakProperty)
    }

    func test_property_setter_always_overrides_given() {
        let mock = SimpleProtocolWithPropertiesMock()

        Given(mock, .property(getter: "a", "b", "never here"))

        XCTAssertEqual(mock.property, "a")
        XCTAssertEqual(mock.property, "b")
        mock.property = "if set, always override given. That's how properties work. Set is set"
        XCTAssertNotEqual(mock.property, "never here")
        XCTAssertNotEqual(mock.property, "never here")
        XCTAssertNotEqual(mock.property, "never here")
        XCTAssertNotEqual(mock.property, "never here")
        XCTAssertNotEqual(mock.property, "never here")
        XCTAssertNotEqual(mock.property, "never here")

        Verify(mock, 1, .property(set: .any))
    }
}
