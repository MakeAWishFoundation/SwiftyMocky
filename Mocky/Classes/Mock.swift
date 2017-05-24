    //
//  Mock.swift
//  Pods
//
//  Created by przemyslaw.wosko on 19/05/2017.
//
//

import Foundation

public protocol Mock: class {
    associatedtype MethodType: Equatable
    associatedtype MethodProxy
    
    var invocations: [MethodType] { get set }
    var methodReturnValues: [MethodProxy] { get set }
}

public extension Mock {
    func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    func matchingCalls(_ method: MethodType) -> [MethodType] {
        let matchingInvocations = invocations.filter({ (call) -> Bool in
            return method == call
        })
        return matchingInvocations
    }
    
    func given(_ method: MethodProxy) {
        methodReturnValues.append(method)
    }
}
