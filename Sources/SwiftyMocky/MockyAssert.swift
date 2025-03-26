#if canImport(XCTest)
import XCTest
#endif
#if canImport(Testing)
import Testing
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
    public static var handler: ((Bool, String, StaticString, UInt) -> Void)?
}

/// [internal] Assertion used by mocks and Verify methods
///
/// - Parameters:
///   - expression: Expression to assert on
///   - message: Message
///   - fileId: File id (leave default)
///   - filePath: File patj (leave default)
///   - file: File name (leave default)
///   - line: Line (leave default)
///   - column: Column (leave default)
public func MockyAssert(
    _ expression: @autoclosure () -> Bool,
    _ message: @autoclosure () -> String = "Verify failed",
    fileId: StaticString = #fileID,
    filePath: StaticString = #filePath,
    file: StaticString = #file,
    line: UInt = #line,
    column: UInt = #column
) {
    guard let handler = MockyAssertion.handler else {
        return XCTMockyAssert(expression(), message(), fileId: fileId, filePath: filePath, file: file, line: line, column: column)
    }

    handler(expression(), message(), file, line)
}


/// [internal] Assertion used by mocks and Verify methods
///
/// - Parameters:
///   - expression: Expression to assert on
///   - message: Message
///   - fileId: File id (leave default)
///   - filePath: File patj (leave default)
///   - file: File name (leave default)
///   - line: Line (leave default)
///   - column: Column (leave default)
private func XCTMockyAssert(
    _ expression: @autoclosure () -> Bool,
    _ message: @autoclosure () -> String = "Verify failed",
    fileId: StaticString = #fileID,
    filePath: StaticString = #filePath,
    file: StaticString = #file,
    line: UInt = #line,
    column: UInt = #column
) {
#if canImport(Testing)
    if Test.current != nil {
        if !expression() {
            Issue.record(
                Comment(rawValue: message()),
                sourceLocation: .init(
                    fileID: fileId.description,
                    filePath: filePath.description,
                    line: Int(line),
                    column: Int(column)
                )
            )
        }
        // Return so we do not call XCTAssert if we are in a Swift Testing test.
        return
    }
#endif
    
#if canImport(XCTest)
    XCTAssert(expression(), message(), file: filePath, line: line)
#else
    assert(expression(), message(), file: file, line: line)
#endif
}
