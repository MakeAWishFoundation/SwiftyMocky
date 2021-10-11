import Foundation

//// MARK: - Equality

public extension Parameter {

    /// Returns whether given two parameters are matching each other, with following rules:
    ///
    /// 1. if parameter is .any - it is equal to any other parameter
    /// 2. if both are .value - then compare wrapped ValueType instances.
    /// 3. if they are not Equatable (or not a Sequences of Equatable), use provided matcher instance
    ///
    /// - Parameters:
    ///   - lhs: First parameter
    ///   - rhs: Second parameter
    ///   - matcher: Matcher instance
    /// - Returns: true, if first is matching second
    static func compare(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>, with matcher: Matcher) -> Bool {
        switch (lhs, rhs) {
        case (._, _): return true
        case (_, ._): return true
        case (.matching(let match), .value(let value)): return match(value)
        case (.value(let value), .matching(let match)): return match(value)
        case (.value(let left), .value(let right)):
            guard let compare = matcher.comparator(for: ValueType.self) else {
                noComparatorFailure(in: matcher)
            }
            return compare(left,right)
        default: return false
        }
    }

    /// [Internal] Wraps as generic Parameter instance. Should not be ever called directly.
    /// - Returns: Wrapped parameter
    func wrapAsGeneric() -> Parameter<GenericAttribute> {
        // TODO: - Simplify in same way as type erased attribute.
        switch self {
        case ._:
            return .value(GenericAttribute(
                value: Mirror(reflecting: ValueType.self),
                intValue: intValue,
                shortDescription: shortDescription,
                compare: { (l, r, m) -> Bool in
                    guard let lv = l as? Mirror else { return false }
                    if let rv = r as? Mirror {
                        return lv.subjectType == rv.subjectType
                    } else if let _ = r as? ValueType {
                        return true // .any comparing .value or .matching
                    } else {
                        return false
                    }
                }
            ))
        case let .value(value):
            return .value(GenericAttribute(
                value: value,
                intValue: intValue,
                shortDescription: shortDescription,
                compare: { (l, r, m) -> Bool in
                    guard let lv = l as? ValueType  else { return false }
                    if let rv = r as? ValueType {
                        let lhs = Parameter<ValueType>.value(lv)
                        let rhs = Parameter<ValueType>.value(rv)
                        return Parameter<ValueType>.compare(lhs: lhs, rhs: rhs, with: m)
                    } else if let rv = r as? ((ValueType) -> Bool) {
                        return rv(lv)
                    } else if let rv = r as? Mirror {
                        return Mirror(reflecting: ValueType.self).subjectType == rv.subjectType
                    } else {
                        return false
                    }
                }
            ))
        case let .matching(match):
            return .value(GenericAttribute(
                value: match,
                intValue: intValue,
                shortDescription: shortDescription,
                compare: { (l, r, m) -> Bool in
                    guard let lv = l as? ((ValueType) -> Bool)  else { return false }
                    if let rv = r as? ValueType {
                        let lhs = Parameter<ValueType>.matching(lv)
                        let rhs = Parameter<ValueType>.value(rv)
                        return Parameter<ValueType>.compare(lhs: lhs, rhs: rhs, with: m)
                    } else if let rv = r as? Mirror {
                        return Mirror(reflecting: ValueType.self).subjectType == rv.subjectType
                    } else {
                        return false
                    }
                }
            ))
        }
    }

    /// [Internal] Wraps as generic Parameter instance. Should not be ever called directly.
    /// - Returns: Wrapped parameter
    func typeErasedAttribute() -> Parameter<TypeErasedAttribute> {
        // A side note - compare is different to `wrapAsGeneric`, as the actual type will always match. There will be no
        // unrelated types.
        switch self {
        case ._:
            return .any
        case let .value(value):
            return .value(TypeErasedAttribute(
                value: value,
                intValue: intValue,
                shortDescription: shortDescription,
                compare: { (lattr, rattr, m) -> Bool in
                    guard let lvalue = lattr as? ValueType else { return false }
                    guard let rvalue = rattr as? ValueType else { return false }
                    return Parameter<ValueType>.compare(lhs: .value(lvalue), rhs: .value(rvalue), with: m)
                }
            ))
        case let .matching(match):
            return .matching { rattr -> Bool in
                guard let rvalue = rattr as? ValueType else { return false }
                return match(rvalue)
            }
        }
    }

