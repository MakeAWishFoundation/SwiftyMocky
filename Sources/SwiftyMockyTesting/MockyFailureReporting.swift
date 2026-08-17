import Foundation
import Testing
import XCTest

/// [internal] Assertion used by generated mocks, reporting to whichever test framework is
/// running at the moment of the call.
///
/// Shadows `SwiftyMocky.MockyAssert(_:_:at:)`: a declaration from a directly imported module wins
/// over the one re-exported from `SwiftyMocky`, so a generated file that imports this module gets
/// this function without any change at the call site.
///
/// - Parameters:
///   - expression: Expression to assert on
///   - message: Message
///   - location: Call site the failure is attributed to
public func MockyAssert(
    _ expression: @autoclosure () -> Bool,
    _ message: @autoclosure () -> String = "Verify failed",
    at location: MockyLocation
) {
    if let handler = MockyAssertion.handler {
        return handler(expression(), message(), location.filePath, location.line)
    }

    guard !expression() else { return }

    switch currentRoute() {
    case .swiftTesting:
        recordIssue(message(), at: location)
    case .xctest:
        SwiftyMocky.MockyAssert(false, message(), at: location)
    case .noTestContext:
        reportOutsideOfTestContext(message(), at: location)
    }
}

/// [internal] Reports a defect in the test itself, like a method invoked on a mock that has no
/// stub defined for it, to whichever test framework is running.
///
/// - Parameters:
///   - message: Message
///   - location: Call site the failure is attributed to
public func MockyFatalFailure(_ message: String, at location: MockyLocation) {
    switch currentRoute() {
    case .swiftTesting:
        recordIssue(message, at: location)
    case .xctest:
        SwiftyMocky.MockyFatalFailure(message, at: location)
    case .noTestContext:
        reportOutsideOfTestContext(message, at: location)
    }
}

private func currentRoute() -> MockyFailureRoute {
    MockyFailureRoute.route(
        isSwiftTestingActive: Test.current != nil,
        isXCTestCaseActive: SwiftyMockyTestObserver.isTestCaseRunning
    )
}

private func recordIssue(_ message: String, at location: MockyLocation) {
    Issue.record(
        Comment(rawValue: message),
        sourceLocation: SourceLocation(
            fileID: "\(location.fileID)",
            filePath: "\(location.filePath)",
            line: Int(location.line),
            column: Int(location.column)
        )
    )
}

/// `Test.current` is a task local: it is inherited by child tasks and by `Task {}`, but it does
/// not survive `DispatchQueue.async` or `Task.detached`. A mock driven from such a context ends
/// up here, and staying quiet would turn a failed check into a passing test.
private func reportOutsideOfTestContext(_ message: String, at location: MockyLocation) {
    let text = "[SwiftyMocky] \(location.fileID):\(location.line) no active test context, "
        + "failure was not reported to any test framework: \(message)\n"
    FileHandle.standardError.write(Data(text.utf8))
    assertionFailure(message)
}
