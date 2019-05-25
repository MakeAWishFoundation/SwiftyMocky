import Foundation
import Crayon

public enum Message {
    public static var indentString = "  "
    private static var indentCount = 0
    private static var count = 0

    private static var indentation: String {
        guard indentCount > 0 else { return "" }
        return (1...indentCount).map { _ in return indentString }.joined()
    }

    // MARK: - Indentation

    public static func indent() { indentCount += 1 }

    public static func unindent() { indentCount = Swift.max(0, indentCount - 1) }

    // MARK: - Headers count

    public static func list() {
        count = 0
    }

    // MARK: - Formatted messages

    public static func just(_ message: String) {
        print("\(indentation)\(message)")
    }

    public static func empty() {
        print("")
    }

    public static func info(_ message: String) {
        just(message)
    }

    public static func header(_ message: String) {
        empty()
        count += 1
        let styled = crayon.bold.on("\(count). \(message)")
        just("\(styled)")
    }

    public static func subheader(_ message: String) {
        let styled = crayon.bold.on(message)
        just("\(styled)")
    }

    public static func actionHeader(_ message: String) {
        let styled = crayon.bold.bg(.darkGreen).whiteBright.on(message)
        just("\(styled)")
    }

    public static func infoPoint(_ message: String) {
        let styled = crayon.bold.on(" -> \(message)")
        just("\(styled)")
    }

    public static func success(_ message: String) {
        just("✅  \(crayon.greenBright.on(message))")
    }

    public static func ok(_ message: String) {
        let styled = crayon.greenBright.on(" +  \(message)")
        just("\(styled)")
    }

    public static func nok(_ message: String) {
        let styled = crayon.red.on(" -  \(message)")
        just("\(styled)")
    }

    public static func failure(_ message: String) {
        just("❌  \(crayon.bold.red.on(message))")
    }

    public static func warning(_ message: String) {
        just("⚠️  \(crayon.bold.yellow.on(message))")
    }

    public static func resolutions(_ messages: String..., title: String = "Possible solutions:") {
        resolutions(array: messages, title: title)
    }

    public static func resolutions(array messages: [String], title: String = "Possible solutions:") {
        indent()
        just("\(crayon.underline.gray.on(title))")
        messages.forEach { 
            let styled = crayon.gray.on(" - \($0)")
            just("\(styled)")
        }
        unindent()
    }

    public static func hint(_ message: String) {
        just("\(crayon.underline.gray.on(message))")
    }

    // MARK: - Misc

    public static func swiftyMockyLabel(_ message: String) {
        let bar = String(repeating: "═", count: message.count + 2)
        print(crayon.bold.on("╔\(bar)╗"))
        print(crayon.bold.on("║ \(message) ║"))
        print(crayon.bold.on("╚\(bar)╝"))
        print("")
    }
}
