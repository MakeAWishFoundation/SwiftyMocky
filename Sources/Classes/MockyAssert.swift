import XCTest

#if MockyCustom
public final class MockyAssertion {
    public static var handler: ((Bool, String, StaticString, UInt) -> Void)?
}

public func MockyAssert(_ expression: @autoclosure () -> Bool, _ message: @autoclosure () -> String = "Verification failed", file: StaticString = #file, line: UInt = #line) {
    guard let handler = MockyAssertion.handler else {
        assert(expression(), message(), file: file, line: line)
        return
    }

    handler(expression(), message(), file, line)
}
#else
public func MockyAssert(_ expression: @autoclosure () -> Bool, _ message: @autoclosure () -> String = "Verification failed", file: StaticString = #file, line: UInt = #line) {
    #if canImport(XCTest)
    XCTAssert(expression(), message(), file: file, line: line)
    #else
    assert(expression(), message(), file: file, line: line)
    #endif
}
#endif
