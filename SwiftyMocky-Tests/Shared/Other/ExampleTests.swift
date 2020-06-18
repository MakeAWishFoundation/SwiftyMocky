//
//  ExampleTests.swift
//  Mocky_Tests
//
//  Created by Andrzej Michnia on 25.10.2017.
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

enum TestError: Error {
    case first
    case second
    case third
}

class ExampleTests: XCTestCase {
    
    func testGivenExample() {
        let mock = UserStorageTypeMock()

        Given(mock, .surname(for: .value("Johny"), willReturn: "Bravo"))
        Given(mock, .surname(for: .any, willReturn: "Kowalsky"))

        var joannas = 0
        Perform(mock, .surname(for: .value("Joanna"), perform: { (value) in
            print("\(value) should be Joanna")
            joannas += 1
        }))

        var others = 0
        Perform(mock, .surname(for: .any, perform: { (value) in
            print("\(value) should be different to Joanna")
            others += 1
        }))

        XCTAssertEqual(mock.surname(for: "Johny"), "Bravo")
        XCTAssertEqual(mock.surname(for: "Mathew"), "Kowalsky")
        XCTAssertEqual(mock.surname(for: "Joanna"), "Kowalsky")
        XCTAssertEqual(joannas, 1)
        XCTAssertEqual(others, 2)
    }

    func testVerifyExample() {
        let sut = UsersViewModel()
        let mockStorage = UserStorageTypeMock()

        // inject mock to sut. Every time sut saves user data, it should trigger storage storeUser method
        sut.usersStorage = mockStorage
        sut.saveUser(name: "Johny", surname: "Bravo")
        sut.saveUser(name: "Johny", surname: "Cage")
        sut.saveUser(name: "Jon", surname: "Snow")

        // check is Jon Snow was stored at least one time
        Verify(mockStorage, .storeUser(name: .value("Jon"), surname: .value("Snow")))
        // total storeUser should be triggered 3 times, regardless of attributes values
        Verify(mockStorage, 3, .storeUser(name: .any, surname: .any))
        // two times it should be triggered with name Johny
        Verify(mockStorage, 2, .storeUser(name: .value("Johny"), surname: .any))
    }

    func test_completionBlocksBasedApproach() {
        let user = User(name: "Barabasz")
        let sut = UsersViewModel()
        let mock = UserNetworkTypeMock(baseUrl: "http://someurl")
        sut.userNetwork = mock

        Perform(mock, .getUser(for: .any, completion: .any, perform: { id, completion in
            completion(user)
        }))

        let fetchExpectation = expectation(description: "Should call completion block after done")

        sut.fetchUser() {
            fetchExpectation.fulfill()
            XCTAssertNotNil(sut.user)
        }

        waitForExpectations(timeout: 1) { (error) in
            if let error = error {
                XCTFail("Fetch user failed woth error: \(error)")
            }
        }
    }

    func testGiven_with_throwing() {
        let mock = AMassiveTestProtocolMock()

        Given(mock, .methodThatThrows(willThrow: TestError.first))

        do {
            try mock.methodThatThrows()
            XCTFail("Should not be here - mock should have thrown error")
        } catch {
            XCTAssertTrue(error is TestError)
        }

        Given(mock, .methodThatReturnsAndThrows(param: .any, willReturn: 0))
        Given(mock, .methodThatReturnsAndThrows(param: .value("first"), willThrow: TestError.first))
        Given(mock, .methodThatReturnsAndThrows(param: .value("second"), willThrow: TestError.second))
        Given(mock, .methodThatReturnsAndThrows(param: .value("third"), willThrow: TestError.third))
        Given(mock, .methodThatReturnsAndThrows(param: .value("danny"), willReturn: 1))

        do {
            let value = try mock.methodThatReturnsAndThrows(param: "aaa")
            XCTAssertEqual(value, 0)
        } catch {
            XCTFail("Should not fail")
        }

        do {
            _ = try mock.methodThatReturnsAndThrows(param: "first")
            XCTFail("Should not be here - mock should have thrown error")
        } catch where error is TestError {
            XCTAssertEqual(error as! TestError, TestError.first)
        } catch {
            XCTFail("Should not fail")
        }

        do {
            _ = try mock.methodThatReturnsAndThrows(param: "second")
            XCTFail("Should not be here - mock should have thrown error")
        } catch where error is TestError {
            XCTAssertEqual(error as! TestError, TestError.second)
        } catch {
            XCTFail("Should not fail")
        }

        do {
            _ = try mock.methodThatReturnsAndThrows(param: "third")
            XCTFail("Should not be here - mock should have thrown error")
        } catch where error is TestError {
            XCTAssertEqual(error as! TestError, TestError.third)
        } catch {
            XCTFail("Should not fail")
        }

        do {
            let value = try mock.methodThatReturnsAndThrows(param: "danny")
            XCTAssertEqual(value, 1)
        } catch {
            XCTFail("Should not fail")
        }
    }

