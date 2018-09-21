//
//  Mock.swift
//  Pods
//
//  Created by przemyslaw.wosko on 19/05/2017.
//
//

import Foundation

/// Given Policy for treating sequence of events (products). For wr
///
/// - `default`: Use current policy specified for Mock method type
/// - wrap: Default policy in general. When reaching end of sequence of events, index will rewind to beginning (looping)
/// - drop: With this policy, every call drops event. When events count reaches zero, given is removed from mock.
public enum Policy {
    case `default`  // use mock default policy for method type
    case wrap       // default
    case drop

    public func real(_ inherited: Policy) -> Policy {
        switch (self, inherited) {
        case (.default, .default): return .wrap // Special case, wrap is always default in general
        case (.default, _): return inherited    // Use inherited for real policy if self is default
        default: return self                    // If policy specified, use it instead of inherited
        }
    }

    public func updated(_ index: Int, with count: Int) -> Int {
        switch self {
        case .wrap: return (index + 1) % count
        case .drop: return index + 1
        case .default: fatalError("Should not be here!")
        }
    }
}

/// Possible Given products. Method can (in general) either return or throw an error
///
/// - `return`: Return value
/// - `throw`: Thrown error value
public enum Product {
    case `return`(Any)
    case `throw`(Error)
}

/// Every generated mock implementation adopts **Mock** protocol.
/// It defines base Mock structure and features.
public protocol Mock: class {
    associatedtype Given
    associatedtype Verify
    associatedtype Perform
    associatedtype Property

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

    /// Verifies, that given property stub was called exact number of times.
    ///
    /// - Parameters:
    ///   - property: property with get or set (with newValueParameter<ValueType>)
    ///   - count: Number of invocations
    ///   - file: for XCTest print purposes
    ///   - line: for XCTest print purposes
    func verify(property: Property, count: Count, file: StaticString, line: UInt)
}

/// Every mock, that stubs static methods, should adopt **StaticMock** protocol.
/// It defines base StaticMock structure and features.
public protocol StaticMock: class {
    associatedtype StaticGiven
    associatedtype StaticVerify
    associatedtype StaticPerform
    associatedtype StaticProperty

    /// As verifying static members relies on static count of invocations, clear allows to 'reset' static mock internals.
    static func clear()

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

    /// Verifies, that given property stub was called exact number of times.
    ///
    /// - Parameters:
    ///   - property: property with get or set (with newValueParameter<ValueType>)
    ///   - count: Number of invocations
    ///   - file: for XCTest print purposes
    ///   - line: for XCTest print purposes
    static func verify(property: StaticProperty, count: Count, file: StaticString, line: UInt)
}

