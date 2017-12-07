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
    static var never: Countable { get }
    static func `in`(range: Range<Int>) -> Countable
    static func more(than: Int) -> Countable
    static func moreOrEqual(to: Int) -> Countable
    static func less(than: Int) -> Countable
    static func lessOrEqual(to: Int) -> Countable
}

public extension Countable {
    public static var never: Countable {
        return Counter() { _ in return false }
    }

    public static func `in`(range: Range<Int>) -> Countable {
        return Counter() { range.contains(Int($0)) }
    }

    public static func more(than: Int) -> Countable {
        return Counter() { $0 > than }
    }

    public static func moreOrEqual(to: Int) -> Countable {
        return Counter() { $0 >= to }
    }

    public static func less(than: Int) -> Countable {
        return Counter() { $0 < than }
    }

    public static func lessOrEqual(to: Int) -> Countable {
        return Counter() { $0 <= to }
    }
}

public struct Counter: Countable {
    let match: (Int) -> Bool

    public init(match: @escaping (Int) -> Bool) {
        self.match = match
    }

    public func matches(_ count: Int) -> Bool {
        return match(count)
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
