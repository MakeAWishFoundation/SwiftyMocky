//
//  Matcher.swift
//  Mocky
//
//  Created by Andrzej Michnia on 25.10.2017.
//

import Foundation

/// Matcher is container class, responsible for storing and resolving comparators for given types.
public class Matcher {
    /// Shared **Matcher** instance
    public static var `default` = Matcher()
    private var matchers: [(Mirror,Any)] = []

    /// Registers comparator for given type **T**.
    ///
    /// Comparator is a closure of `(T,T) -> Bool`.
    ///
    /// When several comparators for same type  are registered to common
    /// **Matcher** instance - it will resolve the most receont one.
    ///
    /// - Parameters:
    ///   - valueType: compared type
    ///   - match: comparator closure
    public func register<T>(_ valueType: T.Type, match: @escaping (T,T) -> Bool) {
        let mirror = Mirror(reflecting: valueType)
        matchers.append((mirror, match as Any))
    }

    /// Returns comparator closure for given type (if any).
    ///
    /// Comparator is a closure of `(T,T) -> Bool`.
    ///
    /// When several comparators for same type  are registered to common
    /// **Matcher** instance - it will resolve the most receont one.
    ///
    /// - Parameter valueType: compared type
    /// - Returns: comparator closure
    public func comparator<T>(for valueType: T.Type) -> ((T,T) -> Bool)? {
        let mirror = Mirror(reflecting: valueType)

        let comparator = matchers.reversed().first { (current, _) -> Bool in
            return current.subjectType == mirror.subjectType
            }?.1

        return comparator as? (T,T) -> Bool
    }
}
