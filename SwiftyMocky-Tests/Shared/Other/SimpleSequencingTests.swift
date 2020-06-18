//
//  SimpleSequencingTests.swift
//  SwiftyMocky
//
//  Created by Andrzej Michnia on 22.09.2018.
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

class SimpleSequencingTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - StubbingPolicy
    func test_default_wrap_policy_over_one_element_sequence() {
        let mock = SimpleProtocolWithMethodsMock()

        Given(mock, .simpleMehtodThatReturns(willReturn: 1))
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 1)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 1)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 1)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 1)
    }

    func test_default_wrap_policy_over_multi_element_sequence() {
        let mock = SimpleProtocolWithMethodsMock()

        Given(mock, .simpleMehtodThatReturns(willReturn: 1,2,3))
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 1)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 2)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 3)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 1)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 2)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 3)
    }

    func test_errors_wrap_policy_over_multi_element_sequence() {
        let mock = ProtocolWithThrowingMethodsMock()

        Given(mock, .methodThatThrows(willThrow: TestError.first, TestError.second, TestError.third))

        XCTAssertThrowsError(try mock.methodThatThrows(), error: TestError.first)
        XCTAssertThrowsError(try mock.methodThatThrows(), error: TestError.second)
        XCTAssertThrowsError(try mock.methodThatThrows(), error: TestError.third)
        XCTAssertThrowsError(try mock.methodThatThrows(), error: TestError.first)
        XCTAssertThrowsError(try mock.methodThatThrows(), error: TestError.second)
        XCTAssertThrowsError(try mock.methodThatThrows(), error: TestError.third)
        XCTAssertThrowsError(try mock.methodThatThrows(), of: TestError.self)
        XCTAssertThrowsError(try mock.methodThatThrows(), of: TestError.self)
        XCTAssertThrowsError(try mock.methodThatThrows(), of: TestError.self)
    }

    func test_errors_and_values_mix() {
        let mock = ProtocolWithThrowingMethodsMock(sequencing: .inWritingOrder, stubbing: .drop)

        Given(mock, .methodThatReturnsAndThrows(param: .any, willThrow: TestError.first))
        Given(mock, .methodThatReturnsAndThrows(param: .any, willThrow: TestError.second))
        Given(mock, .methodThatReturnsAndThrows(param: .any, willThrow: TestError.third))
        Given(mock, .methodThatReturnsAndThrows(param: .any, willReturn: true), .wrap)

        XCTAssertThrowsError(try mock.methodThatReturnsAndThrows(param: 0), error: TestError.first)
        XCTAssertThrowsError(try mock.methodThatReturnsAndThrows(param: 0), error: TestError.second)
        XCTAssertThrowsError(try mock.methodThatReturnsAndThrows(param: 0), error: TestError.third)
        XCTAssertNoThrow(try mock.methodThatReturnsAndThrows(param: 0))
        XCTAssertTrue((try? mock.methodThatReturnsAndThrows(param: 0)) ?? false)
        XCTAssertTrue((try? mock.methodThatReturnsAndThrows(param: 0)) ?? false)
        XCTAssertTrue((try? mock.methodThatReturnsAndThrows(param: 0)) ?? false)
    }

    func test_errors_and_values_mix_produce() {
        let mock = ProtocolWithThrowingMethodsMock(sequencing: .inWritingOrder, stubbing: .drop)

        Given(mock, .methodThatReturnsAndThrows(param: .any, willProduce: { make in
            make.throw(TestError.first)
            make.throw(TestError.second)
            make.throw(TestError.third)
            make.return(true)
            make.return(true)
            make.return(true)
            make.return(true)
        }))

        Given(mock, .methodThatReturnsAndThrows(param: 1, willProduce: { make in
            make.return(false)
        }), .wrap)

        XCTAssertThrowsError(try mock.methodThatReturnsAndThrows(param: 0), error: TestError.first)
        XCTAssertThrowsError(try mock.methodThatReturnsAndThrows(param: 0), error: TestError.second)
        XCTAssertThrowsError(try mock.methodThatReturnsAndThrows(param: 0), error: TestError.third)
        XCTAssertNoThrow(try mock.methodThatReturnsAndThrows(param: 0))
        XCTAssertNoThrow(try mock.methodThatReturnsAndThrows(param: 0))
        XCTAssertNoThrow(try mock.methodThatReturnsAndThrows(param: 0))
        XCTAssertNoThrow(try mock.methodThatReturnsAndThrows(param: 1))
        XCTAssertNoThrow(try mock.methodThatReturnsAndThrows(param: 1))
        XCTAssertNoThrow(try mock.methodThatReturnsAndThrows(param: 1))
    }

    func test_default_policy_when_set_drop() {
        let mock = SimpleProtocolWithMethodsMock()
        mock.stubbingPolicy = .drop

        Given(mock, .simpleMehtodThatReturns(willReturn: 0,0,0,0,0))
        Given(mock, .simpleMehtodThatReturns(willReturn: 1,2,3,4))
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 1)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 2)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 3)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 4)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 0)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 0)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 0)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 0)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 0)
        // Next call will fail tests, as are given are droppeds
    }

    func test_inline_set_policy() {
        let mock = SimpleProtocolWithMethodsMock()

        Given(mock, .simpleMehtodThatReturns(willReturn: 0))
        Given(mock, .simpleMehtodThatReturns(willReturn: 5,4,3,2,1), .drop)

        XCTAssertEqual(mock.simpleMehtodThatReturns(), 5)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 4)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 3)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 2)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 1)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 0)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 0)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 0)
        // All subsequent calls will return 0, as it has wrap policy
    }

    func test_mixed_policy() {
        let mock = SimpleProtocolWithMethodsMock()

        Given(mock, .simpleMehtodThatReturns(optionalParam: .any, willReturn: nil), .wrap)
        Given(mock, .simpleMehtodThatReturns(optionalParam: nil, willReturn: "a","b"), .drop)
        Given(mock, .simpleMehtodThatReturns(optionalParam: "z", willReturn: "z","z","z"), .drop)

        XCTAssertEqual(mock.simpleMehtodThatReturns(optionalParam: nil), "a")
        XCTAssertEqual(mock.simpleMehtodThatReturns(optionalParam: "q"), nil)
        XCTAssertEqual(mock.simpleMehtodThatReturns(optionalParam: nil), "b")
        XCTAssertEqual(mock.simpleMehtodThatReturns(optionalParam: nil), nil)
        XCTAssertEqual(mock.simpleMehtodThatReturns(optionalParam: nil), nil)
        XCTAssertEqual(mock.simpleMehtodThatReturns(optionalParam: "z"), "z")
        XCTAssertEqual(mock.simpleMehtodThatReturns(optionalParam: "z"), "z")
        XCTAssertEqual(mock.simpleMehtodThatReturns(optionalParam: "z"), "z")
        XCTAssertEqual(mock.simpleMehtodThatReturns(optionalParam: "z"), nil)
    }

    // MARK: - SequencingPolicy
    func test_mixed_policy_when_inverted() {
        let mock = SimpleProtocolWithMethodsMock(sequencing: .inWritingOrder)

        Given(mock, .simpleMehtodThatReturns(optionalParam: "z", willReturn: "z","z","z"), .drop)
        Given(mock, .simpleMehtodThatReturns(optionalParam: nil, willReturn: "a","b"), .drop)
        Given(mock, .simpleMehtodThatReturns(optionalParam: .any, willReturn: nil), .wrap)

        XCTAssertEqual(mock.simpleMehtodThatReturns(optionalParam: nil), "a")
        XCTAssertEqual(mock.simpleMehtodThatReturns(optionalParam: "q"), nil)
        XCTAssertEqual(mock.simpleMehtodThatReturns(optionalParam: nil), "b")
        XCTAssertEqual(mock.simpleMehtodThatReturns(optionalParam: nil), nil)
        XCTAssertEqual(mock.simpleMehtodThatReturns(optionalParam: nil), nil)
        XCTAssertEqual(mock.simpleMehtodThatReturns(optionalParam: "z"), "z")
        XCTAssertEqual(mock.simpleMehtodThatReturns(optionalParam: "z"), "z")
        XCTAssertEqual(mock.simpleMehtodThatReturns(optionalParam: "z"), "z")
        XCTAssertEqual(mock.simpleMehtodThatReturns(optionalParam: "z"), nil)
    }

    func test_mixed_policy_just_dropping() {
        let mock = SimpleProtocolWithMethodsMock(sequencing: .inWritingOrder, stubbing: .drop)

        Given(mock, .simpleMehtodThatReturns(willReturn: 1))
        Given(mock, .simpleMehtodThatReturns(willReturn: 2))
        Given(mock, .simpleMehtodThatReturns(willReturn: 3))
        Given(mock, .simpleMehtodThatReturns(willReturn: 4))
        Given(mock, .simpleMehtodThatReturns(willReturn: 5))
        Given(mock, .simpleMehtodThatReturns(willReturn: 6))

        Given(mock, .simpleMehtodThatReturns(willReturn: 0), .wrap)

        XCTAssertEqual(mock.simpleMehtodThatReturns(), 1)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 2)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 3)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 4)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 5)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 6)

        XCTAssertEqual(mock.simpleMehtodThatReturns(), 0)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 0)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 0)
    }

    func test_sequencing_policy_change() {
        let mock = SimpleProtocolWithMethodsMock(sequencing: .inWritingOrder, stubbing: .drop)

        Given(mock, .simpleMehtodThatReturns(willReturn: 1))
        Given(mock, .simpleMehtodThatReturns(willReturn: 2))
        Given(mock, .simpleMehtodThatReturns(willReturn: 3))
        Given(mock, .simpleMehtodThatReturns(willReturn: 4))
        Given(mock, .simpleMehtodThatReturns(willReturn: 5))
        Given(mock, .simpleMehtodThatReturns(willReturn: 6))

        XCTAssertEqual(mock.simpleMehtodThatReturns(), 1)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 2)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 3)

        mock.sequencingPolicy = .lastWrittenResolvedFirst

        XCTAssertEqual(mock.simpleMehtodThatReturns(), 6)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 5)
        XCTAssertEqual(mock.simpleMehtodThatReturns(), 4)
    }
}
