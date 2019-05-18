import Foundation
import Crayon

// MARK: - Setup policy

enum AddingPolicy {
    case addOnly
    case cancel
    case override
    case skipOverriding
    case onlyOverride(Int)
}

// MARK: - Selectable option

enum AddingOption: RawRepresentable, SelectableOption {
    typealias RawValue = String

    case add
    case cancel
    case override
    case only(Int)

    var rawValue: String {
        switch self {
        case .add: return "add not defined"
        case .cancel: return "cancel"
        case .override: return "override all"
        case .only(let value): return "\(value)"
        }
    }
    var title: String {
        switch self {
        case .only(let value):
            return crayon.underline.on("\(value)") + ""
        default:
            return crayon.underline.on("\(rawValue.first!)".uppercased()) + "\(rawValue.dropFirst())"
        }
    }

    var policy: AddingPolicy {
        switch self {
        case .add: return .skipOverriding
        case .cancel: return .cancel
        case .override: return .override
        case .only(let value): return .onlyOverride(value)
        }
    }

    init?(rawValue: String) {
        switch rawValue {
        case "A", "a", "Add", "add":
            self = .add
        case "C", "c", "Cancel", "cancel":
            self = .cancel
        case "O", "o", "Override", "override":
            self = .override
        case let n where Int(n) != nil:
            self = .only(Int(n)!)
        default:
            return nil
        }
    }
}
