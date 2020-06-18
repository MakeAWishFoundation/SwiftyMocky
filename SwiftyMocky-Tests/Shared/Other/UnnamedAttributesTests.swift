import XCTest
import SwiftyMocky
#if os(iOS)
    @testable import Mocky_Example_iOS
#elseif os(tvOS)
    @testable import Mocky_Example_tvOS
#else
    @testable import Mocky_Example_macOS
#endif

class UnnamedAttributesTests: XCTestCase {

    func testThatItWorks() {
        let mock = UnnamedAttributesProtocolMock()

        Given(mock, .methodWithUnnamedAttributes(willReturn: "a"))
        Given(mock, .methodWithUnnamedAndNamedAttributes(at: .any, willReturn: "a"))
        Given(mock, .methodWithUnnamedAndNamedAttributes(at: 1, willReturn: "1"))
        Given(mock, .methodWithUnnamedAndNamedAttributes(at: 2, willReturn: "2"))

        XCTAssertEqual(mock.methodWithUnnamedAttributes(0), "a")
        XCTAssertEqual(mock.methodWithUnnamedAttributes(1), "a")
        XCTAssertEqual(mock.methodWithUnnamedAttributes(2), "a")
        XCTAssertEqual(mock.methodWithUnnamedAttributes(3), "a")

        XCTAssertEqual(mock.methodWithUnnamedAndNamedAttributes(at: 0, 0), "a")
        XCTAssertEqual(mock.methodWithUnnamedAndNamedAttributes(at: 0, 1), "a")
        XCTAssertEqual(mock.methodWithUnnamedAndNamedAttributes(at: 0, 2), "a")
        XCTAssertEqual(mock.methodWithUnnamedAndNamedAttributes(at: 1, 0), "1")
        XCTAssertEqual(mock.methodWithUnnamedAndNamedAttributes(at: 1, 1), "1")
        XCTAssertEqual(mock.methodWithUnnamedAndNamedAttributes(at: 1, 2), "1")
        XCTAssertEqual(mock.methodWithUnnamedAndNamedAttributes(at: 2, 0), "2")
        XCTAssertEqual(mock.methodWithUnnamedAndNamedAttributes(at: 2, 1), "2")
        XCTAssertEqual(mock.methodWithUnnamedAndNamedAttributes(at: 2, 2), "2")
    }
}
