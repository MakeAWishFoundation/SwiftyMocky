//
//  ComplicatedServiceTests.swift
//  Mocky_Example
//
//  Created by Andrzej Michnia on 24.10.2017.
//  Copyright © 2017 MakeAWishFoundation. All rights reserved.
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

class ComplicatedServiceTests: XCTestCase {
    //    var sut: // somthing depending on service - add later
    var service: ComplicatedServiceTypeMock!

    override func setUp() {
        super.setUp()

        service = ComplicatedServiceTypeMock()
    }

    override func tearDown() {
        service = nil

        super.tearDown()
    }

    func test_something() {
        service.matcher.register(Point.self) { p1,p2 -> Bool in
            return p1.x == p2.x && p1.y == p2.y
        }

        service.matcher.register((Float,Float).self) { (t0, t1) -> Bool in
            return t0.0 == t1.0 && t0.1 == t1.1
        }

        Given(service,.getPoint(from: .any(Point.self), willReturn: Point(x: 0, y: 0)))
        Given(service,.getPoint(from: .value((0.0,0.0)), willReturn: Point(x: 1, y: 1)))

        let first = service.getPoint(from: Point(x: 1332, y: 1231))
        XCTAssertEqual(first.x, 0)
        XCTAssertEqual(first.y, 0)

        let second = service.getPoint(from: (0.0,0.0))
        XCTAssertEqual(second.x, 1)
        XCTAssertEqual(second.y, 1)
    }

    func test_closures() {
        var calls = 0

        service.given(.methodWithClosures(success: Parameter<((Scalar, Scalar) -> Scalar)?>.any, willReturn: { _ in }))

        service.perform(.methodWithClosures(success: Parameter<((Scalar, Scalar) -> Scalar)?>.any,
                                            perform: { function in
            _ = function?(Scalar(1),Scalar(2))
        }))

        _ = service.methodWithClosures { (a, b) -> Scalar in
            calls += 1
            return a + b
        }

        XCTAssertEqual(calls, 1)
    }
}
