//
//  SelfConstrainedProtocolTests.swift
//  Mocky
//
//  Created by Andrzej Michnia on 10.01.2018.
//  Copyright © 2018 MakeAWishFoundation. All rights reserved.
//

import XCTest
import SwiftyMocky
#if os(iOS)
    @testable import Mocky_Example_iOS
#elseif os(tvOS)
    @testable import Mocky_Example_tvOS
#elseif os(macOS)
    @testable import Mocky_Example_macOS
#endif

class SelfConstrainedProtocolTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_self_constrained() {
        let mock = SelfConstrainedProtocolMock()
        let other = SelfConstrainedProtocolMock()

        Matcher.default.register(SelfConstrainedProtocolMock.self) { (a, b) -> Bool in
            return a === b
        }

        Given(mock, .methodReturningSelf(willReturn: mock))
        Given(mock, .compare(with: .any, willReturn: false))
        Given(mock, .compare(with: .value(mock), willReturn: true))

        XCTAssert(mock.methodReturningSelf() === mock)
        XCTAssertTrue(mock.compare(with: mock))
        XCTAssertFalse(mock.compare(with: other))
    }
}
