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

    // MARK: - Lifecycle

    override func tearDown() {
        clearMessageExpectations()

        super.tearDown()
    }

    // MARK: - Tests

    func testMessagesForSimpleMethods() {
        let mock = SimpleProtocolWithMethodsMock()

        Given(mock, .simpleMehtodThatReturns(willReturn: 1,2,3))
        Given(mock, .simpleMehtodThatReturns(param: .any, willReturn: "test"))

        // At least one, but never
        expectMessage("Expected: more than or equal to 1 invocations of `.simpleMehtodThatReturns()`, but was: 0.")
        Verify(mock, .simpleMehtodThatReturns())

        // Never, but was called
        mock.simpleMethod()
        expectMessage("Expected: none invocations of `.simpleMethod()`, but was: 1.")
        Verify(mock, .never, .simpleMethod())

        _ = mock.simpleMehtodThatReturns(param: "a")
        _ = mock.simpleMehtodThatReturns(param: "b")
        _ = mock.simpleMehtodThatReturns(param: "c")
        _ = mock.simpleMehtodThatReturns(param: "d")
        _ = mock.simpleMehtodThatReturns(param: "e")

        expectMessage(
            """
            XCTAssertTrue failed - Expected: exactly 2 invocations of `.simpleMehtodThatReturns(param:)`, but was: 0.
            Closest calls recorded:
            1) .simpleMehtodThatReturns(param:) [50.00%]
              - (fail) param: e != z
            2) .simpleMehtodThatReturns(param:) [50.00%]
              - (fail) param: d != z
            3) .simpleMehtodThatReturns(param:) [50.00%]
              - (fail) param: c != z
            """
        )
        Verify(mock, 2, .simpleMehtodThatReturns(param: "z"))
    }

    func testMessagesForProperties() {
        let mock = ProtocolWithPropertiesMock()

        Given(mock, .email(getter: "john@mail.com"))
        Given(mock, .name(getter: "john"))

        XCTAssertNotNil(mock.email)
        XCTAssertNotNil(mock.email)
        XCTAssertNotNil(mock.email)
        XCTAssertNotNil(mock.email)

        expectMessage("XCTAssertTrue failed - Expected: exactly 2 invocations of `[get] .email`, but was: 4.")
        Verify(mock, 2, .email)

        expectMessage("XCTAssertTrue failed - Expected: from 2 to 5 invocations of `[get] .name`, but was: 0.")
        Verify(mock, .from(2, to: 5), .name)

        mock.name = "John"
        mock.name = "Joanna"
        mock.name = "Jason"
        mock.name = "Jerry"

        expectMessage(
            """
            XCTAssertTrue failed - Expected: more than or equal to 1 invocations of `[set] .name`, but was: 0.
            Closest calls recorded:
            1) [set] .name [50.00%]
              - (fail) newValue: Jerry != Anna
            2) [set] .name [50.00%]
              - (fail) newValue: Jason != Anna
            3) [set] .name [50.00%]
              - (fail) newValue: Joanna != Anna
            """
        )
        Verify(mock, .name(set: "Anna"))
    }

    func testMessagesForGenericAndMultipleParams() {
        struct DecodableType: Decodable {
            let id: Int
        }
        struct OtherType: Decodable {
            let id: Int
        }

        Matcher.default.register(DecodableType.Type.self)
        Matcher.default.register(OtherType.Type.self)

        let mock = GenericProtocolWithTypeConstraintMock()

        Given(mock, .decode(.value(DecodableType.self), from: .any, willReturn: DecodableType(id: 1)))
        Given(mock, .decode(.value(OtherType.self), from: .any, willReturn: OtherType(id: 2)))

        let data1 = Data(bytes: [1,1,1,1])
        let data2 = Data(bytes: [2,2,2,2])
        let data3 = Data(bytes: [3,3,3,3])
        let data4 = Data(bytes: [4,4,4,4])

        _ = mock.decode(DecodableType.self, from: data1)
        _ = mock.decode(DecodableType.self, from: data2)

        expectMessage(
            """
            XCTAssertTrue failed - Expected: exactly 3 invocations of `.decode(_:from:)`, but was: 0.
            Closest calls recorded:
            1) .decode(_:from:) [66.67%]
              - (fail) _ type: DecodableType != OtherType
              - (ok)   from data: 4 bytes == .any
            2) .decode(_:from:) [66.67%]
              - (fail) _ type: DecodableType != OtherType
              - (ok)   from data: 4 bytes == .any
            """
        )
        Verify(mock, 3, .decode(.value(OtherType.self), from: .any))

        _ = mock.decode(OtherType.self, from: data1)
        _ = mock.decode(OtherType.self, from: data2)
        _ = mock.decode(OtherType.self, from: data3)

        expectMessage(
            """
            XCTAssertTrue failed - Expected: more than or equal to 1 invocations of `.decode(_:from:)`, but was: 0.
            Closest calls recorded:
            1) .decode(_:from:) [66.67%]
              - (ok)   _ type: OtherType == OtherType
              - (fail) from data: 4 bytes != 4 bytes
            2) .decode(_:from:) [66.67%]
              - (ok)   _ type: OtherType == OtherType
              - (fail) from data: 4 bytes != 4 bytes
            3) .decode(_:from:) [66.67%]
              - (ok)   _ type: OtherType == OtherType
              - (fail) from data: 4 bytes != 4 bytes
            """
        )
        Verify(mock, .decode(.value(OtherType.self), from: .value(data4)))
    }

    func testMessagesWhenCustomMatch() {
        let mock = ProtocolWithThrowingMethodsMock()

        Given(mock, .methodThatReturnsAndThrows(param: .any, willReturn: false))

        _ = try? mock.methodThatReturnsAndThrows(param: 0)
        _ = try? mock.methodThatReturnsAndThrows(param: 0)
        _ = try? mock.methodThatReturnsAndThrows(param: 0)

        expectMessage(
            """
            XCTAssertTrue failed - Expected: more than or equal to 1 invocations of `.methodThatReturnsAndThrows(param:)`, but was: 0.
            Closest calls recorded:
            1) .methodThatReturnsAndThrows(param:) [50.00%]
              - (fail) param: 0 != .matching(Int -> Bool)
            2) .methodThatReturnsAndThrows(param:) [50.00%]
              - (fail) param: 0 != .matching(Int -> Bool)
            3) .methodThatReturnsAndThrows(param:) [50.00%]
              - (fail) param: 0 != .matching(Int -> Bool)
            """
        )
        Verify(mock, .methodThatReturnsAndThrows(param: .matching({ $0 > 2 })))
    }

    func testMessagesWhenManyParamters() {
        let mock = ProtocolWithMethodWithManyParametersMock()

        mock.method(param1: 0, value: "a", flagA: false, flagB: false, closure: {})
        mock.method(param1: 1, value: "b", flagA: false, flagB: false, closure: {})
        mock.method(param1: 2, value: "a", flagA: false, flagB: true, closure: {})
        mock.method(param1: 3, value: "b", flagA: false, flagB: true, closure: {})
        mock.method(param1: 4, value: "a", flagA: false, flagB: true, closure: {})

        expectMessage(
            """
            XCTAssertTrue failed - Expected: more than or equal to 1 invocations of `.method(param1:value:flagA:flagB:closure:)`, but was: 0.
            Closest calls recorded:
            1) .method(param1:value:flagA:flagB:closure:) [83.33%]
              - (fail) param1: 4 != 0
              - (ok)   value: a == a
              - (ok)   flagA: false == false
              - (ok)   flagB: true == true
              - (ok)   closure: .any == .any
            2) .method(param1:value:flagA:flagB:closure:) [83.33%]
              - (fail) param1: 2 != 0
              - (ok)   value: a == a
              - (ok)   flagA: false == false
              - (ok)   flagB: true == true
              - (ok)   closure: .any == .any
            3) .method(param1:value:flagA:flagB:closure:) [83.33%]
              - (ok)   param1: 0 == 0
              - (ok)   value: a == a
              - (ok)   flagA: false == false
              - (fail) flagB: false != true
              - (ok)   closure: .any == .any
            """
        )
        Verify(mock, .method(param1: 0, value: "a", flagA: false, flagB: true, closure: .any))

        expectMessage(
            """
            XCTAssertTrue failed - Expected: more than or equal to 1 invocations of `.method(param1:value:flagA:flagB:closure:)`, but was: 0.
            Closest calls recorded:
            1) .method(param1:value:flagA:flagB:closure:) [83.33%]
              - (ok)   param1: 3 == 3
              - (fail) value: b != z
              - (ok)   flagA: false == .any
              - (ok)   flagB: true == .any
              - (ok)   closure: .any == .any
            2) .method(param1:value:flagA:flagB:closure:) [66.67%]
              - (fail) param1: 4 != 3
              - (fail) value: a != z
              - (ok)   flagA: false == .any
              - (ok)   flagB: true == .any
              - (ok)   closure: .any == .any
            3) .method(param1:value:flagA:flagB:closure:) [66.67%]
              - (fail) param1: 2 != 3
              - (fail) value: a != z
              - (ok)   flagA: false == .any
              - (ok)   flagB: true == .any
              - (ok)   closure: .any == .any
            """
        )
        Verify(mock, .method(param1: 3, value: "z", flagA: .any, flagB: .any, closure: .any))
    }

    // MARK: - Helpers

    func expectMessage(_ expected: String) {
        MockyAssertion.handler = { result, message, file, line in
            guard result else { return }
            XCTAssertEqual(message, expected, file: file, line: line)
        }
    }

    func clearMessageExpectations() {
        MockyAssertion.handler = nil
    }
}
