//
//  GenericAttribute.swift
//  SwiftyMocky
//
//  Created by Andrzej Michnia on 09.11.2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

/// [Internal] Used as generic constraint for generic method stubs.
public protocol GenericAttributeType {
    /// Returned value
    var value: Any { get }
    /// Used to compare with other generic attributes values
    var compare: (Any,Any,Matcher) -> Bool { get }
}

/// [Internal] Used to wrap generic parameters, for sake of generic method stubs.
public struct GenericAttribute: GenericAttributeType {
    /// Returned value
    public let value: Any
    /// Used to compare with other generic attributes
    public let compare: (Any,Any,Matcher) -> Bool

    /// Creates new GenericAttribute instance, with specified return value and compare closure
    ///
    /// - Parameters:
    ///   - value: Returned value
    ///   - compare: Used to compare with other generic attributes values
    public init(_ value: Any, _ compare: @escaping (Any,Any,Matcher) -> Bool) {
        self.value = value
        self.compare = compare
    }
}