    /// [Internal] Fatal error raised when no comparator or default comparator found for `ValueType`.
    static func noComparatorFailure(in matcher: Matcher) -> Swift.Never {
        let message = "No registered comparators for \(String(describing: ValueType.self))"
        print("[FATAL] \(message)")
        matcher.onFatalFailure(message)
        Failure(message)
    }
}

public extension Parameter where ValueType: TypeErasedValue {
    /// [Internal] Compare two parameters
    ///
    /// - Parameters:
    ///   - lhs: one
    ///   - rhs: other
    ///   - matcher: Matcher instance used for comparison
    /// - Returns: true if they are matching, false otherwise
    static func compare(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>, with matcher: Matcher) -> Bool {
        switch (lhs, rhs) {
        case (._, _): return true
        case (_, ._): return true
        case (.matching(let match), .value(let value)): return match(value)
        case (.value(let value), .matching(let match)): return match(value)
        case (.value(let left), .value(let right)): return left.compare(left.value,right.value,matcher)
        default: return false
        }
    }
}

// MARK: - Compare using default comparators

/// This section is required to be able to persist information about ValueType being a Sequence/Equatable.

public extension Parameter where ValueType: Sequence, ValueType: Equatable {
    /// [Internal] Compare two parameters
    ///
    /// - Parameters:
    ///   - lhs: one
    ///   - rhs: other
    ///   - matcher: Matcher instance used for comparison
    /// - Returns: true if they are matching, false otherwise
    static func compare(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>, with matcher: Matcher) -> Bool {
        switch (lhs, rhs) {
        case (._, _): return true
        case (_, ._): return true
        case (.matching(let match), .value(let value)): return match(value)
        case (.value(let value), .matching(let match)): return match(value)
        case let (.value(left), .value(right)):
            guard let compare = matcher.comparator(for: ValueType.self) else {
                noComparatorFailure(in: matcher)
            }
            return compare(left,right)
        default: return false
        }
    }

    /// [Internal] Wraps as generic Parameter instance. Should not be ever called directly.
    /// - Returns: Wrapped parameter
    func wrapAsGeneric() -> Parameter<GenericAttribute> {
        // TODO: - Simplify in same way as type erased attribute.
        switch self {
        case ._:
            return .value(GenericAttribute(
                value: Mirror(reflecting: ValueType.self),
                intValue: intValue,
                shortDescription: shortDescription,
                compare: { (l, r, m) -> Bool in
                    guard let lv = l as? Mirror else { return false }
                    if let rv = r as? Mirror {
                        return lv.subjectType == rv.subjectType
                    } else if let _ = r as? ValueType {
                        return true // .any comparing .value or .matching
                    } else {
                        return false
                    }
                }
            ))
        case let .value(value):
            return .value(GenericAttribute(
                value: value,
                intValue: intValue,
                shortDescription: shortDescription,
                compare: { (l, r, m) -> Bool in
                    guard let lv = l as? ValueType  else { return false }
                    if let rv = r as? ValueType {
                        let lhs = Parameter<ValueType>.value(lv)
                        let rhs = Parameter<ValueType>.value(rv)
                        return Parameter<ValueType>.compare(lhs: lhs, rhs: rhs, with: m)
                    } else if let rv = r as? ((ValueType) -> Bool) {
                        return rv(lv)
                    } else if let rv = r as? Mirror {
                        return Mirror(reflecting: ValueType.self).subjectType == rv.subjectType
                    } else {
                        return false
                    }
                }
            ))
        case let .matching(match):
            return .value(GenericAttribute(
                value: match,
                intValue: intValue,
                shortDescription: shortDescription,
                compare: { (l, r, m) -> Bool in
                    guard let lv = l as? ((ValueType) -> Bool)  else { return false }
                    if let rv = r as? ValueType {
                        let lhs = Parameter<ValueType>.matching(lv)
                        let rhs = Parameter<ValueType>.value(rv)
                        return Parameter<ValueType>.compare(lhs: lhs, rhs: rhs, with: m)
                    } else if let rv = r as? Mirror {
                        return Mirror(reflecting: ValueType.self).subjectType == rv.subjectType
                    } else {
                        return false
                    }
                }
            ))
        }
    }

