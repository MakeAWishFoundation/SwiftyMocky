import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CommandLineInterfaceTests.allTests),
    ]
}
#endif