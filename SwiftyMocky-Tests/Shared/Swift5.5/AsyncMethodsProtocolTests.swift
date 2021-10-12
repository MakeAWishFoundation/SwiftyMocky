import XCTest
import SwiftyMocky
#if os(iOS)
    #if IOS15
        @testable import Mocky_Example_iOS_15
    #else
        @testable import Mocky_Example_iOS
    #endif
#elseif os(tvOS)
    @testable import Mocky_Example_tvOS
#else
    @testable import Mocky_Example_macOS
#endif

class AsyncMethodsProtocolTests: XCTestCase {

    // MARK: - Tests

    @available(iOS 15.0.0, macOS 12.0.0, tvOS 15.0.0, *)
    func testAsyncMethod() async {
        let mock = AsyncMethodsProtocolMock()

        Given(mock, .loadListOfItems(willReturn: ["aaa", "bbb"]))

        // Async keyword is not yet supported by sourcery, but casting to protocol silences warning about missing async.
        let result = await (mock as AsyncMethodsProtocol).loadListOfItems()
        XCTAssertEqual(result, ["aaa", "bbb"])
    }
}
