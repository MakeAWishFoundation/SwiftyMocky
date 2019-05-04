import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SwiftyMocky_CLITests.allTests),
    ]
}
#endif