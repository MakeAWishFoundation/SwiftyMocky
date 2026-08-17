import Foundation

/// [internal] Reports a defect in the test itself, like a method invoked on a prototype that has
/// no stub defined for it.
///
/// - Parameters:
///   - message: Message
///   - location: Call site the failure is attributed to
public func MockyFatalFailure(_ message: String, at location: MockyLocation) {
    SwiftyMockyTestObserver.handleFatalError(
        message: message,
        file: location.filePath,
        line: location.line
    )
}
