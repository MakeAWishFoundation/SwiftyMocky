//
//  SwiftyTestCase.swift
//  SwiftyMocky
//
//  Created by Andrzej Michnia on 23.09.2018.
//  Copyright © 2018 MakeAWishFoundation. All rights reserved.
//

import XCTest

/// SwiftyMocky test case. Use it to override system XCTasserts with the ones safer for SwiftyMocky. Additionally, SwiftyTestCase has some useful utils that might come handy.
open class SwiftyTestCase: XCTestCase {
    private static var cases: Set<SwiftyTestCase> = Set()

    open override func setUp() {
        super.setUp()
        restoreAfterFailureIfNeeded()
        register()
    }

    open override func tearDown() {
        deregister()
        super.tearDown()
    }

    public static func onFatalFailure() {
        cases.forEach { $0.onFatalFailure() }
    }

    private func register() {
        SwiftyTestCase.cases.insert(self)
    }

    private func deregister() {
        SwiftyTestCase.cases.remove(self)
    }

    private lazy var defaultContinueAfterFailure: Bool = { return self.continueAfterFailure }()

    private func onFatalFailure() {
        defaultContinueAfterFailure = continueAfterFailure
        continueAfterFailure = false
    }

    private func restoreAfterFailureIfNeeded() {
        continueAfterFailure = defaultContinueAfterFailure
    }
}

// MARK: - Additional Convenience
public func XCTAssertThrowsError<T, E: Error>(_ expression: @autoclosure () throws -> T, of error: E.Type, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) {
    let throwMessage = message().isEmpty ? "Expected \(T.self) thrown" : message()
    XCTAssertThrowsError(expression, throwMessage, file: file, line: line) { errorThrown in
        let typeMessage = message().isEmpty ? "Expected \(T.self), got \(String(describing: errorThrown))" : message()
        XCTAssertTrue(errorThrown is E, typeMessage, file: file, line: line)
    }
}

public func XCTAssertThrowsError<T, E>(_ expression: @autoclosure () throws -> T, error: E, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) where E: Error, E: Equatable {
    let throwMessage = message().isEmpty ? "Expected \(error) thrown" : message()
    XCTAssertThrowsError(expression, throwMessage, file: file, line: line) { errorThrown in
        let typeMessage = message().isEmpty ? "Expected \(error), got \(String(describing: errorThrown))" : message()
        XCTAssertTrue((errorThrown as? E) == error, typeMessage, file: file, line: line)
    }
}
