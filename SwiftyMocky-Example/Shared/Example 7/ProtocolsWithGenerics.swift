//
//  ProtocolsWithGenerics.swift
//  Mocky_Example
//
//  Created by Andrzej Michnia on 17.11.2017.
//  Copyright © 2017 MakeAWishFoundation. All rights reserved.
//

import Foundation

//sourcery: AutoMockable
protocol ProtocolWithGenericMethods {
    func methodWithGeneric<T>(lhs: T, rhs: T) -> Bool
    func methodWithGenericConstraint<U>(param: [U]) -> U where U: Equatable
}

struct Resource<T> { }
struct Response<T> { }
struct Observable<T> { }
//sourcery: AutoMockable
protocol ProtocolWithGenericMethodsNested {
    func methodWithGeneric<T>(resource: Resource<T>) -> Observable<Response<T>>
}

//sourcery: AutoMockable
//sourcery: associatedtype = "T: Sequence"
protocol ProtocolWithAssociatedType {
    associatedtype T: Sequence

    var sequence: T { get }

    func methodWithType(t: T) -> Bool
}
