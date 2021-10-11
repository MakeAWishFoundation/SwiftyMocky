import XCTest
import SwiftyMocky
#if os(iOS)
    @testable import Mocky_Example_iOS
#elseif os(tvOS)
    @testable import Mocky_Example_tvOS
#else
    @testable import Mocky_Example_macOS
#endif

class ThrowingVarProtocolTests: XCTestCase {

    // MARK: - Tests

    @available(iOS 15.0.0, macOS 12.0.0, tvOS 15.0.0, *)
    func testThrowingVariableMethod() throws {
         let mock = ThrowingVarProtocolMock()

        // We can't specify throw value yet, since it is not supported
        Given(mock, .testVariableThatThrow(getter: true))

        // // Async keyword is not yet supported by sourcery, but casting to protocol silences warning about missing async.
        let result = try (mock as ThrowingVarProtocol).testVariableThatThrow
        XCTAssertTrue(result)
    }
}
