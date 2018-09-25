//
//  Stubbing.swift
//  SwiftyMocky
//
//  Created by Andrzej Michnia on 22.09.2018.
//  Copyright © 2018 MakeAWishFoundation. All rights reserved.
//

import Foundation

/// Generic Mock library errors
///
/// - notStubed: Calling method on mock, for which return value was not yet stubbed
public enum MockError: Error {
    case notStubed
}

/// Possible Given products. Method can (in general) either return or throw an error
///
/// - `return`: Return value
/// - `throw`: Thrown error value
public enum Product {
    case `return`(Any?)
    case `throw`(Error)

    public func casted<T>() throws -> T {
        switch self {
        case let .throw(error): throw error
        case let .return(value): return (value as? T).orFail("Casting to \(T.self) failed")
        }
    }
}

/// For internal use only! Allows to reduce Mock.generated.swif size, by moving part of implementation here.
open class StubbedMethod: WithStubbingPolicy {
    public var isValid: Bool { return index < products.count }
    public var policy: StubbingPolicy = .default

    private var products: [Product]
    private var index: Int = 0

    public init(_ products: [Product]) {
        self.products = products
        self.index = 0
    }

    public func getProduct(policy: StubbingPolicy) -> Product {
        defer { index = self.policy.real(policy).updated(index, with: products.count) }
        return products[index]
    }

    public func stub<T>(for type: T.Type) -> Stubber<T> {
        return Stubber(self, returning: T.self)
    }

    public func stubThrows<T>(for type: T.Type) -> StubberThrows<T> {
        return StubberThrows(self, returning: T.self)
    }

    fileprivate func append(_ product: Product) {
        products.append(product)
    }
}

public struct Stubber<ReturnedValue> {
    private var method: StubbedMethod
    public var policy: StubbingPolicy {
        get { return method.policy }
        set { method.policy = newValue }
    }

    public init(_ method: StubbedMethod, returning: ReturnedValue.Type) {
        self.method = method
    }

    public func `return`(_ value: ReturnedValue) {
        method.append(.return(value))
    }

    public func `return`(_ values: ReturnedValue...) {
        values.forEach(self.return)
    }
}

public struct StubberThrows<ReturnedValue> {
    private var method: StubbedMethod
    public var policy: StubbingPolicy {
        get { return method.policy }
        set { method.policy = newValue }
    }

    public init(_ method: StubbedMethod, returning: ReturnedValue.Type) {
        self.method = method
    }

    public func `return`(_ value: ReturnedValue) {
        method.append(.return(value))
    }

    public func `return`(_ values: ReturnedValue...) {
        values.forEach(self.return)
    }

    public func `throw`(_ error: Error) {
        method.append(.throw(error))
    }

    public func `throw`(_ errors: Error...) {
        errors.forEach(self.throw)
    }
}
