//
//  Mock+Assertions.swift
//  Pods
//
//  Created by przemyslaw.wosko on 19/05/2017.
//
//

import Foundation
import XCTest

// This solution works, and looks better, but autocomplete messing with types
public func Verify<T: Mock>(_ object: T, _ method: T.VerificationProxy, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
    let invocations = object.matchingCalls(method)
    XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
}

public func Given<T: Mock>(_ object: T, _ method: T.MethodProxy) {
    object.given(method)
}
