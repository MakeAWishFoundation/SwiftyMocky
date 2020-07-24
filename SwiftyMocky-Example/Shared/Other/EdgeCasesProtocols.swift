//
//  File.swift
//  Mocky
//
//  Created by Andrzej Michnia on 28.09.2018.
//  Copyright © 2018 MakeAWishFoundation. All rights reserved.
//

import Foundation

// MARK: - Issue 240 - generating mocks when attributes depends on generic constraints and other attributes associated types

protocol StringConvertibleType { }

//sourcery: AutoMockable
//sourcery: associatedtype = "ValueType: StringConvertibleType"
protocol ProtocolWithAssociatedType2 {
    associatedtype ValueType: StringConvertibleType
    var property: String { get }
}

//sourcery: AutoMockable
protocol AnotherProtocol {
    func doSomething<T: ProtocolWithAssociatedType2>(type: T) -> T.ValueType?
    func doSomething2<T: ProtocolWithAssociatedType2>(type: T, withValue: T.ValueType?)
}

// MARK: - Edge case for generics

struct Mytest<Key, Value> {
    let value: Value
    let key: Key
}

//sourcery: AutoMockable
protocol EdgeCasesGenericsProtocol {
    func sorted<Key, Value>(by key: Mytest<Key, Value>)
    func getter<K,V: Sequence,T: Equatable>(swapped key: Mytest<K,V>) -> T
}

// MARK: - Failing because of untagged attribute

//sourcery: AutoMockable
protocol FailsWithUntagged {
    init<T>(with t: T) where T:Equatable
    func foo<T>(_: T, bar : String) where T: Sequence // wrong formatted
}

// MARK: - Issue when names are escaped with backtick

//sourcery: AutoMockable
protocol FailsWithKeywordArguments {
    func foo(for: String)
    func `throw`(while: String) -> Error
    func `return`(do while: String) -> Bool

    var `throw`: Error { get set }
    subscript (_ return: Int) -> Bool { get set }
}

// MARK: - Should allow no stub

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

// MARK: - Autoclosure issues

//sourcery: AutoMockable
protocol FailsWithAutoClosureOnSwift5 {
    func connect(_ token: @autoclosure () -> String) -> Bool
}

// MARK: - Generics with Self

//sourcery: AutoMockable
protocol FailsWithReturnedTypeBeingGenericOfSelf: class {
    func methodWillReturnSelfTypedArray() -> Array<Self>
    func methodWillReturnSelfTypedArray2() -> [Self]
    func methodWillReturnSelfTypedCustom() -> CustomGeneric<Self>
    func test(value: Self) -> Bool
    func insanetTest(value: CustomGeneric<[Self]>) -> Bool
}

struct CustomGeneric<T> {
    let t: T
}

//sourcery: typealias = "A = WithConflictingNameMock.A"
protocol WithConflictingName: AutoMockable {
    typealias A = Int

    func test(with attribute: A) -> Bool
}
