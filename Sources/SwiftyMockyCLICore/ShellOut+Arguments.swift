import Foundation
import Commander

enum Arg {
    case flag(String)
    case argument(String)
    case namedArgument(String, name: String)

    init?<T>(_ value: T, name: String? = nil) {
        switch (value, name) {
        case (let value as Bool, let name) where value:
            self = .flag(name!)
        case (let value as ArgumentConvertible, let named) where named != nil:
            self = .namedArgument(value.description, name: named!)
        case (let value as ArgumentConvertible, _):
            self = .argument(value.description)
        default:
            return nil
        }
    }
}

extension Array where Element == String {

    static func += (lhs: inout Array<Element>, rhs: Arg?) {
        guard let element = rhs else { return }

        switch element {
        case let .flag(flag):
            lhs.append(flag)
        case let .argument(arg):
            lhs.append(arg)
        case let .namedArgument(value, name: name):
            lhs.append(name)
            lhs.append(value)
        }
    }
}
