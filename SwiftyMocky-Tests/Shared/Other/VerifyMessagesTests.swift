import XCTest
import SwiftyMocky
#if os(iOS)
    @testable import Mocky_Example_iOS
#elseif os(tvOS)
    @testable import Mocky_Example_tvOS
#else
    @testable import Mocky_Example_macOS
#endif

class VerifyMessagesTests: XCTestCase {

    func testMessagesForMethods() {
        let mock = SimpleProtocolWithMethodsMock()


        Given(mock, .simpleMehtodThatReturns(willReturn: 1,2,3))
        Given(mock, .simpleMehtodThatReturns(param: .any, willReturn: "test"))

        func expect(message expected: String) {
            MockyAssertion.handler = { result, message, file, line in
                guard result else { return }
                XCTAssertEqual(message, expected)
            }
        }

        // At least one, but never
        expect(message: "Expected: more than or equal to 1 invocations of `.simpleMehtodThatReturns()`, but was: 0")
        Verify(mock, .simpleMehtodThatReturns())

        // Never, but was called
        mock.simpleMethod()
        expect(message: "Expected: none invocations of `.simpleMethod()`, but was: 1")
        Verify(mock, .never, .simpleMethod())
    }

    func testMessagesForProperties() {
        let mock = SimpleProtocolWithPropertiesMock()

//        Given(mock, .)
    }
}
