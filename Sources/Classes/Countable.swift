//
//  Countable.swift
//  SwiftyMocky
//
//  Created by Andrzej Michnia on 07.12.2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

public protocol Countable {
    func matches(_ count: Int) -> Bool
}

public struct Count: Countable, ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = Int
    private let match: (Int) -> Bool

    public init(integerLiteral value: IntegerLiteralType) {
        self.match = { value.matches($0) }
    }

    public init(match: @escaping (Int) -> Bool) {
        self.match = match
    }

    public func matches(_ count: Int) -> Bool {
        return match(count)
    }
}

public extension Count {
    public static var never: Count { return 0 }

    public static var atLeastOnce: Count {
        return moreOrEqual(to: 1)
    }

    public static func `in`(range: CountableRange<Int>) -> Count {
        return Count() { range.contains(Int($0)) }
    }

    public static func `in`(range: CountableClosedRange<Int>) -> Count {
        return Count() { range.contains(Int($0)) }
    }

    public static func `in`(range: CountablePartialRangeFrom<Int>) -> Count {
        return Count() { range.contains(Int($0)) }
    }

    public static func more(than: Int) -> Count {
        return Count() { $0 > than }
    }

    public static func moreOrEqual(to: Int) -> Count {
        return Count() { $0 >= to }
    }

    public static func less(than: Int) -> Count {
        return Count() { $0 < than }
    }

    public static func lessOrEqual(to: Int) -> Count {
        return Count() { $0 <= to }
    }
}

extension UInt: Countable {
    public func matches(_ count: Int) -> Bool {
        return Int(self) == count
    }
}

extension Int: Countable {
    public func matches(_ count: Int) -> Bool {
        return self == count
    }
}
