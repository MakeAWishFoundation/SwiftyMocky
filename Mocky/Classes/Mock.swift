    //
//  Mock.swift
//  Pods
//
//  Created by przemyslaw.wosko on 19/05/2017.
//
//

import Foundation

public protocol AutoValue {}

public extension AutoValue {
    
    public var returnValue: Any? {
        get {
            let mirror = Mirror(reflecting: self)
            if let associated = mirror.children.first {
                return associated.value
            }
            assertionFailure("This case: \(self) has no value associated!")
            return nil
        }
    }
}

public protocol EnumCasesNameEquatable: Equatable {}

public extension EnumCasesNameEquatable {
    
    static func ==(_ lhs: Self,_ rhs: Self) -> Bool {
        return String(caseName: lhs) == String(caseName: rhs)
    }
}

public protocol ReturnTypeProtocol {
    func returnValue() -> Any?
}

public protocol EnumCasesComparable {}
public extension EnumCasesComparable {
    
    static func ==(_ lhs: EnumCasesComparable, _ rhs: EnumCasesComparable) -> Bool {
        return String(caseName: lhs) == String(caseName: rhs)
    }
}

public protocol Mock: class {
    associatedtype ParameterType: Equatable
    
    var invocations: [ParameterType] { get set }
}

public extension Mock {
    func addInvocation(_ call: ParameterType) {
        invocations.append(call)
    }

    func matchingCalls(_ method: ParameterType) -> [ParameterType] {
        let matchingInvocations = invocations.filter({ (call) -> Bool in
            return method == call
        })
        return matchingInvocations
    }
}
