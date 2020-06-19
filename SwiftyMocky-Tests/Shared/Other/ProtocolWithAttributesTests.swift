import XCTest
import SwiftyMocky
#if os(iOS)
    @testable import Mocky_Example_iOS
#elseif os(tvOS)
    @testable import Mocky_Example_tvOS
#else
    @testable import Mocky_Example_macOS
#endif

class ProtocolWithAttributesTests: XCTestCase {

    @available(iOS 14, *)
    func testThatItWorks() {
        let mock = ProtocolWithAttributesMock()
        Verify(mock, .never, .funcA())
        mock.funcA()
        Verify(mock, .once, .funcA())
    }

    func testProtocolB() {
        let mock = ProtocolWithAttributesBMock()

        Given(mock, .inlinableFunc(.any, willReturn: 2,1,4))
        Verify(mock, .never, .inlinableFunc(.any))

        mock.inlinableFunc(0)

        Verify(mock, .once, .inlinableFunc(.any))

        if #available(iOS 14, *) {
            let dep = ProtocolWithAttributesMock()
            Verify(mock, .never, .funcB(.any))
            mock.funcB(dep)
            Verify(mock, .once, .funcB(.any))
        }
    }
}
