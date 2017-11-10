//
//  GenericProtocols.swift
//  Mocky_Example
//
//  Created by Andrzej Michnia on 09.11.2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
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
