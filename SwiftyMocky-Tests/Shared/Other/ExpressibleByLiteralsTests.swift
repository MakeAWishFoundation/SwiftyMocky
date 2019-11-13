//
//  ExpressibleByLiteralsTests.swift
//  Mocky
//
//  Created by Andrzej Michnia on 20/09/2018.
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

class ExpressibleByLiteralsTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_string_literals() {
        let mock = AllLiteralsContainerMock()

        Given(mock, .methodWithStringParameter(p: .any, willReturn: 0))
        Given(mock, .methodWithStringParameter(p: "a", willReturn: 1))
        Given(mock, .methodWithStringParameter(p: "b", willReturn: 2))

        XCTAssertEqual(mock.methodWithStringParameter(p: "a"), 1)
        XCTAssertEqual(mock.methodWithStringParameter(p: "b"), 2)
        XCTAssertEqual(mock.methodWithStringParameter(p: "c"), 0)

        Verify(mock, .methodWithStringParameter(p: "a"))
        Verify(mock, .methodWithStringParameter(p: "b"))
        Verify(mock, .methodWithStringParameter(p: "c"))
        Verify(mock, .never, .methodWithStringParameter(p: "d"))
        Verify(mock, 3, .methodWithStringParameter(p: .any))

        // Optional
        Given(mock, .methodWithOtionalStringParameter(p: .any, willReturn: 0))
        Given(mock, .methodWithOtionalStringParameter(p: "a", willReturn: 1))
        Given(mock, .methodWithOtionalStringParameter(p: "b", willReturn: 2))
        Given(mock, .methodWithOtionalStringParameter(p: nil, willReturn: 3))

        XCTAssertEqual(mock.methodWithOtionalStringParameter(p: "a"), 1)
        XCTAssertEqual(mock.methodWithOtionalStringParameter(p: "b"), 2)
        XCTAssertEqual(mock.methodWithOtionalStringParameter(p: "c"), 0)
        XCTAssertEqual(mock.methodWithOtionalStringParameter(p: nil), 3)

        Verify(mock, .methodWithOtionalStringParameter(p: "a"))
        Verify(mock, .methodWithOtionalStringParameter(p: "b"))
        Verify(mock, .methodWithOtionalStringParameter(p: "c"))
        Verify(mock, .methodWithOtionalStringParameter(p: nil))
        Verify(mock, .never, .methodWithOtionalStringParameter(p: "d"))
        Verify(mock, 4, .methodWithOtionalStringParameter(p: .any))

        // Custom
        Given(mock, .methodWithCustomStringParameter(p: .any, willReturn: 0))
        Given(mock, .methodWithCustomStringParameter(p: "a", willReturn: 1))
        Given(mock, .methodWithCustomStringParameter(p: "b", willReturn: 2))

        XCTAssertEqual(mock.methodWithCustomStringParameter(p: CustomString.a), 1)
        XCTAssertEqual(mock.methodWithCustomStringParameter(p: CustomString.b("b")), 2)
        XCTAssertEqual(mock.methodWithCustomStringParameter(p: CustomString.b("c")), 0)

        Verify(mock, 1, .methodWithCustomStringParameter(p: .value(CustomString.a)))
        Verify(mock, 1, .methodWithCustomStringParameter(p: "a"))
        Verify(mock, .methodWithCustomStringParameter(p: "b"))
        Verify(mock, .methodWithCustomStringParameter(p: "c"))
        Verify(mock, .never, .methodWithCustomStringParameter(p: "d"))
        Verify(mock, 3, .methodWithCustomStringParameter(p: .any))

        // Custom Optional
        Given(mock, .methodWithCustomOptionalStringParameter(p: .any, willReturn: 0))
        Given(mock, .methodWithCustomOptionalStringParameter(p: "a", willReturn: 1))
        Given(mock, .methodWithCustomOptionalStringParameter(p: "b", willReturn: 2))
        Given(mock, .methodWithCustomOptionalStringParameter(p: nil, willReturn: 3))

        XCTAssertEqual(mock.methodWithCustomOptionalStringParameter(p: CustomString.a), 1)
        XCTAssertEqual(mock.methodWithCustomOptionalStringParameter(p: CustomString.b("b")), 2)
        XCTAssertEqual(mock.methodWithCustomOptionalStringParameter(p: CustomString.b("c")), 0)
        XCTAssertEqual(mock.methodWithCustomOptionalStringParameter(p: nil), 3)

        Verify(mock, 1, .methodWithCustomOptionalStringParameter(p: .value(CustomString.a)))
        Verify(mock, 1, .methodWithCustomOptionalStringParameter(p: "a"))
        Verify(mock, .methodWithCustomOptionalStringParameter(p: "b"))
        Verify(mock, .methodWithCustomOptionalStringParameter(p: "c"))
        Verify(mock, .methodWithCustomOptionalStringParameter(p: nil))
        Verify(mock, .never, .methodWithCustomOptionalStringParameter(p: "d"))

