//
//  GenericProtocolsTests.swift
//  Mocky
//
//  Created by Andrzej Michnia on 09.01.2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
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

class GenericProtocolsTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    struct CustomThing: Decodable {
        let id: Int
    }

    func test_base_type_constraint() {
        let mock = GenericProtocolWithTypeConstraintMock()

        Given(mock, .test(type: .value(Int.self), willReturn: 0))
        Given(mock, .test(type: .value(Float.self), willReturn: 1))
        Given(mock, .test(type: .value(String.self), willReturn: 2))

        XCTAssertEqual(mock.test(Int.self), 0)
        XCTAssertEqual(mock.test(Float.self), 1)
        XCTAssertEqual(mock.test(String.self), 2)
    }

    func test_custom_type_constraint() {
        let mock = GenericProtocolWithTypeConstraintMock()

        let data = Data()
        let otherData = Data(count: 20)
        XCTAssertNotEqual(data, otherData)

        // Required to allow Type matching! Basic types like Int.self, Bool.self etc have already registered comparators
        Matcher.default.register(CustomThing.Type.self)

        Given(mock, .decode(type: .value(Int.self), from: .any, willReturn: 0))
        Given(mock, .decode(type: .value(Int.self), from: .value(data), willReturn: 1))
        Given(mock, .decode(type: .any(CustomThing.Type.self), from: .any, willReturn: CustomThing(id: 0)))
        Given(mock, .decode(type: .any(CustomThing.Type.self), from: .value(data), willReturn: CustomThing(id: 1)))

        XCTAssertEqual(mock.decode(Int.self, from: otherData), 0)
        XCTAssertEqual(mock.decode(Int.self, from: data), 1)

        XCTAssertEqual(mock.decode(CustomThing.self, from: otherData).id, 0)
        XCTAssertEqual(mock.decode(CustomThing.self, from: data).id, 1)
    }
}

