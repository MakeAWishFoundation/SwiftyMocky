import Foundation

/// [internal] Reports a defect in the test itself, like a method invoked on a mock that has no
/// stub defined for it, to XCTest.
///
/// Shadowed by `SwiftyMockyTesting` the same way `MockyAssert(_:_:at:)` is, so that a missing
/// stub is reported to whichever test framework is running.
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
