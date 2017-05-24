//
//  Parameter.swift
//  Pods
//
//  Created by przemyslaw.wosko on 19/05/2017.
//
//

import Foundation

public enum Parameter<ValueType> {
    case any
    case value(ValueType)
    
    static func ==(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>) -> Bool {
        switch (lhs, rhs) {
        default: return true
        }
    }
}

public extension Parameter where ValueType : Sequence {
    
    static func ==<ValueType: Equatable>(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>) -> Bool {
        switch (lhs, rhs) {
        case (.any, _): return true
        case (_, .any): return true
        case (.value(let lhsSequence), .value(let rhsSequence)):
            return lhsSequence == rhsSequence
        default: return false
        }
    }
    
    static func ==(lhs:Parameter<ValueType>, rhs: Parameter<ValueType>) -> Bool {
        return true
    }
}

public extension Parameter where ValueType: Equatable {
    
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
