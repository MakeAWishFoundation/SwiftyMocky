//
//  Mock+Assertions.swift
//  Pods
//
//  Created by przemyslaw.wosko on 19/05/2017.
//
//

import Foundation
import XCTest

func Given<T: Mock>(_ object: T, _ method : T.MethodType, willReturn value: Any?) {
    object.given(method, willReturn: value)
}

func Verify<T: Mock>(_ object: T, _ method: T.CallType, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
    let invocations = object.matchingCalls(method)
    XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
}

func Verify<T: Mock>(_ object: T, _ method: T.MethodType, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
    let invocations = object.matchingCalls(method)
    XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
}
