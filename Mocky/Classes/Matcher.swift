//
//  Matcher.swift
//  Mocky
//
//  Created by Andrzej Michnia on 25.10.2017.
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
