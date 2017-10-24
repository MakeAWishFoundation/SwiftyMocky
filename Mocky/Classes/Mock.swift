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
    associatedtype MethodType
    associatedtype MethodProxy
    associatedtype VerificationProxy
    
    var invocations: [MethodType] { get set }
    var methodReturnValues: [MethodProxy] { get set }

    func addInvocation(_ call: MethodType)
    func matchingCalls(_ method: MethodType) -> [MethodType]
    func matchingCalls(_ method: VerificationProxy) -> [MethodType]
    func given(_ method: MethodProxy)
}
