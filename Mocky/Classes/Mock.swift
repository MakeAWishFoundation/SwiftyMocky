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
