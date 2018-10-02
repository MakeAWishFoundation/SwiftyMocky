//
//  File.swift
//  Mocky
//
//  Created by Andrzej Michnia on 28.09.2018.
//  Copyright © 2018 MakeAWishFoundation. All rights reserved.
//

import Foundation

struct Mytest<Key, Value> {
    let value: Value
    let key: Key
}

//sourcery: AutoMockable
protocol EdgeCasesGenericsProtocol {
    func sorted<Key, Value>(by key: Mytest<Key, Value>)
    func getter<K,V: Sequence,T>(swapped key: Mytest<K,V>) -> T
}

//sourcery: AutoMockable
protocol FailsWithUntagged {
    init<T>(with t: T) where T:Equatable
    func foo<T>(_: T, bar : String) where T: Sequence // wrong formatted
}


//sourcery: AutoMockable
protocol FailsWithKeywordArguments {
    func foo(for: String)
    func `throw`(while: String) -> Error
    func `return`(do while: String) -> Bool

    var `throw`: Error { get set }
    subscript (_ return: Int) -> Bool { get set }
}

//sourcery: AutoMockable
protocol ShouldAllowNoStubDefined {
    static var property: Int? { get }
    var property: Int? { get }
    subscript (_ x: Int) -> Int? { get }
    func voidMethod(_ key: String) -> Void
    func throwingVoidMethod(_ key: String) throws -> Void
    func optionalMethod(_ key: String) -> Int?
    func optionalThrowingMethod(_ key: String) -> Int?
    static func voidMethod(_ key: String) -> Void
    static func throwingVoidMethod(_ key: String) throws -> Void
    static func optionalMethod(_ key: String) -> Int?
    static func optionalThrowingMethod(_ key: String) -> Int?
}
