import Foundation

// MARK: - Optionality checks

public protocol OptionalType: ExpressibleByNilLiteral {
    var isNotNil: Bool { get }
}

extension Optional: OptionalType {
    public var isNotNil: Bool {
        switch self {
        case .some: return true
        case .none: return false
        }
    }
}

public extension Parameter where ValueType: OptionalType {
    static var notNil: Parameter<ValueType> {
        return Parameter.matching { $0.isNotNil }
    }
}
