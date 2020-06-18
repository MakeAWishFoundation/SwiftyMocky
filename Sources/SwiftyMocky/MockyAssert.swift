#if canImport(XCTest)
import XCTest
#endif
import Foundation

/// [internal] Assertion used by mocks and Verify methods
///
/// - Parameters:
///   - expression: Expression to assert on
///   - message: Message
///   - file: File name (levae default)
///   - line: Line (levae default)
public func MockyAssert(
    _ expression: @autoclosure () -> Bool,
    _ message: @autoclosure () -> String = "Verification failed",
    file: StaticString = #file,
    line: UInt = #line
) {
    #if canImport(XCTest)
    XCTAssert(expression(), message(), file: file, line: line)
    #else
    assert(expression(), message(), file: file, line: line)
    #endif
}
