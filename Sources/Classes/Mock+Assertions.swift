//
//  Mock+Assertions.swift
//  Pods
//
//  Created by przemyslaw.wosko on 19/05/2017.
//
//

import Foundation

// MARK: - At least once instance member called

/// Verify that given method was called on mock object **at least once**.
///
/// - Parameters:
///   - object: Mock instance
///   - method: Method signature with wrapped parameters (`Parameter`)
///   - file: for XCTest print purposes
///   - line: for XCTest print purposes
public func Verify<T: Mock>(_ object: T, _ method: T.Verify, file: StaticString = #file, line: UInt = #line) {
    object.verify(method, count: .moreOrEqual(to: 1), file: file, line: line)
}

/// Verify that given property getter or setter was called on mock object **at least once**.
///
/// - Parameters:
///   - object: Mock instance
///   - property: Property name, get or set with wrapped newValue (`Parameter`)
///   - file: for XCTest print purposes
///   - line: for XCTest print purposes
public func VerifyProperty<T: Mock>(_ object: T, _ property: T.Property, file: StaticString = #file, line: UInt = #line) {
    object.verify(property: property, count: .moreOrEqual(to: 1), file: file, line: line)
}

// MARK: - At least once static member called

/// Verify that given static method was called on mock type **at least once**.
///
/// - Parameters:
///   - object: Mock type
///   - method: Method signature with wrapped parameters (`Parameter`)
///   - file: for XCTest print purposes
///   - line: for XCTest print purposes
public func Verify<T: StaticMock>(_ type: T.Type, _ method: T.StaticVerify, file: StaticString = #file, line: UInt = #line) {
    T.verify(method, count: .moreOrEqual(to: 1), file: file, line: line)
}

/// Verify that given static property getter or setter was called on mock object **at least once**.
///
/// - Parameters:
///   - object: Mock type
///   - property: Property name, get or set with wrapped newValue (`Parameter`)
///   - file: for XCTest print purposes
///   - line: for XCTest print purposes
public func VerifyProperty<T: StaticMock>(_ object: T.Type, _ property: T.StaticProperty, file: StaticString = #file, line: UInt = #line) {
    T.verify(property: property, count: .moreOrEqual(to: 1), file: file, line: line)
}

// MARK: - Instance member called with explicit count

/// Verify that given method was called on mock object **exact number of times**.
///
/// - Parameters:
///   - object: Mock instance
///   - count: Number of invocations
///   - method: Method signature with wrapped parameters (`Parameter`)
///   - file: for XCTest print purposes
///   - line: for XCTest print purposes
public func Verify<T: Mock>(_ object: T, _ count: Count, _ method: T.Verify, file: StaticString = #file, line: UInt = #line) {
    object.verify(method, count: count, file: file, line: line)
}

/// Verify that given property get / set was called on mock object **exact number of times**.
///
/// - Parameters:
///   - object: Mock instance
///   - count: Number of invocations
///   - method: Property name, get or set with wrapped newValue (`Parameter`)
///   - file: for XCTest print purposes
///   - line: for XCTest print purposes
public func VerifyProperty<T: Mock>(_ object: T, _ count: Count, _ property: T.Property, file: StaticString = #file, line: UInt = #line) {
    object.verify(property: property, count: count, file: file, line: line)
}

// MARK: - Static member called with explicit count

/// Verify that given static method was called on mock type **exact number of times**.
///
/// - Parameters:
///   - object: Mock type
///   - count: Number of invocations
///   - method: Static method signature with wrapped parameters (`Parameter`)
///   - file: for XCTest print purposes
///   - line: for XCTest print purposes
public func Verify<T: StaticMock>(_ type: T.Type, _ count: Count, _ method: T.StaticVerify, file: StaticString = #file, line: UInt = #line) {
    T.verify(method, count: count, file: file, line: line)
}