    /// [Internal] Wraps as generic Parameter instance. Should not be ever called directly.
    /// - Returns: Wrapped parameter
    func typeErasedAttribute() -> Parameter<TypeErasedAttribute> {
        // A side note - compare is different to `wrapAsGeneric`, as the actual type will always match. There will be no
        // unrelated types.
        switch self {
        case ._:
            return .any
        case let .value(value):
            return .value(TypeErasedAttribute(
                value: value,
                intValue: intValue,
                shortDescription: shortDescription,
                compare: { (lattr, rattr, m) -> Bool in
                    guard let lvalue = lattr as? ValueType else { return false }
                    guard let rvalue = rattr as? ValueType else { return false }
                    return Parameter<ValueType>.compare(lhs: .value(lvalue), rhs: .value(rvalue), with: m)
                }
            ))
        case let .matching(match):
            return .matching { rattr -> Bool in
                guard let rvalue = rattr as? ValueType else { return false }
                return match(rvalue)
            }
        }
    }
}

public extension Parameter where ValueType: Sequence, ValueType.Element: Equatable {
    /// [Internal] Compare two parameters
    ///
    /// - Parameters:
    ///   - lhs: one
    ///   - rhs: other
    ///   - matcher: Matcher instance used for comparison
    /// - Returns: true if they are matching, false otherwise
    static func compare(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>, with matcher: Matcher) -> Bool {
        switch (lhs, rhs) {
        case (._, _): return true
        case (_, ._): return true
        case (.matching(let match), .value(let value)): return match(value)
        case (.value(let value), .matching(let match)): return match(value)
        case (.value(let left), .value(let right)):
            guard let compare = matcher.comparator(for: ValueType.self) else {
                noComparatorFailure(in: matcher)
            }
            return compare(left,right)
        default: return false
        }
    }

    /// [Internal] Wraps as generic Parameter instance. Should not be ever called directly.
    /// - Returns: Wrapped parameter
    func wrapAsGeneric() -> Parameter<GenericAttribute> {
        // TODO: - Simplify in same way as type erased attribute.
        switch self {
        case ._:
            return .value(GenericAttribute(
                value: Mirror(reflecting: ValueType.self),
                intValue: intValue,
                shortDescription: shortDescription,
                compare: { (l, r, m) -> Bool in
                    guard let lv = l as? Mirror else { return false }
                    if let rv = r as? Mirror {
                        return lv.subjectType == rv.subjectType
                    } else if let _ = r as? ValueType {
                        return true // .any comparing .value or .matching
                    } else {
                        return false
                    }
                }
            ))
        case let .value(value):
            return .value(GenericAttribute(
                value: value,
                intValue: intValue,
                shortDescription: shortDescription,
                compare: { (l, r, m) -> Bool in
                    guard let lv = l as? ValueType  else { return false }
                    if let rv = r as? ValueType {
                        let lhs = Parameter<ValueType>.value(lv)
                        let rhs = Parameter<ValueType>.value(rv)
                        return Parameter<ValueType>.compare(lhs: lhs, rhs: rhs, with: m)
                    } else if let rv = r as? ((ValueType) -> Bool) {
                        return rv(lv)
                    } else if let rv = r as? Mirror {
                        return Mirror(reflecting: ValueType.self).subjectType == rv.subjectType
                    } else {
                        return false
                    }
                }
            ))
        case let .matching(match):
            return .value(GenericAttribute(
                value: match,
                intValue: intValue,
                shortDescription: shortDescription,
                compare: { (l, r, m) -> Bool in
                    guard let lv = l as? ((ValueType) -> Bool)  else { return false }
                    if let rv = r as? ValueType {
                        let lhs = Parameter<ValueType>.matching(lv)
                        let rhs = Parameter<ValueType>.value(rv)
                        return Parameter<ValueType>.compare(lhs: lhs, rhs: rhs, with: m)
                    } else if let rv = r as? Mirror {
                        return Mirror(reflecting: ValueType.self).subjectType == rv.subjectType
                    } else {
                        return false
                    }
                }
            ))
        }
    }

