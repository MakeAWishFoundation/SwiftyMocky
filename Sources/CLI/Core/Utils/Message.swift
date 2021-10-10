import Foundation
import Chalk

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
        let styled = ck.bold.on("\(count). \(message)")
        just("\(styled)")
    }

    public static func subheader(_ message: String) {
        let styled = ck.bold.on(message)
        just("\(styled)")
    }

    public static func actionHeader(_ message: String) {
        let styled = ck.bold.bg(RainbowColor.Material.green900).whiteBright.on(message)
        just("\(styled)")
    }

    public static func infoPoint(_ message: String) {
        let styled = ck.bold.on(" -> \(message)")
        just("\(styled)")
    }

    public static func success(_ message: String) {
        just("✅  \(ck.greenBright.on(message))")
    }

    public static func ok(_ message: String) {
        let styled = ck.greenBright.on(" +  \(message)")
        just("\(styled)")
    }

    public static func nok(_ message: String) {
        let styled = ck.red.on(" -  \(message)")
        just("\(styled)")
    }

    public static func failure(_ message: String) {
        just("❌  \(ck.bold.red.on(message))")
    }

    public static func warning(_ message: String) {
        just("⚠️  \(ck.bold.yellow.on(message))")
    }

    public static func resolutions(_ messages: String..., title: String = "Possible solutions:") {
        resolutions(array: messages, title: title)
    }

    public static func resolutions(array messages: [String], title: String = "Possible solutions:") {
        indent()
        just("\(ck.underline.gray.on(title))")
        messages.forEach {
            let styled = ck.gray.on(" - \($0)")
            just("\(styled)")
        }
        unindent()
    }

    public static func hint(_ message: String) {
        just("\(ck.underline.gray.on(message))")
    }

    // MARK: - Misc

    public static func swiftyMockyLabel(_ message: String) {
        let bar = String(repeating: "═", count: message.count + 2)
        print(ck.bold.on("╔\(bar)╗"))
        print(ck.bold.on("║ \(message) ║"))
        print(ck.bold.on("╚\(bar)╝"))
        print("")
    }
}