/// Verify that given static property get / set was called on mock type **exact number of times**.
///
/// - Parameters:
///   - object: Mock type
///   - count: Number of invocations
///   - method: Static property name, get or set with wrapped newValue (`Parameter`)
///   - file: for XCTest print purposes
///   - line: for XCTest print purposes
public func VerifyProperty<T: StaticMock>(_ type: T.Type, _ count: Count, _ property: T.StaticProperty, file: StaticString = #file, line: UInt = #line) {
    T.verify(property: property, count: count, file: file, line: line)
}

// MARK: - Given

/// Setup return value for method stubs in mock instance. When this method will be called on mock, it
/// will check for first matching given, with following rules:
/// 1. First check most specific givens (with explicit parameters - .value), then for wildcard parameters (.any)
/// 2. More recent givens have higher priority than older ones
/// 3. When two given's have same level of explicity, like:
///     ```
///     Given(mock, .do(with: .value(1), and: .any)
///     Given(mock, .do(with: .any, and: .value(1))
///     ```
///     Method stub will return most recent one.
///
/// - Parameters:
///   - object: Mock instance
///   - method: Method signature with wrapped parameters (Parameter<ValueType>) and return value
public func Given<T: Mock>(_ object: T, _ method: T.Given) {
    object.given(method)
}

/// Setup return value for static method stubs on mock type. When this static method will be called, it
/// will check for first matching given, with following rules:
/// 1. First check most specific givens (with explicit parameters - .value), then for wildcard parameters (.any)
/// 2. More recent givens have higher priority than older ones
/// 3. When two given's have same level of explicity, like:
///     ```
///     Given(T.self, .do(with: .value(1), and: .any)
///     Given(T.self, .do(with: .any, and: .value(1))
///     ```
///     Method stub will return most recent one.
///
/// - Parameters:
///   - object: Mock type
///   - method: Static method signature with wrapped parameters (Parameter<ValueType>) and return value
public func Given<T: StaticMock>(_ type: T.Type, _ method: T.StaticGiven) {
    type.given(method)
}

// MARK: - Perform

/// Setup perform closure for method stubs in mock instance. When this method will be called on mock, it
/// will check for first matching closure and execute it with parameters passed. Have in mind following rules:
/// 1. First check most specific performs (with explicit parameters - .value), then for wildcard parameters (.any)
/// 2. More recent performs have higher priority than older ones
/// 3. When two performs have same level of explicity, like:
///     ```
///     Perform(mock, .do(with: .value(1), and: .any, perform: { ... }))
///     Perform(mock, .do(with: .any, and: .value(1), perform: { ... }))
///     ```
///     Method stub will return most recent one.
///
/// - Parameters:
///   - object: Mock instance
///   - method: Method signature with wrapped parameters (Parameter<ValueType>) and perform closure
public func Perform<T: Mock>(_ object: T, _ method: T.Perform) {
    object.perform(method)
}

/// Setup perform closure for static method stubs for mock type. When this method will be called on mock type, it
/// will check for first matching closure and execute it with parameters passed. Have in mind following rules:
/// 1. First check most specific performs (with explicit parameters - .value), then for wildcard parameters (.any)
/// 2. More recent performs have higher priority than older ones
/// 3. When two performs have same level of explicity, like:
///     ```
///     Perform(T.self, .do(with: .value(1), and: .any, perform: { ... }))
///     Perform(T.self, .do(with: .any, and: .value(1), perform: { ... }))
///     ```
///     Method stub will return most recent one.
///
/// - Parameters:
///   - object: Mock type
///   - method: Static method signature with wrapped parameters (Parameter<ValueType>) and perform closure
public func Perform<T: StaticMock>(_ object: T.Type, _ method: T.StaticPerform) {
    T.perform(method)
}

// MARK: - Helpers

/// Fails flow with given message
///
/// - Parameter message: Failure message
/// - Returns: Never
public func Failure(_ message: String) -> Swift.Never {
    let errorMessage = "[FATAL] \(message)!"
    print(errorMessage)
    fatalError(errorMessage)
}

public extension Optional {
    /// Returns unwrapped value, or fails.
    ///
    /// - Parameter message: Failure message
    /// - Returns: Unwrapped value
    public func orFail(_ message: String = "unwrapping nil") -> Wrapped {
        return self ?? { Failure(message) }()
    }
}