    /// [Internal] Wraps as generic Parameter instance. Should not be ever called directly.
    /// - Returns: Wrapped parameter
    func typeErasedAttribute() -> Parameter<TypeErasedAttribute> {
        // A side note - compare is different to `wrapAsGeneric`, as the actual type will always match. There will be no
        // unrelated types.
        switch self {
        case ._:
            return .any
        case let .value(value):
            return .value(TypeErasedAttribute(
                value: value,
                intValue: intValue,
                shortDescription: shortDescription,
                compare: { (lattr, rattr, m) -> Bool in
                    guard let lvalue = lattr as? ValueType else { return false }
                    guard let rvalue = rattr as? ValueType else { return false }
                    return Parameter<ValueType>.compare(lhs: .value(lvalue), rhs: .value(rvalue), with: m)
                }
            ))
        case let .matching(match):
            return .matching { rattr -> Bool in
                guard let rvalue = rattr as? ValueType else { return false }
                return match(rvalue)
            }
        }
    }
}

public extension Parameter where ValueType: Sequence, ValueType.Element: Equatable, ValueType: Equatable {
    /// [Internal] Compare two parameters
    ///
    /// - Parameters:
    ///   - lhs: one
    ///   - rhs: other
    ///   - matcher: Matcher instance used for comparison
    /// - Returns: true if they are matching, false otherwise
    static func compare(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>, with matcher: Matcher) -> Bool {
        switch (lhs, rhs) {
        case (._, _): return true
        case (_, ._): return true
        case (.matching(let match), .value(let value)): return match(value)
        case (.value(let value), .matching(let match)): return match(value)
        case let (.value(left), .value(right)):
            guard let compare = matcher.comparator(for: ValueType.self) else {
                noComparatorFailure(in: matcher)
            }
            return compare(left,right)
        default: return false
        }
    }

    /// [Internal] Wraps as generic Parameter instance. Should not be ever called directly.
    /// - Returns: Wrapped parameter
    func wrapAsGeneric() -> Parameter<GenericAttribute> {
        // TODO: - Simplify in same way as type erased attribute.
        switch self {
        case ._:
            return .value(GenericAttribute(
                value: Mirror(reflecting: ValueType.self),
                intValue: intValue,
                shortDescription: shortDescription,
                compare: { (l, r, m) -> Bool in
                    guard let lv = l as? Mirror else { return false }
                    if let rv = r as? Mirror {
                        return lv.subjectType == rv.subjectType
                    } else if let _ = r as? ValueType {
                        return true // .any comparing .value or .matching
                    } else {
                        return false
                    }
                }
            ))
        case let .value(value):
            return .value(GenericAttribute(
                value: value,
                intValue: intValue,
                shortDescription: shortDescription,
                compare: { (l, r, m) -> Bool in
                    guard let lv = l as? ValueType  else { return false }
                    if let rv = r as? ValueType {
                        let lhs = Parameter<ValueType>.value(lv)
                        let rhs = Parameter<ValueType>.value(rv)
                        return Parameter<ValueType>.compare(lhs: lhs, rhs: rhs, with: m)
                    } else if let rv = r as? ((ValueType) -> Bool) {
                        return rv(lv)
                    } else if let rv = r as? Mirror {
                        return Mirror(reflecting: ValueType.self).subjectType == rv.subjectType
                    } else {
                        return false
                    }
                }
            ))
        case let .matching(match):
            return .value(GenericAttribute(
                value: match,
                intValue: intValue,
                shortDescription: shortDescription,
                compare: { (l, r, m) -> Bool in
                    guard let lv = l as? ((ValueType) -> Bool)  else { return false }
                    if let rv = r as? ValueType {
                        let lhs = Parameter<ValueType>.matching(lv)
                        let rhs = Parameter<ValueType>.value(rv)
                        return Parameter<ValueType>.compare(lhs: lhs, rhs: rhs, with: m)
                    } else if let rv = r as? Mirror {
                        return Mirror(reflecting: ValueType.self).subjectType == rv.subjectType
                    } else {
                        return false
                    }
                }
            ))
        }
    }

