//
//  ProtocolsWithCustomAttributesTests.swift
//  Mocky_Tests
//
//  Created by Andrzej Michnia on 16.11.2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import SwiftyMocky
@testable import Mocky_Example

enum UserVerifyError: Error {
    case tooYoung
}

class ProtocolsWithCustomAttributesTests: XCTestCase {
    func test_protocol_using_tuples() {
        let mock = ProtocolWithTuplesMock()

        // When using only .any - no matcher registering needed
        Given(mock, .methodThatTakesTuple(tuple: .any, willReturn: 0))
        XCTAssertEqual(mock.methodThatTakesTuple(tuple: ("first",1)), 0)

        // When using custom attributes or tuples as .value(...) - registering comparator in Matcher is required!
        Matcher.default.register((String,Int).self) { (lhs, rhs) -> Bool in
            return lhs.0 == rhs.0 && lhs.1 == rhs.1
        }

        Given(mock, .methodThatTakesTuple(tuple: .value(("first",1)), willReturn: 1))
        Given(mock, .methodThatTakesTuple(tuple: .value(("second",2)), willReturn: 2))
        XCTAssertEqual(mock.methodThatTakesTuple(tuple: ("first",1)), 1)
        XCTAssertEqual(mock.methodThatTakesTuple(tuple: ("second",2)), 2)
        XCTAssertEqual(mock.methodThatTakesTuple(tuple: ("first",0)), 0)

        Verify(mock, 4, .methodThatTakesTuple(tuple: .any))
        Verify(mock, 2, .methodThatTakesTuple(tuple: .value(("first",1))))
    }

    func test_protocol_using_customAttributes() {
        let mock = ProtocolWithCustomAttributesMock()

        // Register comparator for CGPoint
        Matcher.default.register(CGPoint.self) { $0.x == $0.y && $0.y == $1.y }

        Given(mock, .methodWith(point: .value(.zero), willReturn: 0))
        Given(mock, .methodWith(point: .value(CGPoint(x: 1, y: 1)), willReturn: 1))
        XCTAssertEqual(mock.methodWith(point: CGPoint.zero), 0)
        XCTAssertEqual(mock.methodWith(point: CGPoint(x: 1, y: 1)), 1)

        // Register comparing user object
        // We can use registration for Array of elements, which will compare value by value
        // Also, providing by default comparator for element type
        Matcher.default.register([UserObject].self) { (lhs: UserObject, rhs: UserObject) -> Bool in
            guard lhs.name == rhs.name else { return false }
            guard lhs.surname == rhs.surname else { return false }
            guard lhs.age == rhs.age else { return false }
            return true
        }

        let user1 = UserObject(name: "Karl", surname: "Gustav", age: 90)
        let user2 = UserObject(name: "Dan", surname: "Dannerson", age: 13)
        Given(mock, .methodThatTakesUser(user: .value(user2), willThrow: UserVerifyError.tooYoung))
        Given(mock, .methodThatTakesArrayOfUsers(array: .any, willReturn: 0))
        Given(mock, .methodThatTakesArrayOfUsers(array: .value([user1, user2]), willReturn: 2))

        XCTAssertNoThrow(try mock.methodThatTakesUser(user: user1), "Should not throw")
        XCTAssertThrowsError(try mock.methodThatTakesUser(user: user2))
        XCTAssertEqual(mock.methodThatTakesArrayOfUsers(array: [user1, user2]), 2)
        XCTAssertEqual(mock.methodThatTakesArrayOfUsers(array: [user1, user2, user1]), 0)
        XCTAssertEqual(mock.methodThatTakesArrayOfUsers(array: [user2, user1]), 0)
    }
}
