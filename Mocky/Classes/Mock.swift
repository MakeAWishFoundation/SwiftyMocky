    //
//  Mock.swift
//  Pods
//
//  Created by przemyslaw.wosko on 19/05/2017.
//
//

import Foundation

public protocol Mock: class {
    associatedtype ParameterType: Equatable
    associatedtype MethodProxy
    
    var invocations: [ParameterType] { get set }
    var methodReturnValues: [MethodProxy] { get set }
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
    
    func given(_ method: MethodProxy) {
        methodReturnValues.append(method)
    }
}
