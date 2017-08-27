    //
//  Mock.swift
//  Pods
//
//  Created by przemyslaw.wosko on 19/05/2017.
//
//

import Foundation
import XCTest

public protocol Mock: class {
    associatedtype MethodType: Equatable
    associatedtype MethodProxy
    
    var invocations: [MethodType] { get set }
    var methodReturnValues: [MethodProxy] { get set }

    func addInvocation(_ call: MethodType)
    func matchingCalls(_ method: MethodType) -> [MethodType]
    func given(_ method: MethodProxy)
}

public extension Mock {
    public func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    public func matchingCalls(_ method: MethodType) -> [MethodType] {
        let matchingInvocations = invocations.filter({ (call) -> Bool in
            return method == call
        })
        return matchingInvocations
    }
    
    public func given(_ method: MethodProxy) {
        methodReturnValues.append(method)
    }
}
