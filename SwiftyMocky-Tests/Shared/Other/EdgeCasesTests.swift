//
//  EdgeCasesTests.swift
//  Mocky
//
//  Created by Andrzej Michnia on 29.09.2018.
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

class EdgeCasesTests: XCTestCase {
    func test_generics_with_custom_structs() {
        let mock = EdgeCasesGenericsProtocolMock()
        Matcher.default.register(Mytest<String, [Int]>.self) { lhs, rhs in
            return lhs.key == rhs.key
        }
        Matcher.default.register(Mytest<String, String>.self) { lhs, rhs in
            return lhs.key == rhs.key
        }
        Matcher.default.register(Mytest<String, [Int]>.Type.self)
        Matcher.default.register(Mytest<String, String>.Type.self)

        Given(mock, .getter(swapped: .any(Mytest<String,[Int]>.self), willReturn: false))
        Given(mock, .getter(swapped: .value(Mytest(value: [1,2,3], key: "key")), willProduce: { (stub: Stubber<Bool>) in
            stub.return(true)
            stub.return(false)
            stub.return(true)
            stub.return(true)
            stub.return(false)
        }))

        let key1 = Mytest(value: [1,2,3], key: "key")
        let key2 = Mytest(value: [1,1,1], key: "key")
        let key3 = Mytest(value: [1,2,3], key: "other")
        XCTAssertEqual(mock.getter(swapped: key1), true)
        XCTAssertEqual(mock.getter(swapped: key2), false)
        XCTAssertEqual(mock.getter(swapped: key2), true)
        XCTAssertEqual(mock.getter(swapped: key1), true)
        XCTAssertEqual(mock.getter(swapped: key1), false)

        XCTAssertFalse(mock.getter(swapped: key3))
        XCTAssertFalse(mock.getter(swapped: key3))
        XCTAssertFalse(mock.getter(swapped: key3))
        XCTAssertFalse(mock.getter(swapped: key3))
        XCTAssertFalse(mock.getter(swapped: key3))

        Given(mock, .getter(swapped: .any(Mytest<String,String>.self), willReturn: true))

        let key4 = Mytest(value: "[1,2,3]", key: "1")
        let key5 = Mytest(value: "whatever", key: "2")

        XCTAssertTrue(mock.getter(swapped: key4))
        XCTAssertTrue(mock.getter(swapped: key5))
    }

    func test_generics_with_custom_structs_2() {
        let mock = EdgeCasesGenericsProtocolMock()
        Matcher.default.register(Mytest<String, [Int]>.self) { lhs, rhs in
            return lhs.key == rhs.key
        }
        Matcher.default.register(Mytest<String, String>.self) { lhs, rhs in
            return lhs.key == rhs.key
        }
        Matcher.default.register(Mytest<String, [Int]>.Type.self)
        Matcher.default.register(Mytest<String, String>.Type.self)

        Given(mock, .getter(swapped: Parameter<Mytest<String, String>>.value(Mytest(value: "", key: "1")), willReturn: 1,2,3))

        let key4 = Mytest(value: "[1,2,3]", key: "1")

        XCTAssertEqual(mock.getter(swapped: key4), 1)
        XCTAssertEqual(mock.getter(swapped: key4), 2)
        XCTAssertEqual(mock.getter(swapped: key4), 3)
        XCTAssertEqual(mock.getter(swapped: key4), 1)
        XCTAssertEqual(mock.getter(swapped: key4), 2)
        XCTAssertEqual(mock.getter(swapped: key4), 3)
    }

    func test_no_stubbing_needed_for_methods_void() {
        let mock = ShouldAllowNoStubDefinedMock()

        mock.voidMethod("a")
        XCTAssertNoThrow(try mock.throwingVoidMethod("b"))
        XCTAssertNoThrow(try ShouldAllowNoStubDefinedMock.throwingVoidMethod("b"))
    }

    func test_no_stubbing_needed_for_methods_optional() {
        let mock = ShouldAllowNoStubDefinedMock()

        XCTAssertNil(mock.optionalMethod("a"))
        XCTAssertNil(mock.optionalThrowingMethod("b"))
        XCTAssertNil(ShouldAllowNoStubDefinedMock.optionalMethod("a"))
        XCTAssertNil(ShouldAllowNoStubDefinedMock.optionalThrowingMethod("b"))
    }

    func test_no_stubbing_needed_for_optional_properties() {
        let mock = ShouldAllowNoStubDefinedMock()

        XCTAssertNil(mock.property)
        XCTAssertNil(ShouldAllowNoStubDefinedMock.property)
    }

    func test_no_stubbing_needed_for_optional_subscripts() {
        let mock = ShouldAllowNoStubDefinedMock()

        XCTAssertNil(mock[0])
    }

    func test_autoclosures_flow() {
        let mock = FailsWithAutoClosureOnSwift5Mock()
        Given(mock, .connect(.any, willReturn: true))
        Perform(mock, .connect(.any, perform: { (closure: () -> String) in
            XCTAssert(closure() == "Test123")
        }))

        XCTAssert(mock.connect("Test123"))
    }

    func test_protocol_constrained_to_self_within_generic() {
        let mock = FailsWithReturnedTypeBeingGenericOfSelfMock()

        Given(mock, .methodWillReturnSelfTypedArray(willReturn: [mock]))
        XCTAssertEqual(mock.methodWillReturnSelfTypedArray().count, 1)
        Verify(mock, .methodWillReturnSelfTypedArray())

        Given(mock, .methodWillReturnSelfTypedArray2(willReturn: [mock, mock]))
        XCTAssertEqual(mock.methodWillReturnSelfTypedArray2().count, 2)
        Verify(mock, .methodWillReturnSelfTypedArray2())

        let custom = CustomGeneric(t: mock)
        Given(mock, .methodWillReturnSelfTypedCustom(willProduce: { stubber in
            stubber.return(custom)
            stubber.return(custom)
        }))
        XCTAssert(mock.methodWillReturnSelfTypedCustom().t === mock)
        Verify(mock, .methodWillReturnSelfTypedCustom())
    }
}