    func testAll_static_calls() {
        let perform = expectation(description: "Should perform")
        Given(AMassiveTestProtocolMock.self, .methodThatReturnsAndThrows(param: .any, willReturn: 1))
        Perform(AMassiveTestProtocolMock.self, .methodThatThrows(perform: {
            perform.fulfill()
        }))
        try? AMassiveTestProtocolMock.methodThatThrows()
        Verify(AMassiveTestProtocolMock.self, .methodThatThrows())

        let value = try? AMassiveTestProtocolMock.methodThatReturnsAndThrows(param: "anything")
        Verify(AMassiveTestProtocolMock.self, .methodThatReturnsAndThrows(param: .value("anything")))
        XCTAssertEqual(value, 1)
        waitForExpectations(timeout: 1) { error in
            if let _ = error {
                XCTFail()
            }
        }
    }

    func test_generics() {
        let date = Date.init(timeIntervalSince1970: 321123)
        let item1 = DateSortableMock()
        Given(item1, .date(getter: date))
        Matcher.default.register(DateSortableMock.self) { (lhs, rhs) -> Bool in
            return lhs.date == rhs.date
        }

        let mock = HistorySectionMapperTypeMock()

        Given(mock, .map(.any, willReturn: [(key: String, items: [DateSortableMock])]()))
        Given(mock, .map(.value([item1]), willReturn: [(key: "only item", items: [item1])]))

        print(mock.map([DateSortableMock]()))
        print(mock.map([item1]))
    }

    func test_generics_2() {
        let mock = AVeryAssociatedProtocolMock<[Int],String>()
        mock.given(.fetch(for: .value("aaa"), willReturn: [1,2,3]))
        XCTAssertEqual(mock.fetch(for: "aaa"),[1,2,3])
    }

    func test_generics_3() {
        let mock = AVeryGenericProtocolMock(value: 1)

        Given(mock, .methodConstrained(param: .value(1), willReturn: (0,0)))
        Given(mock, .methodConstrained(param: .value(2), willReturn: (0,1)))
        Given(mock, .methodConstrained(param: .value("abc"), willReturn: (0,2)))

        let (_, a): (Int,Int) = mock.methodConstrained(param: 1)
        let (_, b): (Int,Int) = mock.methodConstrained(param: 2)
        let (_, c): (Int,Int) = mock.methodConstrained(param: "abc")
        XCTAssertEqual(0, a)
        XCTAssertEqual(1, b)
        XCTAssertEqual(2, c)

        Verify(mock, .methodConstrained(param: .value("abc")))
        Verify(mock, 2, .methodConstrained(param: .any(Int.self)))
        Verify(mock, 1, .methodConstrained(param: .any(String.self)))
    }

