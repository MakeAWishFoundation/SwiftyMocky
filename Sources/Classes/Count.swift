//
//  Count.swift
//  SwiftyMocky
//
//  Created by Kamil Wyszomierski on 24/10/2018.
//

import Foundation

/// Count enum. Use it for all Verify features, when checking how many times something happened.
///
/// There are three ways of using it:
///   1. Explicit literal - you can pass 0, 1, 2 ... to verify exact number
///   2. Using predefined .custom, to specify custom matching rule.
///   3. Using one of predefined rules, for example:
///       - .atLeastOnce
///       - .exactly(1)
///       - .from(2, to: 4)
///       - .less(than: 2)
///       - .lessOrEqual(to: 1)
///       - .more(than: 2)
///       - .moreOrEqual(to: 3)
///       - .never
public enum Count: ExpressibleByIntegerLiteral {
    /// Count matching closure
    public typealias CustomMatchingClosure = ( _ value: Int ) -> Bool
    /// [Internal] Count is represented by integer literals, with type Int
    public typealias IntegerLiteralType = Int

    /// Called at least once
    case atLeastOnce
    /// Called exactly once
    case once
    /// Custom count resolving closure
    case custom(CustomMatchingClosure)
    /// Called exactly n times
    case exactly(Int)
    /// Called in a...b range
    case from(Int, to: Int)
    /// Called less than n times
    case less(than: Int)
    /// Called less than ot equal to n times
    case lessOrEqual(to: Int)
    /// Called more than n times
    case more(than: Int)
    /// Called more than ot equal to n times
    case moreOrEqual(to: Int)
    /// Never called
    case never

    /// Creates new count instance, matching specific count
    ///
    /// - Parameter value: Exact count value
    public init(integerLiteral value: IntegerLiteralType) {
        self = .exactly(value)
    }
}

// MARK: - CustomStringConvertible
extension Count: CustomStringConvertible {
    /// Human readable description
    public var description: String {
        switch self {
        case .atLeastOnce:
            return "at least 1"
        case .once:
            return "once"
        case .custom:
            return "custom"
        case .exactly(let value):
            return "exactly \(value)"
        case .from(let lowerBound, let upperBound):
            return "from \(lowerBound) to \(upperBound)"
        case .less(let value):
            return "less than \(value)"
        case .lessOrEqual(let value):
            return "less than or equal to \(value)"
        case .more(let value):
            return "more than \(value)"
        case .moreOrEqual(let value):
            return "more than or equal to \(value)"
        case .never:
            return "none"
        }
    }
}

// MARK: - Countable
extension Count: Countable {

    /// Returns whether given count matches countable case.
    ///
    /// - Parameter count: Given count
    /// - Returns: true, if it is within boundaries, false otherwise
    public func matches(_ count: Int) -> Bool {
        switch self {
        case .atLeastOnce:
            return count >= 1
        case .once:
            return count == 1
        case .custom(let matchingRule):
            return matchingRule(count)
        case .exactly(let value):
            return count == value
        case .from(let lowerBound, to: let upperBound):
            return count >= lowerBound && count <= upperBound
        case .less(let value):
            return count < value
        case .lessOrEqual(let value):
            return count <= value
        case .more(let value):
            return count > value
        case .moreOrEqual(let value):
            return count >= value
        case .never:
            return count == 0
        }
    }
}
