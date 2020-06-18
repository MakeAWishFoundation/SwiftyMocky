//
//  CustomAssertionsTests.swift
//  SwiftyMocky
//
//  Created by Andrzej Michnia on 24/06/2019.
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

class CustomAssertionsTests: XCTestCase {

    func test_throws_error_of_type_success() {
        XCTAssertThrowsError(try throwErrorA(), of: TestError.self)
    }

    func test_throws_error_equatable_success() {
        XCTAssertThrowsError(try throwErrorA(), error: TestError.a)
        XCTAssertThrowsError(try throwErrorB(), error: TestError.b)
    }

    private enum TestError: Error, Equatable {
        case a
        case b
    }

    private func throwErrorA() throws -> Bool {
        throw TestError.a
    }

    private func throwErrorB() throws -> Bool {
        throw TestError.b
    }
}
