import Foundation
import Crayon

enum AddingPolicy {
    case addOnly
    case cancel
    case override
    case skipOverriding
    case onlyOverride(Int)
}

enum AddingOption: RawRepresentable {
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

    static func select(from options: [AddingOption]) -> AddingOption {
        let optionsString = options.map { $0.title }.joined(separator: ", ")
        let message = "Please choose one of possible actions: (\(optionsString))"

        var option: AddingOption?
        repeat {
            print(message)
            option = AddingOption(rawValue: readLine() ?? "")
        } while option == nil
        return option!
    }
}

public enum BoolOption: RawRepresentable {
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

    public static func select(from options: [BoolOption] = [.yes, .no]) -> BoolOption {
        let optionsString = options.map { $0.title }.joined(separator: ", ")
        let message = "Please choose one of possible actions: (\(optionsString))"

        var option: BoolOption?
        repeat {
            print(message)
            option = BoolOption(rawValue: readLine() ?? "")
        } while option == nil
        return option!
    }
}