        Verify(mock, 4, .methodWithCustomOptionalStringParameter(p: .any))
    }

    func test_int_literals() {
        let mock = AllLiteralsContainerMock()

        Given(mock, .methodWithIntParameter(p: .any, willReturn: 0))
        Given(mock, .methodWithIntParameter(p: 1, willReturn: 1))
        Given(mock, .methodWithIntParameter(p: 2, willReturn: 2))

        XCTAssertEqual(mock.methodWithIntParameter(p: 1), 1)
        XCTAssertEqual(mock.methodWithIntParameter(p: 2), 2)
        XCTAssertEqual(mock.methodWithIntParameter(p: 3), 0)

        Verify(mock, .methodWithIntParameter(p: 1))
        Verify(mock, .methodWithIntParameter(p: 2))
        Verify(mock, .methodWithIntParameter(p: 3))
        Verify(mock, .never, .methodWithIntParameter(p: 5))
        Verify(mock, 3, .methodWithIntParameter(p: .any))

        // Custom Optional
        Given(mock, .methodWithCustomOptionalIntParameter(p: .any, willReturn: 0))
        Given(mock, .methodWithCustomOptionalIntParameter(p: 1, willReturn: 1))
        Given(mock, .methodWithCustomOptionalIntParameter(p: 2, willReturn: 2))
        Given(mock, .methodWithCustomOptionalIntParameter(p: nil, willReturn: 3))

        XCTAssertEqual(mock.methodWithCustomOptionalIntParameter(p: CustomInt.value(1)), 1)
        XCTAssertEqual(mock.methodWithCustomOptionalIntParameter(p: CustomInt.value(2)), 2)
        XCTAssertEqual(mock.methodWithCustomOptionalIntParameter(p: CustomInt.zero), 0)
        XCTAssertEqual(mock.methodWithCustomOptionalIntParameter(p: nil), 3)

        Verify(mock, 1, .methodWithCustomOptionalIntParameter(p: .value(CustomInt.zero)))
        Verify(mock, 1, .methodWithCustomOptionalIntParameter(p: 1))
        Verify(mock, .methodWithCustomOptionalIntParameter(p: 2))
        Verify(mock, .methodWithCustomOptionalIntParameter(p: 0))
        Verify(mock, .methodWithCustomOptionalIntParameter(p: nil))
        Verify(mock, .never, .methodWithCustomOptionalIntParameter(p: .value(CustomInt.value(15))))

        Verify(mock, 4, .methodWithCustomOptionalIntParameter(p: .any))
    }

    func test_bool_literals() {
        let mock = AllLiteralsContainerMock()

        Given(mock, .methodWithBool(p: .any, willReturn: 0))
        Given(mock, .methodWithBool(p: nil, willReturn: -1))
        Given(mock, .methodWithBool(p: true, willReturn: 2))
        Given(mock, .methodWithBool(p: false, willReturn: 1))

        XCTAssertEqual(mock.methodWithBool(p: nil), -1)
        XCTAssertEqual(mock.methodWithBool(p: true), 2)
        XCTAssertEqual(mock.methodWithBool(p: false), 1)

        Verify(mock, 1, .methodWithBool(p: nil))
        Verify(mock, 1, .methodWithBool(p: .value(nil)))
        Verify(mock, 1, .methodWithBool(p: true))
        Verify(mock, 1, .methodWithBool(p: false))
        Verify(mock, 3, .methodWithBool(p: .any))
        Verify(mock, 2, .methodWithBool(p: .notNil))
    }

    func test_float_literals() {
        let mock = AllLiteralsContainerMock()

        Given(mock, .methodWithFloat(p: .any, willReturn: 0))
        Given(mock, .methodWithFloat(p: nil, willReturn: -1))
        Given(mock, .methodWithFloat(p: 1.0, willReturn: 1))
        Given(mock, .methodWithFloat(p: 2, willReturn: 2))

        XCTAssertEqual(mock.methodWithFloat(p: nil), -1)
        XCTAssertEqual(mock.methodWithFloat(p: 1.0000001), 0)
        XCTAssertEqual(mock.methodWithFloat(p: 1.0), 1)
        XCTAssertEqual(mock.methodWithFloat(p: 2.0), 2)

        Verify(mock, 4, .methodWithFloat(p: .any))

        Given(mock, .methodWithDouble(p: .any, willReturn: 0))
        Given(mock, .methodWithDouble(p: nil, willReturn: -1))
        Given(mock, .methodWithDouble(p: 1.0, willReturn: 1))
        Given(mock, .methodWithDouble(p: 2, willReturn: 2))

        XCTAssertEqual(mock.methodWithDouble(p: nil), -1)
        XCTAssertEqual(mock.methodWithDouble(p: 1.0000001), 0)
        XCTAssertEqual(mock.methodWithDouble(p: 1.0), 1)
        XCTAssertEqual(mock.methodWithDouble(p: 2.0), 2)

        Verify(mock, 4, .methodWithDouble(p: .any))
    }

    func test_array_literals() {
        let mock = AllLiteralsContainerMock()

        Given(mock, .methodWithArrayOfInt(p: .any, willReturn: 0))
        Given(mock, .methodWithArrayOfInt(p: [1,2,3], willReturn: 1))
        Given(mock, .methodWithArrayOfInt(p: [4,5], willReturn: 2))

        XCTAssertEqual(mock.methodWithArrayOfInt(p: [0]), 0)
        XCTAssertEqual(mock.methodWithArrayOfInt(p: [1,2,3]), 1)
        XCTAssertEqual(mock.methodWithArrayOfInt(p: [1,2,3,4]), 0)
        XCTAssertEqual(mock.methodWithArrayOfInt(p: [4,5]), 2)

        Verify(mock, 4, .methodWithArrayOfInt(p: .any))

        Given(mock, .methodWithArrayOfOther(p: .any, willReturn: 0))
        Given(mock, .methodWithArrayOfOther(p: [SomeClass(v: 0), SomeClass(v: 1)], willReturn: 1))

        XCTAssertEqual(mock.methodWithArrayOfOther(p: []), 0)
        XCTAssertEqual(mock.methodWithArrayOfOther(p: [SomeClass(v: 0), SomeClass(v: 1)]), 1)

        Verify(mock, 2, .methodWithArrayOfOther(p: .any))

        Given(mock, .methodWithSetOfInt(p: .any, willReturn: 0))
        Given(mock, .methodWithSetOfInt(p: [0,1,2], willReturn: 1))
        Given(mock, .methodWithSetOfInt(p: [2,3,4], willReturn: 2))

        XCTAssertEqual(mock.methodWithSetOfInt(p: [0,1]), 0)
        XCTAssertEqual(mock.methodWithSetOfInt(p: [0,1,2]), 1)
        XCTAssertEqual(mock.methodWithSetOfInt(p: [2,3,4]), 2)

        Verify(mock, 3, .methodWithSetOfInt(p: .any))
        Verify(mock, .once, .methodWithSetOfInt(p: [0,1]))
        Verify(mock, .once, .methodWithSetOfInt(p: [0,1,2]))
        Verify(mock, .once, .methodWithSetOfInt(p: [2,3,4]))

        Given(mock, .methodWithOptionalSetOfInt(p: .any, willReturn: 0))
        Given(mock, .methodWithOptionalSetOfInt(p: [0,1,2], willReturn: 1))
        Given(mock, .methodWithOptionalSetOfInt(p: [2,3,4], willReturn: 2))
        Given(mock, .methodWithOptionalSetOfInt(p: nil, willReturn: 3))

        XCTAssertEqual(mock.methodWithOptionalSetOfInt(p: [0,1]), 0)
        XCTAssertEqual(mock.methodWithOptionalSetOfInt(p: [0,1,2]), 1)
        XCTAssertEqual(mock.methodWithOptionalSetOfInt(p: [2,3,4]), 2)
        XCTAssertEqual(mock.methodWithOptionalSetOfInt(p: nil), 3)

        Verify(mock, 4, .methodWithOptionalSetOfInt(p: .any))
        Verify(mock, .once, .methodWithOptionalSetOfInt(p: [0,1]))
        Verify(mock, .once, .methodWithOptionalSetOfInt(p: [0,1,2]))
        Verify(mock, .once, .methodWithOptionalSetOfInt(p: [2,3,4]))
        Verify(mock, .once, .methodWithOptionalSetOfInt(p: nil))
    }

    func test_dict_literals() {
        let mock = AllLiteralsContainerMock()

        Matcher.default.register([String: SomeClass].self) { (lhs, rhs) -> Bool in
            return lhs["key"] == rhs["key"]
        }

        Given(mock, .methodWithDict(p: .any, willReturn: 0))
        Given(mock, .methodWithDict(p: ["key": SomeClass(v: 1)], willReturn: 1))

        XCTAssertEqual(mock.methodWithDict(p: [:]), 0)
        XCTAssertEqual(mock.methodWithDict(p: ["key": SomeClass(v: 1)]), 1)

        Verify(mock, 2, .methodWithDict(p: .any))
    }
}
