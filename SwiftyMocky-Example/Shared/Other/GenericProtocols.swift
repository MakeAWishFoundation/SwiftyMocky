//
//  GenericProtocols.swift
//  Mocky_Example
//
//  Created by Andrzej Michnia on 09.11.2017.
//  Copyright © 2017 MakeAWishFoundation. All rights reserved.
//

import Foundation

//sourcery: AutoMockable
public protocol DateSortable {
    var date: Date { get }
}

//sourcery: AutoMockable
public protocol HistorySectionMapperType: class {
    func map<T: DateSortable>(_ items: [T]) ->  [(key: String, items: [T])]
}

//sourcery: AutoMockable
public protocol AVeryGenericProtocol {
    func methodConstrained<A,B,C>(param: A) -> (B,C)

    init<V>(value: V)

    static func generic<Q>(lhs: Q, rhs: Q) -> Bool where Q: Equatable
    static func veryConstrained<Q: Sequence>(lhs: Q, rhs: Q) -> Bool where Q: Equatable
}

//sourcery: AutoMockable
//sourcery: associatedtype = "T1: Sequence"
//sourcery: associatedtype = "T2: Comparable, EmptyProtocol"
protocol AVeryAssociatedProtocol {
    associatedtype T1: Sequence
    associatedtype T2: Comparable, EmptyProtocol

    func fetch(for value: T2) -> T1
}

//sourcery: AutoMockable
protocol GenericProtocolWithTypeConstraint {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) -> T
    func test<FOO>(_ type: FOO.Type) -> Int
}

//sourcery: AutoMockable
//sourcery: associatedtype = "T: Sequence where T.Element: Equatable"
protocol ProtocolWithWhereAfterDefinition {
    associatedtype T: Sequence where T.Element: Equatable

    var sequence: T { get }

    func methodWithType(t: T) -> Bool
}

protocol GenericProtocolReturningInt: AutoMockable {
    func value<T>(for value: T) -> Int
}

protocol ProtocolWithMethodsWithGenericReturnTypeThatThrows: AutoMockable {
    func max<Type: Comparable>(
        for attribute: Int,
        over samples: [Int],
        per aggregationUnit: String?
    ) throws -> [(date: String?, value: Type)]
}
