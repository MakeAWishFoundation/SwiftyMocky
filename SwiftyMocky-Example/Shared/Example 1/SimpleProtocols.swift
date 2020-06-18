//
//  SimpleProtocols.swift
//  Mocky_Example
//
//  Created by Andrzej Michnia on 16.11.2017.
//  Copyright © 2017 MakeAWishFoundation. All rights reserved.
//

import Foundation

//sourcery: AutoMockable
protocol SimpleProtocolWithMethods {
    func simpleMethod()
    func simpleMehtodThatReturns() -> Int
    func simpleMehtodThatReturns(param: String) -> String
    func simpleMehtodThatReturns(optionalParam: String?) -> String?
}

//sourcery: AutoMockable
protocol SimpleProtocolWithProperties {
    var property: String { get set }
    var weakProperty: AnyObject! { get set }
    var propertyGetOnly: String { get }
    var propertyOptional: Int? { get set }
    var propertyImplicit: Int! { get set }
}

//sourcery: AutoMockable
protocol SimpleProtocolWithBothMethodsAndProperties {
    var property: String { get }
    func simpleMethod() -> String
}

//sourcery: AutoMockable
protocol SimpleProtocolThatInheritsOtherProtocols: SimpleProtocolWithMethods, SimpleProtocolWithProperties {

}
