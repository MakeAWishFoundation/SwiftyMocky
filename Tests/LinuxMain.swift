import XCTest

import SwiftyMocky_CLITests

var tests = [XCTestCaseEntry]()
tests += SwiftyMocky_CLITests.allTests()
XCTMain(tests)