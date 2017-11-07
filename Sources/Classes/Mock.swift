//
//  Mock.swift
//  Pods
//
//  Created by przemyslaw.wosko on 19/05/2017.
//
//

import Foundation
import XCTest

/// Every generated mock implementation adopts **Mock** protocol.
/// It defines base Mock structure
public protocol Mock: class {
    associatedtype MethodProxy
    associatedtype VerificationProxy
    associatedtype PerformProxy

    /// Returns number of invocations of given method (with matching attributes).
    ///
    /// - Parameter method: signature, with attributes (any or explicit value). Type `.` for all available
    /// - Returns: How many times, stub for given signature was called
    func matchingCalls(_ method: VerificationProxy) -> Int

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
    func given(_ method: MethodProxy)

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
    func perform(_ method: PerformProxy)

    /// Verifies, that given method stub was called exact number of times.
    ///
    /// - Parameters:
    ///   - method: Method signature with wrapped parameters (Parameter<ValueType>)
    ///   - count: Number of invocations
    ///   - file: for XCTest print purposes
    ///   - line: for XCTest print purposes
    func verify(_ method: VerificationProxy, count: UInt, file: StaticString, line: UInt)
}
