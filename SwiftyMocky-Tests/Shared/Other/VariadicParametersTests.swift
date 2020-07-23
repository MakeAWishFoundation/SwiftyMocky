import XCTest
import SwiftyMocky
#if os(iOS)
    @testable import Mocky_Example_iOS
#elseif os(tvOS)
    @testable import Mocky_Example_tvOS
#else
    @testable import Mocky_Example_macOS
#endif

class VariadicParametersTests: XCTestCase {

    // MARK: - Tests

    func testVariadicPatametersWorks() {
        let mock = VariadicParametersProtocolMock()

        Given(mock, .methodThatTakesVariadic(numbers: .any, willReturn: -1))
        Given(mock, .methodThatTakesVariadic(numbers: .value([1,2,3]), willReturn: 3))

        XCTAssertEqual(mock.methodThatTakesVariadic(numbers:1,2,3), 3)
        XCTAssertEqual(mock.methodThatTakesVariadic(numbers:2,2,2), -1)
        XCTAssertEqual(mock.methodThatTakesVariadic(numbers:0), -1)
    }
}
