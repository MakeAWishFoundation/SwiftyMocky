//
//  Mock+Assertions.swift
//  Pods
//
//  Created by przemyslaw.wosko on 19/05/2017.
//
//

import Foundation
import XCTest

public protocol Veryfiable: class {
    associatedtype MethodType
    func verify(_ method: MethodType, count: UInt, file: StaticString, line: UInt)
    func matchingCalls(_ method: MethodType) -> [MethodType]
}

// This solution works, and looks better, but autocomplete messing with types
public func Verify<T: Mock>(_ object: T, _ method: T.MethodType, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
    let invocations = object.matchingCalls(method)
    XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
}
