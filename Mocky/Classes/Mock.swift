//
//  Mock.swift
//  Pods
//
//  Created by przemyslaw.wosko on 19/05/2017.
//
//

import Foundation

enum Parameter<ValueType> {
    case any
    case value(ValueType)
    
    static func ==(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>) -> Bool {
        switch (lhs, rhs) {
        default: return true
        }
    }
}

extension Parameter where ValueType: Equatable {
    
    static func ==(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>) -> Bool {
        switch (lhs, rhs) {
        case (.any, _): return true
        case (_, .any): return true
        case (.value(let value1), .value(let value2)):
            return value1 == value2
        default: return false
        }
    }
    
}

protocol Mock: class {
    
    associatedtype MethodType: Equatable
    associatedtype CallType: Equatable
    
    typealias ReturnRecord = (MethodType, Any?)
    
    var invocations: [CallType] { get set }
    var returnValues: [ReturnRecord] { get set }
}

extension Mock {
    
    func addInvocation(_ call: CallType) {
        invocations.append(call)
    }
    
    func returnValue<T>(_ methodType: MethodType) -> T {
        return returnValues.filter { (tuple: ReturnRecord) -> Bool in
            return tuple.0 == methodType
            }.last?.1 as! T
    }
    
    func returnValue<T>(_ method: MethodType, returnValue: T) -> T {
        return returnValue
    }
    
    func given(_ method: MethodType, willReturn value: Any?) {
        returnValues.append((method, value))
    }
    
    func matchingCalls(_ method: CallType) -> [CallType] {
        return invocations.filter({ (call) -> Bool in
            return method == call
        })
    }
    
    func matchingCalls(_ method: MethodType) -> [CallType] {
        return invocations.filter({ (call) -> Bool in
            return String(caseName: method) == String(caseName: call)
        })
    }
}
