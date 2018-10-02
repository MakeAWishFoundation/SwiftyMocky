//
//  Countable.swift
//  SwiftyMocky
//
//  Created by Andrzej Michnia on 07.12.2017.
//  Copyright © 2017 MakeAWishFoundation. All rights reserved.
//

import Foundation

/// Allows matching count, verifying whether given count is right or not
public protocol Countable {
    /// Returns whether given count matches countable case.
    ///
    /// - Parameter count: Given count
    /// - Returns: true, if it is within boundaries, false otherwise
    func matches(_ count: Int) -> Bool
}

/// Count object. Use it for all Verify features, when checking how many times something happened.
///
/// There are three ways of using it:
///   1. Explicit literal - you can pass 0, 1, 2 ... to verify exact number
///   2. Using init with closure, to specify matching rule like:
///      ```
///      Count() { return ... }
///      ```
///   3. Using one of predefined rules, for example:
///       - .never
///       - .atLeastOnce
///       - .in(range: 0...3)
///       - .in(range: 1..<3)
///       - .in(range: 7...)
///       - .more(than: 2)
///       - .moreOrEqual(to: 3)
///       - .less(than: 2)
///       - .lessOrEqual(to: 1)
public struct Count: Countable, ExpressibleByIntegerLiteral {
    /// [Internal] Count is represented by integer literals, with type Int
    public typealias IntegerLiteralType = Int
    /// [Internal] Matching closure
    private let match: (Int) -> Bool

    /// Creates new count instance, matching specific count
    ///
    /// - Parameter value: Exact count value
    public init(integerLiteral value: IntegerLiteralType) {
        self.match = { value.matches($0) }
    }

    /// Creates new count instance, with given way of checking, whether count is right or not
    ///
    /// - Parameter match: Count matching closure
    public init(match: @escaping (Int) -> Bool) {
        self.match = match
    }

    /// Returns whether given count matches countable case.
    ///
    /// - Parameter count: Given count
    /// - Returns: true, if it is within boundaries, false otherwise
    public func matches(_ count: Int) -> Bool {
        return match(count)
    }
}

public extension Count {
    /// Count should be exactly 0
    public static var never: Count { return 0 }

    /// Count should be 1 or more
    public static var atLeastOnce: Count {
        return moreOrEqual(to: 1)
    }

    /// Count should be within given range
    ///
    /// - Parameter range: Valid range
    /// - Returns: Count instance
    public static func `in`(range: CountableRange<Int>) -> Count {
        return Count() { range.contains(Int($0)) }
    }

    /// Count should be within given range
    ///
    /// - Parameter range: Valid range
    /// - Returns: Count instance
    public static func `in`(range: CountableClosedRange<Int>) -> Count {
        return Count() { range.contains(Int($0)) }
    }

    /// Count should be within given range
    ///
    /// - Parameter range: Valid range
    /// - Returns: Count instance
    public static func `in`(range: CountablePartialRangeFrom<Int>) -> Count {
        return Count() { range.contains(Int($0)) }
    }

    /// Count should be more than given one
    ///
    /// - Parameter than: Everything bigger than that is enough
    /// - Returns: Count instance
    public static func more(than: Int) -> Count {
        return Count() { $0 > than }
    }

    /// Count should be more or equal to given one
    ///
    /// - Parameter to: Everything that is more or equal is enough
    /// - Returns: Count instance
    public static func moreOrEqual(to: Int) -> Count {
        return Count() { $0 >= to }
    }

    /// Count should be less than given one
    ///
    /// - Parameter than: Everyting less is enough
    /// - Returns: Count instance
    public static func less(than: Int) -> Count {
        return Count() { $0 < than }
    }

    /// Count should be less or equal to given one
    ///
    /// - Parameter to: Everything equal or less is enough
    /// - Returns: Count instance
    public static func lessOrEqual(to: Int) -> Count {
        return Count() { $0 <= to }
    }
}

extension UInt: Countable {
    /// Returns whether given count matches countable case.
    ///
    /// - Parameter count: Given count
    /// - Returns: true, if it is within boundaries, false otherwise
    public func matches(_ count: Int) -> Bool {
        return Int(self) == count
    }
}

extension Int: Countable {
    /// Returns whether given count matches countable case.
    ///
    /// - Parameter count: Given count
    /// - Returns: true, if it is within boundaries, false otherwise
    public func matches(_ count: Int) -> Bool {
        return self == count
    }
}
