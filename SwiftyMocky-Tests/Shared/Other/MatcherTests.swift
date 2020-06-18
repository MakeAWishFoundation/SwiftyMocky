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
}