    /// [Internal] Wraps as generic Parameter instance. Should not be ever called directly.
    /// - Returns: Wrapped parameter
    func typeErasedAttribute() -> Parameter<TypeErasedAttribute> {
        // A side note - compare is different to `wrapAsGeneric`, as the actual type will always match. There will be no
        // unrelated types.
        switch self {
        case ._:
            return .any
        case let .value(value):
            return .value(TypeErasedAttribute(
                value: value,
                intValue: intValue,
                shortDescription: shortDescription,
                compare: { (lattr, rattr, m) -> Bool in
                    guard let lvalue = lattr as? ValueType else { return false }
                    guard let rvalue = rattr as? ValueType else { return false }
                    return Parameter<ValueType>.compare(lhs: .value(lvalue), rhs: .value(rvalue), with: m)
                }
            ))
        case let .matching(match):
            return .matching { rattr -> Bool in
                guard let rvalue = rattr as? ValueType else { return false }
                return match(rvalue)
            }
        }
    }
}

public extension Parameter where ValueType: Sequence {
    /// Element
    typealias Element = ValueType.Element
    /// [Internal] Compare two parameters
    ///
    /// - Parameters:
    ///   - lhs: one
    ///   - rhs: other
    ///   - matcher: Matcher instance used for comparison
    /// - Returns: true if they are matching, false otherwise
    static func compare(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>, with matcher: Matcher) -> Bool {
        switch (lhs, rhs) {
        case (._, _): return true
        case (_, ._): return true
        case (.matching(let match), .value(let value)): return match(value)
        case (.value(let value), .matching(let match)): return match(value)
        case let (.value(left), .value(right)):
            guard let compare = matcher.comparator(for: ValueType.self) else {
                noComparatorFailure(in: matcher)
            }
            return compare(left,right)
        default: return false
        }
    }

    /// [Internal] Wraps as generic Parameter instance. Should not be ever called directly.
    /// - Returns: Wrapped parameter
    func wrapAsGeneric() -> Parameter<GenericAttribute> {
        // TODO: - Simplify in same way as type erased attribute.
        switch self {
        case ._:
            return .value(GenericAttribute(
                value: Mirror(reflecting: ValueType.self),
                intValue: intValue,
                shortDescription: shortDescription,
                compare: { (l, r, m) -> Bool in
                    guard let lv = l as? Mirror else { return false }
                    if let rv = r as? Mirror {
                        return lv.subjectType == rv.subjectType
                    } else if let _ = r as? ValueType {
                        return true // .any comparing .value or .matching
                    } else {
                        return false
                    }
                }
            ))
        case let .value(value):
            return .value(GenericAttribute(
                value: value,
                intValue: intValue,
                shortDescription: shortDescription,
                compare: { (l, r, m) -> Bool in
                    guard let lv = l as? ValueType  else { return false }
                    if let rv = r as? ValueType {
                        let lhs = Parameter<ValueType>.value(lv)
                        let rhs = Parameter<ValueType>.value(rv)
                        return Parameter<ValueType>.compare(lhs: lhs, rhs: rhs, with: m)
                    } else if let rv = r as? ((ValueType) -> Bool) {
                        return rv(lv)
                    } else if let rv = r as? Mirror {
                        return Mirror(reflecting: ValueType.self).subjectType == rv.subjectType
                    } else {
                        return false
                    }
                }
            ))
        case let .matching(match):
            return .value(GenericAttribute(
                value: match,
                intValue: intValue,
                shortDescription: shortDescription,
                compare: { (l, r, m) -> Bool in
                    guard let lv = l as? ((ValueType) -> Bool)  else { return false }
                    if let rv = r as? ValueType {
                        let lhs = Parameter<ValueType>.matching(lv)
                        let rhs = Parameter<ValueType>.value(rv)
                        return Parameter<ValueType>.compare(lhs: lhs, rhs: rhs, with: m)
                    } else if let rv = r as? Mirror {
                        return Mirror(reflecting: ValueType.self).subjectType == rv.subjectType
                    } else {
                        return false
                    }
                }
            ))
        }
    }

    /// [Internal] Wraps as generic Parameter instance. Should not be ever called directly.
    /// - Returns: Wrapped parameter
    func typeErasedAttribute() -> Parameter<TypeErasedAttribute> {
        // A side note - compare is different to `wrapAsGeneric`, as the actual type will always match. There will be no
        // unrelated types.
        switch self {
        case ._:
            return .any
        case let .value(value):
            return .value(TypeErasedAttribute(
                value: value,
                intValue: intValue,
                shortDescription: shortDescription,
                compare: { (lattr, rattr, m) -> Bool in
                    guard let lvalue = lattr as? ValueType else { return false }
                    guard let rvalue = rattr as? ValueType else { return false }
                    return Parameter<ValueType>.compare(lhs: .value(lvalue), rhs: .value(rvalue), with: m)
                }
            ))
        case let .matching(match):
            return .matching { rattr -> Bool in
                guard let rvalue = rattr as? ValueType else { return false }
                return match(rvalue)
            }
        }
    }
}

