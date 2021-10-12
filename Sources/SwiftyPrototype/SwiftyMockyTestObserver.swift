import Foundation

public class SwiftyMockyTestObserver: NSObject {
    /// [Internal] No setup whatsoever
    @objc public static func setup() {
        // Empty on purpose
    }

    public static func handleFatalError(message: String, file: StaticString, line: UInt) {
        // Empty on purpose
    }
}
