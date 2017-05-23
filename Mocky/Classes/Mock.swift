    //
//  Mock.swift
//  Pods
//
//  Created by przemyslaw.wosko on 19/05/2017.
//
//

import Foundation

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

    func given(_ method: ReturnType) {
        returnValues.append(method)
    }
    
    func matchingCalls(_ method: ParameterType) -> [ParameterType] {
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
