//
//  MatcherTests.swift
//  SwiftyMocky
//
//  Created by Andrzej Michnia on 26/06/2019.
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

class MatcherTests: XCTestCase {

    func test_matching_dict_String_Any() {
        Matcher.default.register([String: Any].self) { (lhs, rhs) -> Bool in
            return NSDictionary(dictionary: lhs).isEqual(to: rhs)
        }

        let mock = GenericProtocolReturningIntMock()

        let a = 1
        let b: [String: Any] = ["b" : true, "B": 2]
        let bb: [String: Any] = ["b" : false, "B": "2"]
        let c: [String: Any] = ["c" : "true", "C": 2]

        Given(mock, .value(for: .value(a), willReturn: 1))
        Given(mock, .value(for: .value(b), willReturn: 2))
        Given(mock, .value(for: .value(bb), willReturn: 2))
        Given(mock, .value(for: .value(c), willReturn: 3))

        XCTAssert(mock.value(for: 1) == 1)
        XCTAssert(mock.value(for: b) == 2)
        XCTAssert(mock.value(for: bb) == 2)
        XCTAssert(mock.value(for: c) == 3)
    }

    func test_default_matcher_for_array() {
        Matcher.default.register(TInt.self) { (lhs, rhs) -> Bool in
            return lhs.value == rhs.value
        }
        guard let comparator = Matcher.default.comparator(for: [TInt].self) else {
            XCTFail("Could not generate default matcher comparator")
            return
        }

        XCTAssertTrue(
            comparator(
                [TInt(0), TInt(20), TInt(7), TInt(13)],
                [TInt(0), TInt(20), TInt(7), TInt(13)]
            )
        )
        XCTAssertFalse(
            comparator(
                [TInt(0), TInt(20), TInt(7), TInt(13)],
                [TInt(0), TInt(20), TInt(7)]
            )
        )
        XCTAssertFalse(
            comparator(
                [TInt(0), TInt(20), TInt(7), TInt(13)],
                [TInt(0), TInt(-3), TInt(7), TInt(13)]
            )
        )
        XCTAssertFalse(
            comparator(
                [TInt(0), TInt(20), TInt(7), TInt(13)],
                [TInt(0), TInt(7), TInt(20), TInt(13)]
            )
        )
    }

    func test_default_matcher_for_set() {
        guard let comparator = Matcher.default.comparator(for: Set<Int>.self) else {
            XCTFail("Could not generate default matcher comparator")
            return
        }

        XCTAssertTrue(
            comparator(
                Set(arrayLiteral: 0,20,7,13),
                Set(arrayLiteral: 0,20,7,13)
            )
        )
        XCTAssertFalse(
            comparator(
                Set(arrayLiteral: 0,20,7,13),
                Set(arrayLiteral: 0,-3,7,13)
            )
        )
        XCTAssertFalse(
            comparator(
                Set(arrayLiteral: 0,20,7,13),
                Set(arrayLiteral: 0,20,7)
            )
        )
        XCTAssertTrue(
            comparator(
                Set(arrayLiteral: 0,20,7,13),
                Set(arrayLiteral: 0,7,20,13)
            )
        )
    }

    func test_default_matcher_for_dictionary() {
        Matcher.default.register(TInt.self) { (lhs, rhs) -> Bool in
            return lhs.value == rhs.value
        }
        Matcher.default.register([Int: TInt].Element.self) { (lhs, rhs) -> Bool in
            return lhs.1.value == rhs.1.value
        }

        guard let comparator = Matcher.default.comparator(for: [Int: TInt].self) else {
            XCTFail("Could not generate default matcher comparator")
            return
        }

        XCTAssertTrue(
            comparator(
                Dictionary(dictionaryLiteral: (0, TInt(0)), (1, TInt(20)), (2, TInt(7)), (3, TInt(13))),
                Dictionary(dictionaryLiteral: (0, TInt(0)), (1, TInt(20)), (2, TInt(7)), (3, TInt(13)))
            )
        )
        XCTAssertFalse(
            comparator(
                Dictionary(dictionaryLiteral: (0, TInt(0)), (1, TInt(20)), (2, TInt(7)), (3, TInt(13))),
                Dictionary(dictionaryLiteral: (0, TInt(0)), (1, TInt(-3)), (2, TInt(7)), (3, TInt(13)))
            )
        )
        XCTAssertFalse(
            comparator(
                Dictionary(dictionaryLiteral: (0, TInt(0)), (1, TInt(20)), (2, TInt(7)), (3, TInt(13))),
                Dictionary(dictionaryLiteral: (0, TInt(0)), (1, TInt(20)), (2, TInt(7)))
            )
        )
        XCTAssertTrue(
            comparator(
                Dictionary(dictionaryLiteral: (0, TInt(0)), (1, TInt(20)), (2, TInt(7)), (3, TInt(13))),
                Dictionary(dictionaryLiteral: (0, TInt(0)), (2, TInt(7)), (1, TInt(20)), (3, TInt(13)))
            )
        )
    }
}

struct TInt {
    let value: Int

    init(_ value: Int) {
        self.value = value
    }
}
