//
//  CustomAssertions.swift
//  SwiftyMocky
//
//  Created by Przemysław Wośko on 30/09/2018.
//  Copyright © 2018 MakeAWishFoundation. All rights reserved.
//

#if !MockyCustom
import XCTest

/// Allows to verify if error was thrown, and if it is of given type.
///
/// - Parameters:
///   - expression: Expression
///   - error: Expected error type
///   - message: Optional message
///   - file: File (optional)
///   - line: Line (optional)
public func XCTAssertThrowsError<T, E: Error>(_ expression: @autoclosure () throws -> T, of error: E.Type, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) {
    let throwMessage = message().isEmpty ? "Expected \(T.self) thrown" : message()
    XCTAssertThrowsError(try expression(), throwMessage, file: file, line: line) { errorThrown in
        let typeMessage = message().isEmpty ? "Expected \(T.self), got \(String(describing: errorThrown))" : message()
        XCTAssertTrue(errorThrown is E, typeMessage, file: file, line: line)
    }
}

/// Allows to verify if error was throws, and if its exactly the one expected.
///
/// - Parameters:
///   - expression: Expression
///   - error: Expected error conforming to Equatable, Error
///   - message: Optional message
///   - file: File (optional)
///   - line: Line (optional)
public func XCTAssertThrowsError<T, E>(_ expression: @autoclosure () throws -> T, error: E, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) where E: Error, E: Equatable {
    let throwMessage = message().isEmpty ? "Expected \(error) thrown" : message()
    XCTAssertThrowsError(try expression(), throwMessage, file: file, line: line) { errorThrown in
        let typeMessage = message().isEmpty ? "Expected \(error), got \(String(describing: errorThrown))" : message()
        XCTAssertTrue((errorThrown as? E) == error, typeMessage, file: file, line: line)
    }
}
#endif
