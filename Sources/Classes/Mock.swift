//
//  Mock.swift
//  Pods
//
//  Created by przemyslaw.wosko on 19/05/2017.
//
//

import Foundation

public enum MockScope {
    case invocation
    case given
    case perform
}

/// Every generated mock implementation adopts **Mock** protocol.
/// It defines base Mock structure and features.
public protocol Mock: class {
    /// Stubbed method and property type
    associatedtype Given
    /// Verification type
    associatedtype Verify
    /// Perform type
    associatedtype Perform

    /// Registers return value for stubbed method, for specified attributes set.
    ///
    /// When this method will be called on mock, it will check for first matching given, with following rules:
    /// 1. First check most specific givens (with explicit parameters - .value), then for wildcard parameters (.any)
    /// 2. More recent givens have higher priority than older ones
    /// 3. When two given's have same level of explicity, like:
    ///     ```
    ///     Given(mock, .do(with: .value(1), and: .any)
    ///     Given(mock, .do(with: .any, and: .value(1))
    ///     ```
    ///     Method stub will return most recent one.
    ///
    ///
    /// - Parameter method: signature, with attributes (any or explicit value). Type `.` for all available
    func given(_ method: Given)

    /// Registers perform closure, which will be executed upon calling stubbed method, for specified attribtes.
    ///
    /// When this method will be called on mock, it
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
    /// - Parameter method: signature, with attributes (any or explicit value). Type `.` for all available
    func perform(_ method: Perform)

    /// Verifies, that given method stub was called exact number of times.
    ///
    /// - Parameters:
    ///   - method: Method signature with wrapped parameters (Parameter<ValueType>)
    ///   - count: Number of invocations
    ///   - file: for XCTest print purposes
    ///   - line: for XCTest print purposes
    func verify(_ method: Verify, count: Count, file: StaticString, line: UInt)

    /// Clear mock internals. You can specify what to clear (invocations aka verify, givens or performs)
    /// or leave it empty to clear all mock internals.
    ///
    /// Example:
    /// ```swift
    /// mock.resetMock(.invocation)         // clear invocations, Verify will have all the count on 0
    /// mock.resetMock(.given, .perform)    // clear only mock setup, invocations stays
    /// mock.resetMock()                    // clear all
    /// ```
    func resetMock(_ scopes: MockScope...)
}

/// Every mock, that stubs static methods, should adopt **StaticMock** protocol.
/// It defines base StaticMock structure and features.
public protocol StaticMock: class {
    /// Stubbed method and property type
    associatedtype StaticGiven
    /// Verification type
    associatedtype StaticVerify
    /// Perform type
    associatedtype StaticPerform

    /// Registers return value for stubbed method, for specified attributes set.
    ///
    /// When this method will be called on mock, it will check for first matching given, with following rules:
    /// 1. First check most specific givens (with explicit parameters - .value), then for wildcard parameters (.any)
    /// 2. More recent givens have higher priority than older ones
    /// 3. When two given's have same level of explicity, like:
    ///     ```
    ///     Given(mock, .do(with: .value(1), and: .any)
    ///     Given(mock, .do(with: .any, and: .value(1))
    ///     ```
    ///     Method stub will return most recent one.
    ///
    ///
    /// - Parameter method: signature, with attributes (any or explicit value). Type `.` for all available
    static func given(_ method: StaticGiven)

    /// Registers perform closure, which will be executed upon calling stubbed method, for specified attribtes.
    ///
    /// When this method will be called on mock, it
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
    /// - Parameter method: signature, with attributes (any or explicit value). Type `.` for all available
    static func perform(_ method: StaticPerform)

    /// Verifies, that given method stub was called exact number of times.
    ///
    /// - Parameters:
    ///   - method: Method signature with wrapped parameters (Parameter<ValueType>)
    ///   - count: Number of invocations
    ///   - file: for XCTest print purposes
    ///   - line: for XCTest print purposes
    static func verify(_ method: StaticVerify, count: Count, file: StaticString, line: UInt)

    /// Clear mock internals. You can specify what to clear (invocations aka verify, givens or performs)
    /// or leave it empty to clear all mock internals.
    ///
    /// Example:
    /// ```swift
    /// mock.resetMock(.invocation)         // clear invocations, Verify will have all the count on 0
    /// mock.resetMock(.given, .perform)    // clear only mock setup, invocations stays
    /// mock.resetMock()                    // clear all
    /// ```
    static func resetMock(_ scopes: MockScope...)
}

public extension StaticMock {
    
    /// [deprecated] Method `clear` method was renamed to `resetMock`
    @available(*, deprecated, message: "`clear` was renamed to `resetMock`")
    static func clear() {
        resetMock()
    }
}
