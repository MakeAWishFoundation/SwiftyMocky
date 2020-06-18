//
//  SuggestionRepositoryTests.swift
//  SwiftyMocky
//
//  Created by Andrzej Michnia on 11/11/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
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

class SuggestionRepositoryTests: XCTestCase {

    func testSuggestionRepositoryMock() {
        let mock = SuggestionRepositoryMock()

        let a = Suggestion()
        let b = Suggestion()

        Given(mock, .save(entity: .any, willReturn: false))
        Given(mock, .save(entity: .sameInstance(as: a), willReturn: true))

        XCTAssertTrue(mock.save(entity: a))
        XCTAssertFalse(mock.save(entity: b))

        Verify(mock, 2, .save(entity: .any))
        Verify(mock, 1, .save(entity: .sameInstance(as: a)))
        Verify(mock, 1, .save(entity: .sameInstance(as: b)))
    }

    func testSuggestionRepositoryConstrainedToProtocolMock() {
        let mock = SuggestionRepositoryConstrainedToProtocolMock<Suggestion>()

        let a = Suggestion()
        let b = Suggestion()

        Given(mock, .save(entity: .any, willReturn: false))
        Given(mock, .save(entity: .sameInstance(as: a), willReturn: true))

        XCTAssertTrue(mock.save(entity: a))
        XCTAssertFalse(mock.save(entity: b))

        Verify(mock, 2, .save(entity: .any))
        Verify(mock, 1, .save(entity: .sameInstance(as: a)))
        Verify(mock, 1, .save(entity: .sameInstance(as: b)))
    }
}
