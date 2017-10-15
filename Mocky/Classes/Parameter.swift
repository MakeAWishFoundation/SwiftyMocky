//
//  Parameter.swift
//  Pods
//
//  Created by przemyslaw.wosko on 19/05/2017.
//
//

import Foundation

public class Matcher {
    public static var `default` = Matcher()

    var matchers: [(Mirror,Any)] = []

    public init() {
    }

    public func register<T>(_ valueType: T.Type, match: @escaping (T,T) -> Bool) {
        let mirror = Mirror(reflecting: valueType)
        matchers.append((mirror, match as Any))
    }

    public func comparator<T>(for valueType: T.Type) -> ((T,T) -> Bool)? {
        let mirror = Mirror(reflecting: valueType)

        let comparator = matchers.reversed().first { (current, _) -> Bool in
            return current.subjectType == mirror.subjectType
        }?.1

        return comparator as? (T,T) -> Bool
    }
}

public enum Parameter<ValueType> {
    case any(ValueType.Type)
    case value(ValueType)
    
    public static func ==(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>) -> Bool {
        print("Parameter not equatable")
        switch (lhs, rhs) {
            default: return true
        }
    }

    public static func compare(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>, with matcher: Matcher) -> Bool {
        print("Parameter not equatable")
        switch (lhs, rhs) {
            case (.any, _): return true
            case (_, .any): return true
            case (.value(let lhsValue), .value(let rhsValue)):
                guard let compare = matcher.comparator(for: ValueType.self) else {
                    fatalError("No registered comparators for \(String(describing: ValueType.self))")
                }
                return compare(lhsValue,rhsValue)
            default: return true
        }
    }
}

public extension Parameter where ValueType : Sequence {
    
    public static func ==<ValueType: Equatable>(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>) -> Bool {
        print("Parameter is sequence")
        switch (lhs, rhs) {
            case (.any, _): return true
            case (_, .any): return true
            case (.value(let lhsSequence), .value(let rhsSequence)):
                return lhsSequence == rhsSequence
            default: return false
        }
    }

    public static func compare(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>, with matcher: Matcher) -> Bool {
        print("Parameter is sequence")
        switch (lhs, rhs) {
            case (.any, _): return true
            case (_, .any): return true
            case (.value(let lhsSequence), .value(let rhsSequence)):
                let leftArray = lhsSequence.map { $0 }
                let rightArray = rhsSequence.map { $0 }

                guard leftArray.count == rightArray.count else { return false }

                let values = (0..<leftArray.count).map { i -> (ValueType.Iterator.Element, ValueType.Iterator.Element) in
                    return (leftArray[i],rightArray[i])
                }

                guard let comparator = matcher.comparator(for: ValueType.Iterator.Element.self) else {
                    fatalError("No registered comparators for \(String(describing: ValueType.self))")
                }

                for (left,right) in values {
                    guard comparator(left, right) else {
                        return false
                    }
                }

                return true
            default: return false
        }
    }
}

public extension Parameter where ValueType: Equatable {
    
    public static func ==(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>) -> Bool {
        print("Parameter is equatable")
        switch (lhs, rhs) {
            case (.any, _): return true
            case (_, .any): return true
            case (.value(let value1), .value(let value2)):
                return value1 == value2
            default: return false
        }
    }

    public static func compare(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>, with matcher: Matcher) -> Bool {
        return lhs == rhs
    }
}
