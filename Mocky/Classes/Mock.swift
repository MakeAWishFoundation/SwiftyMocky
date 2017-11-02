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
    associatedtype MethodProxy
    associatedtype VerificationProxy
    associatedtype PerformProxy

    func matchingCalls(_ method: VerificationProxy) -> Int
    func given(_ method: MethodProxy)
    func perform(_ method: PerformProxy)
    func verify(_ method: VerificationProxy, count: UInt, file: StaticString, line: UInt)
}
