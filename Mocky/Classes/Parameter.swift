//
//  Parameter.swift
//  Pods
//
//  Created by przemyslaw.wosko on 19/05/2017.
//
//

import Foundation

/// Parameter wraps method attribute, allowing to make a difference between explicit value,
/// expressed by .value case and wildcard value, expressed by .any case.
///
/// That allows pattern like matching between two Parameter values:
/// - **.any** is equal to every other parameter
/// - **.value(p1)** is equal to **.value(p2)** only, when p1 == p2
///
/// **Important!** Comparing parameters, where ValueType is not Equatable will result in fatalError,
/// unless you register comparator for its *ValueType* in **Matcher** instance used (typically Matcher.default)
///
/// - any: represents and matches any parameter value
/// - value: represents explicit parameter value
public enum Parameter<ValueType> {
    case any(ValueType.Type)
    case value(ValueType)
}

// MARK: - Order
public extension Parameter {
    public var intValue: Int {
        switch self {
            case .any: return 0
            case .value: return 1
        }
    }
}

// MARK: - Equality
public extension Parameter {
    public static func ==(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>) -> Bool {
        debugPrint("Parameter not equatable \(ValueType.self)")
        return true
    }

    public static func compare(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>, with matcher: Matcher) -> Bool {
        debugPrint("Parameter not equatable \(ValueType.self)")
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

public extension Parameter where ValueType: Equatable {
    public static func ==(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>) -> Bool {
        debugPrint("Parameter is equatable \(ValueType.self)")
        switch (lhs, rhs) {
        case (.any, _): return true
        case (_, .any): return true
        case (.value(let value1), .value(let value2)):
            return value1 == value2
        default: return false
        }
    }

    public static func compare(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>, with matcher: Matcher) -> Bool {
        debugPrint("Parameter is equatable \(ValueType.self)")
        return lhs == rhs
    }
}

public extension Parameter where ValueType: Sequence {
    public static func compare(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>, with matcher: Matcher) -> Bool {
        debugPrint("Parameter is sequence \(ValueType.self) where \(ValueType.Element.self) is not Equatable")
        switch (lhs, rhs) {
        case (.any, _): return true
        case (_, .any): return true
        case (.value(let lhsSequence), .value(let rhsSequence)):
            let leftArray = lhsSequence.map { $0 }
            let rightArray = rhsSequence.map { $0 }

            guard leftArray.count == rightArray.count else { return false }

            let values = (0..<leftArray.count)
                .map { i -> (ValueType.Element, ValueType.Element) in
                    return ((leftArray[i]),(rightArray[i]))
            }

            guard let comparator = matcher.comparator(for: ValueType.Element.self) else {
                fatalError("Not registered comparator for \(ValueType.Element.self)")
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

public extension Parameter where ValueType: Sequence, ValueType.Element: Equatable {
    public static func compare(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>, with matcher: Matcher) -> Bool {
        debugPrint("Parameter is sequence \(ValueType.self) where \(ValueType.Element.self) is Equatable")
        switch (lhs, rhs) {
        case (.any, _): return true
        case (_, .any): return true
        case (.value(let lhsSequence), .value(let rhsSequence)):
            let leftArray = lhsSequence.map { $0 }
            let rightArray = rhsSequence.map { $0 }

            guard leftArray.count == rightArray.count else { return false }

            let values = (0..<leftArray.count)
                .map { i -> (ValueType.Element, ValueType.Element) in
                    return ((leftArray[i]),(rightArray[i]))
            }

            for (left,right) in values {
                guard left == right else { return false }
            }

            return true
        default: return false
        }
    }
}

public extension Parameter where ValueType: Sequence, ValueType.Element: Equatable, ValueType: Equatable {
    public static func ==(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>) -> Bool {
        debugPrint("Parameter is equatable sequence")
        switch (lhs, rhs) {
        case (.any, _): return true
        case (_, .any): return true
        case (.value(let lhsSequence), .value(let rhsSequence)):
            return lhsSequence == rhsSequence
        default: return false
        }
    }

    public static func compare(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>, with matcher: Matcher) -> Bool {
        return lhs == rhs
    }
}
