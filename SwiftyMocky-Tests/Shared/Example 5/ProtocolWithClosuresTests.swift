//
//  ProtocolWithClosuresTests.swift
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

class ProtocolWithClosuresTests: XCTestCase {

    func test_closures_not_escaping() {
        let mock = ProtocolWithClosuresMock()

        mock.methodThatTakes(closure: { $0 })
        mock.methodThatTakes(closure: { $0 * 2 })

        Verify(mock, 2, .methodThatTakes(closure: .any))
        // For non escaping closures - every .value(...) is always treated as .any
        Verify(mock, 2, .methodThatTakes(closure: .value({ $0 })))
    }

    func test_closures_escaping() {
        let mock = ProtocolWithClosuresMock()

        mock.methodThatTakesEscaping(closure: { $0 })
        mock.methodThatTakesEscaping(closure: { $0 * 2 })

        // It is possible to check based on .value(...) for escaping closures
        // It requires to register closure comparator to Matcher
        // Nevertheless - we have not found ane good reason to do that yet :)
        Matcher.default.register(((Int) -> Int).self) { (lhs, rhs) -> Bool in
            return lhs(1) == rhs(1) && lhs(2) == rhs(2)
        }

        Verify(mock, 2, .methodThatTakesEscaping(closure: .any))
        Verify(mock, 1, .methodThatTakesEscaping(closure: .value({ $0 })))
    }

    func test_completion_block_based_approach() {
        let mock = ProtocolWithClosuresMock()

        let calledCompletionBlock = expectation(description: "Should call completion block")

        // Perform allows to execute given closure, with all the method parameters, as soon as it is being called
        Perform(mock, .methodThatTakesCompletionBlock(completion: .any, perform: { (completion) in
            completion(true,nil)
        }))

        mock.methodThatTakesCompletionBlock { (success, error) in
            calledCompletionBlock.fulfill()
            XCTAssertTrue(success)
            XCTAssertNil(error)
        }

        waitForExpectations(timeout: 0.5) { (error) in
            guard let error = error else { return }
            XCTFail("Error: \(error)")
        }
    }
}
