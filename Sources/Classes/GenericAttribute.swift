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
    var value: Any { get }
    var compare: (Any,Any,Matcher) -> Bool { get }
}

/// [Internal] Used to wrap generic parameters, for sake of generic method stubs.
public struct GenericAttribute: GenericAttributeType {
    public let value: Any
    public let compare: (Any,Any,Matcher) -> Bool

    public init(_ value: Any, _ compare: @escaping (Any,Any,Matcher) -> Bool) {
        self.value = value
        self.compare = compare
    }
}
