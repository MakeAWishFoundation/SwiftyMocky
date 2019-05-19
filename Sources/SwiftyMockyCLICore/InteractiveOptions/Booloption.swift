import Foundation
import Crayon

public enum BoolOption: RawRepresentable, SelectableOption {
    public typealias RawValue = String

    case yes
    case no

    public var rawValue: String {
        switch self {
        case .yes: return "yes"
        case .no: return "no"
        }
    }
    public var title: String {
        return crayon.underline.on("\(rawValue.first!)".uppercased()) + "\(rawValue.dropFirst())"
    }

    public init?(rawValue: String) {
        switch rawValue {
        case "Y", "y", "Yes", "yes":
            self = .yes
        case "N", "n", "No", "no":
            self = .no
        default:
            return nil
        }
    }

    public static func select() -> BoolOption {
        return select(from: [.yes, .no])
    }
}
