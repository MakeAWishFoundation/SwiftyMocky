#if canImport(XCTest)
import XCTest
#endif
import Foundation

/// You can use this class if there is need to define custom
/// assertion handler. You can use its static handler closure to alter default
/// behaviour.
///
/// If it is `nil`, the default `assert` method would be used.
public final class MockyAssertion {
    /// You can use it to define assertion behaviour.
    /// Leave blank to not assert at all.
    /// Public API, so it stays reachable from test targets compiled in the Swift 6 mode.
    nonisolated(unsafe) public static var handler: ((Bool, String, StaticString, UInt) -> Void)?
}

/// [internal] Assertion used by mocks and Verify methods
///
/// - Parameters:
///   - expression: Expression to assert on
///   - message: Message
///   - file: File name (levae default)
///   - line: Line (levae default)
public func MockyAssert(
    _ expression: @autoclosure () -> Bool,
    _ message: @autoclosure () -> String = "Verify failed",
    file: StaticString = #file,
    line: UInt = #line
) {
    guard let handler = MockyAssertion.handler else {
        return XCTMockyAssert(expression(), message(), file: file, line: line)
    }

    handler(expression(), message(), file, line)
}


/// [internal] Assertion used by generated mocks, reporting to XCTest.
///
/// `SwiftyMockyTesting` declares a function with this exact signature. Generated code that
/// imports that module resolves the call to it instead, because a declaration coming from a
/// directly imported module shadows the one re-exported from `SwiftyMocky`. That is how
/// swift-testing support is added without changing anything for a target that links
/// `SwiftyMocky` alone.
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
    MockyAssert(expression(), message(), file: location.filePath, line: location.line)
}

/// [internal] Assertion used by mocks and Verify methods
///
/// - Parameters:
///   - expression: Expression to assert on
///   - message: Message
///   - file: File name (levae default)
///   - line: Line (levae default)
private func XCTMockyAssert(
    _ expression: @autoclosure () -> Bool,
    _ message: @autoclosure () -> String = "Verify failed",
    file: StaticString = #file,
    line: UInt = #line
) {
    #if canImport(XCTest)
    XCTAssert(expression(), message(), file: file, line: line)
    #else
    assert(expression(), message(), file: file, line: line)
    #endif
}
