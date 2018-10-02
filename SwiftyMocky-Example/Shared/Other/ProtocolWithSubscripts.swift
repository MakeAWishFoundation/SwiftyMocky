//
//  ProtocolWithSubscripts.swift
//  SwiftyMocky
//
//  Created by Andrzej Michnia on 26/09/2018.
//  Copyright © 2018 MakeAWishFoundation. All rights reserved.
//

import Foundation

//sourcery: AutoMockable
protocol ProtocolWithSubscripts {
    func aaa(_ value: Int) -> Bool
    var something: Any { get set }
    subscript (_ index: Int) -> String { get set }
    subscript (labeled index: Int) -> String { get set }
    subscript (x: Int, y: Int) -> String { get set }
    subscript (_ index: String) -> String { get set }
    subscript (index index: String) -> String { get set }
    subscript (label name: String) -> Int { get }
    //sourcery: associatedtype = "T: Sequence"
    subscript<T: Sequence>(with generic: T) -> Bool where T.Element: Equatable { get set }
    //sourcery: associatedtype = "T: FloatingPoint"
    subscript<T>(with generic: T) -> Int where T: FloatingPoint { get set }
    //sourcery: associatedtype = "T"
    subscript<T>(_ i: Int, type: T.Type) -> T { get set }
    subscript (closure c: @escaping (Int) -> Void) -> Bool { get set }

    subscript (same same: Int) -> Bool { get set }
    subscript (same same: Int) -> Int { get set }
}

//sourcery: AutoMockable
protocol ProtocolWithDeprecatedMembers {
    func method(_ value: Int) -> Bool
}

//sourcery: AutoMockable
protocol ProtocolWithConflictingMembers {
    func method(withLabel value: Int) -> Bool
    func method(_ value: Int) -> Bool
    func method(value: Int) -> Bool
}