public extension Parameter where ValueType: Equatable {
    /// [Internal] Compare two parameters
    ///
    /// - Parameters:
    ///   - lhs: one
    ///   - rhs: other
    ///   - matcher: Matcher instance used for comparison
    /// - Returns: true if they are matching, false otherwise
    static func compare(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>, with matcher: Matcher) -> Bool {
        switch (lhs, rhs) {
        case (._, _): return true
        case (_, ._): return true
        case (.matching(let match), .value(let value)): return match(value)
        case (.value(let value), .matching(let match)): return match(value)
        case let (.value(left), .value(right)):
            guard let compare = matcher.comparator(for: ValueType.self) else {
                noComparatorFailure(in: matcher)
            }
            return compare(left,right)
        default: return false
        }
    }

    /// [Internal] Wraps as generic Parameter instance. Should not be ever called directly.
    /// - Returns: Wrapped parameter
    func wrapAsGeneric() -> Parameter<GenericAttribute> {
        // TODO: - Simplify in same way as type erased attribute.
        switch self {
        case ._:
            return .value(GenericAttribute(
                value: Mirror(reflecting: ValueType.self),
                intValue: intValue,
                shortDescription: shortDescription,
                compare: { (l, r, m) -> Bool in
                    guard let lv = l as? Mirror else { return false }
                    if let rv = r as? Mirror {
                        return lv.subjectType == rv.subjectType
                    } else if let _ = r as? ValueType {
                        return true // .any comparing .value or .matching
                    } else {
                        return false
                    }
                }
            ))
        case let .value(value):
            return .value(GenericAttribute(
                value: value,
                intValue: intValue,
                shortDescription: shortDescription,
                compare: { (l, r, m) -> Bool in
                    guard let lv = l as? ValueType  else { return false }
                    if let rv = r as? ValueType {
                        let lhs = Parameter<ValueType>.value(lv)
                        let rhs = Parameter<ValueType>.value(rv)
                        return Parameter<ValueType>.compare(lhs: lhs, rhs: rhs, with: m)
                    } else if let rv = r as? ((ValueType) -> Bool) {
                        return rv(lv)
                    } else if let rv = r as? Mirror {
                        return Mirror(reflecting: ValueType.self).subjectType == rv.subjectType
                    } else {
                        return false
                    }
                }
            ))
        case let .matching(match):
            return .value(GenericAttribute(
                value: match,
                intValue: intValue,
                shortDescription: shortDescription,
                compare: { (l, r, m) -> Bool in
                    guard let lv = l as? ((ValueType) -> Bool)  else { return false }
                    if let rv = r as? ValueType {
                        let lhs = Parameter<ValueType>.matching(lv)
                        let rhs = Parameter<ValueType>.value(rv)
                        return Parameter<ValueType>.compare(lhs: lhs, rhs: rhs, with: m)
                    } else if let rv = r as? Mirror {
                        return Mirror(reflecting: ValueType.self).subjectType == rv.subjectType
                    } else {
                        return false
                    }
                }
            ))
        }
    }

    /// [Internal] Wraps as generic Parameter instance. Should not be ever called directly.
    /// - Returns: Wrapped parameter
    func typeErasedAttribute() -> Parameter<TypeErasedAttribute> {
        // A side note - compare is different to `wrapAsGeneric`, as the actual type will always match. There will be no
        // unrelated types.
        switch self {
        case ._:
            return .any
        case let .value(value):
            return .value(TypeErasedAttribute(
                value: value,
                intValue: intValue,
                shortDescription: shortDescription,
                compare: { (lattr, rattr, m) -> Bool in
                    guard let lvalue = lattr as? ValueType else { return false }
                    guard let rvalue = rattr as? ValueType else { return false }
                    return Parameter<ValueType>.compare(lhs: .value(lvalue), rhs: .value(rvalue), with: m)
                }
            ))
        case let .matching(match):
            return .matching { rattr -> Bool in
                guard let rvalue = rattr as? ValueType else { return false }
                return match(rvalue)
            }
        }
    }
}
