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
    
    associatedtype SignatureType: Equatable
    associatedtype ParameterType: Equatable
    associatedtype ReturnType: AutoValue
    
    var invocations: [ParameterType] { get set }
    var returnValues: [ReturnType] { get set }
}

public extension Mock {
    
    func addInvocation(_ call: ParameterType) {
        invocations.append(call)
    }
    
    func returnValue<T>(_ methodType: SignatureType) -> T {
        return returnValues.filter({ (returnType) -> Bool in
            return String(caseName: returnType) == String(caseName: methodType)
        }).last!.returnValue as! T
    }
    
    func returnValue<T>(_ method: SignatureType, returnValue: T) -> T {
        return returnValue
    }
    
    func given(_ method: ReturnType) {
        returnValues.append(method)
    }
    
    func matchingCalls(_ method: ParameterType) -> [ParameterType] {
        print("inovcations: \(method)")
        invocations.forEach { print($0) }
        print("invocations end")
        let matchingInvocations = invocations.filter({ (call) -> Bool in
            return method == call
        })
        return matchingInvocations
    }
    
    
    func matchingCalls(_ method: SignatureType) -> [ParameterType] {
        let matchingInvocations = invocations.filter({ (call) -> Bool in
            return String(caseName: method) == String(caseName: call)
        })
        return matchingInvocations
    }
}
