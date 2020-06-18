//
//  ProtocolWithGenericConstraintsTests.swift
//  SwiftyMocky
//
//  Created by Oleksandr Demishkevych on 7/17/19.
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

class ProtocolWithGenericConstraintsTests: XCTestCase {

    func test_get_value() {
        let mock = ProtocolWithGenericConstraintsMock<String>()
        let expectedValue = UUID().uuidString
        mock.given(.value(getter: expectedValue))
        XCTAssertEqual(mock.value, expectedValue)
        mock.verify(.value)
    }

    func test_extract_value_if_constrains_satisfied() {
        let mock = ProtocolWithGenericConstraintsMock<String?>()
        let expectedValue = UUID().uuidString
        mock.given(.extractString(willReturn: .some(expectedValue)))
        XCTAssertEqual(mock.extractString(), expectedValue)
        mock.verify(.extractString())
    }
}
