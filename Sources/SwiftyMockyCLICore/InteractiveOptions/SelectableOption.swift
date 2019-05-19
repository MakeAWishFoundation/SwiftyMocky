import Foundation
import Crayon

public protocol SelectableOption: RawRepresentable {
    var title: String { get }

    static func message(from options: [Self]) -> String
    static func select(from options: [Self]) -> Self
}

public extension SelectableOption where RawValue == String {

    static func message(from options: [Self]) -> String {
        let optionsString = options.map { $0.title }.joined(separator: ", ")
        return "> Please choose one of possible actions: (\(optionsString))"
    }

    static func select(from options: [Self]) -> Self {
        var option: Self?
        repeat {
            Message.empty()
            Message.subheader(message(from: options))
            option = Self(rawValue: readLine() ?? "")
        } while option == nil
        return option!
    }
}
