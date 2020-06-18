//
//  MockClearTests.swift
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

class MockClearTests: XCTestCase {

    func testMockClearOnlyInvocations() {
        let mock = UserStorageTypeMock()
        var performCount = 0

        Given(mock, .surname(for: .value("Johny"), willReturn: "Bravo"))
        Given(mock, .surname(for: .any, willReturn: "Kowalsky"))

        Perform(mock, .surname(for: .any, perform: { _ in performCount += 1 }))

        _ = mock.surname(for: "Johny")
        _ = mock.surname(for: "Jan")
        _ = mock.surname(for: "Joanna")

        Verify(mock, 3, .surname(for: .any))
        Verify(mock, 1, .surname(for: "Johny"))
        Verify(mock, 1, .surname(for: "Jan"))
        Verify(mock, 1, .surname(for: "Joanna"))
        XCTAssertEqual(performCount, 3)

        mock.resetMock(.invocation)

        // Check invocations cleared
        Verify(mock, .never, .surname(for: .any))
        Verify(mock, .never, .surname(for: "Johny"))
        Verify(mock, .never, .surname(for: "Jan"))
        Verify(mock, .never, .surname(for: "Joanna"))

        // Check givens stays
        XCTAssertEqual(mock.surname(for: "Johny"), "Bravo")
        XCTAssertEqual(mock.surname(for: "Jan"), "Kowalsky")
        XCTAssertEqual(mock.surname(for: "Joanna"), "Kowalsky")

        // Check perform stays
        XCTAssertEqual(performCount, 6)
    }

    func testMockClearOnlyGiven() {
        let mock = UserStorageTypeMock()
        var performCount = 0

        Given(mock, .surname(for: .value("Johny"), willReturn: "Bravo"))
        Given(mock, .surname(for: .any, willReturn: "Kowalsky"))

        Perform(mock, .surname(for: .any, perform: { _ in performCount += 1 }))

        _ = mock.surname(for: "Johny")
        _ = mock.surname(for: "Jan")
        _ = mock.surname(for: "Joanna")

        Verify(mock, 3, .surname(for: .any))
        Verify(mock, 1, .surname(for: "Johny"))
        Verify(mock, 1, .surname(for: "Jan"))
        Verify(mock, 1, .surname(for: "Joanna"))
        XCTAssertEqual(performCount, 3)

        mock.resetMock(.given)

        // Check invocations not cleared
        Verify(mock, 3, .surname(for: .any))
        Verify(mock, 1, .surname(for: "Johny"))
        Verify(mock, 1, .surname(for: "Jan"))
        Verify(mock, 1, .surname(for: "Joanna"))

        // Verify new given is the only one
        Given(mock, .surname(for: .any, willReturn: "nope"))
        XCTAssertEqual(mock.surname(for: "Johny"), "nope", "Verify that previous givens were cleared")

        // Check perform stays
        XCTAssertEqual(performCount, 4)
    }

    func testMockClearOnlyPerform() {
        let mock = UserStorageTypeMock()
        var performCount = 0

        Given(mock, .surname(for: .value("Johny"), willReturn: "Bravo"))
        Given(mock, .surname(for: .any, willReturn: "Kowalsky"))

        Perform(mock, .surname(for: .any, perform: { _ in performCount += 1 }))

        _ = mock.surname(for: "Johny")
        _ = mock.surname(for: "Jan")
        _ = mock.surname(for: "Joanna")

        Verify(mock, 3, .surname(for: .any))
        Verify(mock, 1, .surname(for: "Johny"))
        Verify(mock, 1, .surname(for: "Jan"))
        Verify(mock, 1, .surname(for: "Joanna"))
        XCTAssertEqual(performCount, 3)

        mock.resetMock(.perform)

        // Check invocations not cleared
        Verify(mock, 3, .surname(for: .any))
        Verify(mock, 1, .surname(for: "Johny"))
        Verify(mock, 1, .surname(for: "Jan"))
        Verify(mock, 1, .surname(for: "Joanna"))

        // Check givens stays
        XCTAssertEqual(mock.surname(for: "Johny"), "Bravo")
        XCTAssertEqual(mock.surname(for: "Jan"), "Kowalsky")
        XCTAssertEqual(mock.surname(for: "Joanna"), "Kowalsky")

        // Check perform was cleared, so no new records would happen
        XCTAssertEqual(performCount, 3)
    }

    func testMockClearAll() {
        let mock = UserStorageTypeMock()
        var performCount = 0

        Given(mock, .surname(for: .value("Johny"), willReturn: "Bravo"))
        Given(mock, .surname(for: .any, willReturn: "Kowalsky"))

        Perform(mock, .surname(for: .any, perform: { _ in performCount += 1 }))

        _ = mock.surname(for: "Johny")
        _ = mock.surname(for: "Jan")
        _ = mock.surname(for: "Joanna")

        Verify(mock, 3, .surname(for: .any))
        Verify(mock, 1, .surname(for: "Johny"))
        Verify(mock, 1, .surname(for: "Jan"))
        Verify(mock, 1, .surname(for: "Joanna"))
        XCTAssertEqual(performCount, 3)

        mock.resetMock()

        // Check invocations cleared
        Verify(mock, .never, .surname(for: .any))
        Verify(mock, .never, .surname(for: "Johny"))
        Verify(mock, .never, .surname(for: "Jan"))
        Verify(mock, .never, .surname(for: "Joanna"))

        // Verify new given is the only one
        Given(mock, .surname(for: .any, willReturn: "nope"))
        XCTAssertEqual(mock.surname(for: "Johny"), "nope", "Verify that previous givens were cleared")

        // Check perform stays
        XCTAssertEqual(performCount, 3)
    }
}
