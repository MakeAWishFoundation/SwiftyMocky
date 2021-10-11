import Foundation

// MARK: - Parameter

/// Parameter wraps method attribute, allowing to make a difference between explicit value,
/// expressed by `.value` case and wildcard value, expressed by `.any` case.
///
/// Whole idea is to be able to test and specify behaviours, in both generic and explicit way
/// (and any mix of these two). Every test method matches mock methods in signature, but changes attributes types
/// to Parameter.
///
/// That allows pattern like matching between two Parameter values:
/// - **.any** is equal to every other parameter. (**!!!** actual case name is `._`, but it is advised to use `.any`)
/// - **.value(p1)** is equal to **.value(p2)** only, when p1 == p2
///
/// **Important!** Comparing parameters, where ValueType is not Equatable will result in fatalError,
/// unless you register comparator for its *ValueType* in **Matcher** instance used (typically Matcher.default)
///
/// - any: represents and matches any parameter value
/// - value: represents explicit parameter value
public enum Parameter<ValueType> {
    /// Wildcard - any value
    case `_`
    /// Explicit value
    case value(ValueType)
    /// Any value matching
    case matching((ValueType) -> Bool)

    /// Represents and matches any parameter value - syntactic sugar for `._` case.
    public static var any: Parameter<ValueType> { return Parameter<ValueType>._ }

    /// Represents and matches any parameter value - syntactic sugar for `._` case. Used, when needs to explicitely specify
    /// wrapped *ValueType* type, to resolve ambiguity between methods with same signatures, but different attribute types.
    ///
    /// - Parameter type: Explicitly specify ValueType type
    /// - Returns: any parameter
    public static func any<T>(_ type: T.Type) -> Parameter<T> {
        return Parameter<T>._
    }

    public var shortDescription: String {
        switch self {
        case ._: return ".any"
        case .value(let value as TypeErasedValue): return value.shortDescription
        case .value(let value): return String(describing: value)
        case .matching: return ".matching(\(String(describing: ValueType.self)) -> Bool)"
        }
    }
}

// MARK: - Parameter convenience initializers

public extension Parameter where ValueType: AnyObject {

    /// Represents and matches values on an "same instance" basis.
    ///
    /// - Parameter instance: Instance to match against
    static func sameInstance<T: AnyObject>(as instance: T) -> Parameter<ValueType> {
        return .matching { this in
            guard let thisCasted = this as? T else { return false }
            return thisCasted === instance
        }
    }

    /// Represents and matches whether parameter is of specific type, using `is` operator.
    ///
    /// - Parameter type: Type to match against
    static func isInstance<T: AnyObject>(of type: T.Type) -> Parameter<ValueType> {
        return .matching { $0 is T }
    }
}

public extension Parameter {

    /// Allows combining multiple Parameter constraints into one Parameter constraint.
    ///
    /// - Parameter matching: List of parameter constraints
    static func all(_ matching: Parameter<ValueType>...) -> Parameter<ValueType> {
        return .matching { (value: ValueType) -> Bool in
            return matching.contains { (element: Parameter<ValueType>) -> Bool in
                return !Parameter<ValueType>.compare(
                    lhs: element,
                    rhs: .value(value),
                    with: Matcher.default
                )
            }
        }
    }
}

// MARK: - Ordering parameters

public extension Parameter where ValueType: TypeErasedValue {
    /// Used for invocations sorting purpose.
    var intValue: Int {
        switch self {
        case ._: return 0
        case let .value(generic): return generic.intValue
        case .matching: return 1
        }
    }
}

public extension Parameter {
    /// Used for invocations sorting purpose.
    var intValue: Int {
        switch self {
        case ._: return 0
        case .value: return 1
        case .matching: return 1
        }
    }
}