    func test_generic_parameters_compare() {
        // Any vs Any
        XCTAssertTrue(Parameter.compare(lhs: Parameter<Int>.any.wrapAsGeneric(), rhs: Parameter<Int>.any.wrapAsGeneric(), with: Matcher.default))
        XCTAssertFalse(Parameter.compare(lhs: Parameter<Int>.any.wrapAsGeneric(), rhs: Parameter<String>.any.wrapAsGeneric(), with: Matcher.default))

        // Any vs Value
        XCTAssertTrue(Parameter.compare(lhs: Parameter<Int>.any.wrapAsGeneric(), rhs: Parameter<Int>.value(1).wrapAsGeneric(), with: Matcher.default))
        XCTAssertTrue(Parameter.compare(lhs: Parameter<String>.any.wrapAsGeneric(), rhs: Parameter<String>.value("1").wrapAsGeneric(), with: Matcher.default))
        XCTAssertFalse(Parameter.compare(lhs: Parameter<Int>.any.wrapAsGeneric(), rhs: Parameter<String>.value("1").wrapAsGeneric(), with: Matcher.default))
        XCTAssertFalse(Parameter.compare(lhs: Parameter<String>.any.wrapAsGeneric(), rhs: Parameter<Int>.value(1).wrapAsGeneric(), with: Matcher.default))

        // Value vs Any
        XCTAssertTrue(Parameter.compare(lhs: Parameter<Int>.value(1).wrapAsGeneric(), rhs: Parameter<Int>.any.wrapAsGeneric(), with: Matcher.default))
        XCTAssertTrue(Parameter.compare(lhs: Parameter<String>.value("1").wrapAsGeneric(), rhs: Parameter<String>.any.wrapAsGeneric(), with: Matcher.default))
        XCTAssertFalse(Parameter.compare(lhs: Parameter<Int>.value(1).wrapAsGeneric(), rhs: Parameter<String>.any.wrapAsGeneric(), with: Matcher.default))
        XCTAssertFalse(Parameter.compare(lhs: Parameter<String>.value("1").wrapAsGeneric(), rhs: Parameter<Int>.any.wrapAsGeneric(), with: Matcher.default))

        // Value vs Value
        XCTAssertTrue(Parameter.compare(lhs: Parameter<Int>.value(1).wrapAsGeneric(), rhs: Parameter<Int>.value(1).wrapAsGeneric(), with: Matcher.default))
        XCTAssertTrue(Parameter.compare(lhs: Parameter<String>.value("1").wrapAsGeneric(), rhs: Parameter<String>.value("1").wrapAsGeneric(), with: Matcher.default))
        XCTAssertFalse(Parameter.compare(lhs: Parameter<Int>.value(1).wrapAsGeneric(), rhs: Parameter<String>.value("1").wrapAsGeneric(), with: Matcher.default))
        XCTAssertFalse(Parameter.compare(lhs: Parameter<String>.value("1").wrapAsGeneric(), rhs: Parameter<Int>.value(1).wrapAsGeneric(), with: Matcher.default))

        // Matching
        let greater: (Int) -> Bool = { $0 > 5 }
        let less: (Int) -> Bool = { $0 < 5 }

        XCTAssertTrue(Parameter.compare(lhs: Parameter<Int>.value(1), rhs: Parameter<Int>.matching(less), with: Matcher.default))
        XCTAssertTrue(Parameter.compare(lhs: Parameter<Int>.value(1).wrapAsGeneric(), rhs: Parameter<Int>.matching(less).wrapAsGeneric(), with: Matcher.default))
        XCTAssertFalse(Parameter.compare(lhs: Parameter<Int>.value(1).wrapAsGeneric(), rhs: Parameter<Int>.matching(greater).wrapAsGeneric(), with: Matcher.default))
        XCTAssertTrue(Parameter.compare(lhs: Parameter<Int>.value(13).wrapAsGeneric(), rhs: Parameter<Int>.matching(greater).wrapAsGeneric(), with: Matcher.default))
        XCTAssertFalse(Parameter.compare(lhs: Parameter<Int>.value(13).wrapAsGeneric(), rhs: Parameter<Int>.matching(less).wrapAsGeneric(), with: Matcher.default))

        XCTAssertTrue(Parameter.compare(lhs: Parameter<Int>.matching(less).wrapAsGeneric(), rhs: Parameter<Int>.value(1).wrapAsGeneric(), with: Matcher.default))
        XCTAssertFalse(Parameter.compare(lhs: Parameter<Int>.matching(greater).wrapAsGeneric(), rhs: Parameter<Int>.value(1).wrapAsGeneric(), with: Matcher.default))
        XCTAssertTrue(Parameter.compare(lhs: Parameter<Int>.matching(greater).wrapAsGeneric(), rhs: Parameter<Int>.value(13).wrapAsGeneric(), with: Matcher.default))
        XCTAssertFalse(Parameter.compare(lhs: Parameter<Int>.matching(less).wrapAsGeneric(), rhs: Parameter<Int>.value(13).wrapAsGeneric(), with: Matcher.default))
    }

    func test_matching_parameters() {
        let m = Matcher.default
        let containsZero: ([Int]) -> Bool = { $0.contains(0) }
        let isEmpty: ([Int]) -> Bool = { $0.isEmpty }

        XCTAssertFalse(Parameter.compare(lhs: Parameter<[Int]>.value([1,2,3,4,5]), rhs: .matching(containsZero), with: m))
        XCTAssertFalse(Parameter.compare(lhs: Parameter<[Int]>.value([1,2,3,4,5]), rhs: .matching(isEmpty), with: m))
        XCTAssertTrue(Parameter.compare(lhs: Parameter<[Int]>.value([]), rhs: .matching(isEmpty), with: m))
        XCTAssertTrue(Parameter.compare(lhs: Parameter<[Int]>.value([2,3,0,0,0]), rhs: .matching(containsZero), with: m))
    }
}

extension String: EmptyProtocol { }
