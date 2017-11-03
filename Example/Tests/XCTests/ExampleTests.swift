//
//  ExampleTests.swift
//  Mocky_Tests
//
//  Created by Andrzej Michnia on 25.10.2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import Mocky
@testable import Mocky_Example

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
}
