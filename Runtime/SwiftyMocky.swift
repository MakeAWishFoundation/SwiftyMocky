import Foundation

// MARK: - XCTestObserver

#if Mocky
import XCTest

/// Used for observing tests and handling internal library errors.
public class SwiftyMockyTestObserver: NSObject, XCTestObservation {
    /// [Internal] Current test case
    private static var currentTestCase: XCTestCase?
    /// [Internal] Setup observing once
    private static let setupBlock: (() -> Void) = {
        XCTestObservationCenter.shared.addTestObserver(SwiftyMockyTestObserver())
        return {}
    }()

    /// Call this method to setup custom error handling for SwiftyMocky, that allows to gracefully handle missing stub fatal errors.
    /// In general it should be done automatically and there should be no reason to call it directly.
    @objc public static func setup() {
        setupBlock()
    }

    /// [Internal] Observer for test start
    ///
    /// - Parameter testCase: current test
    public func testCaseWillStart(_ testCase: XCTestCase) {
        SwiftyMockyTestObserver.currentTestCase = testCase
    }

    /// [Internal] Observer for test finished
    ///
    /// - Parameter testCase: current test
    public func testCaseDidFinish(_ testCase: XCTestCase) {
        SwiftyMockyTestObserver.currentTestCase = nil
    }

    /// [Internal] used to notify that stub return value was not found. Do not call it directly.
    ///
    /// - Parameters:
    ///   - message: Message
    ///   - file: File
    ///   - line: Line
    public static func handleMissingStubError(message: String, file: StaticString, line: UInt) {
        guard let testCase = SwiftyMockyTestObserver.currentTestCase else {
            XCTFail(message, file: file, line: line)
            return
        }

        let continueAfterFailure = testCase.continueAfterFailure
        defer { testCase.continueAfterFailure = continueAfterFailure }
        testCase.continueAfterFailure = false
        let methodName = getNameOfExtecutedTestCase(testCase)
        if let name = methodName, let failingLine = FilesExlorer().findTestCaseLine(for: name, file: file) {
            testCase.recordFailure(withDescription: message, inFile: file.description, atLine: Int(failingLine), expected: false)
        } else if let name = methodName {
            XCTFail("\(name) - \(message)", file: file, line: line)
        } else {
            XCTFail(message, file: file, line: line)
        }
    }

    /// [Internal] Geting name of current test
    ///
    /// - Parameter testCase: Test case
    /// - Returns: Name
    private static func getNameOfExtecutedTestCase(_ testCase: XCTestCase) -> String? {
        return testCase.name.components(separatedBy: " ")[1].components(separatedBy: "]").first
    }
}

/// [Internal] Internal dependency that looks for line of test case, that caused test failure.
private class FilesExlorer {
    /// Parses test case file to get line number assigned with test
    ///
    /// - Parameter testCase: Test case
    /// - Parameter file: File we should look in
    /// - Returns: Line number or nil, if unable to find
    func findTestCaseLine(for methodName: String, file: StaticString) -> UInt? {
        guard let content = getFileContent(file: file.description) else {
            return nil
        }
        let lines = content.components(separatedBy: "\n")
        let offset = lines.enumerated().first { (index, line) -> Bool in
            return line.contains(methodName)
        }?.offset
        guard let line = offset else { return nil }
        let lineAdditionalOffset: UInt = 2 // just to show error within test case, below the name.
        return UInt(line) + lineAdditionalOffset
    }

    private func getFileContent(file: String) -> String? {
        // TODO: look for file encoding from file attributes
        guard let fileData = FileManager().contents(atPath: file) else { return nil }
        return String(data: fileData, encoding: .utf8) ?? String(data: fileData, encoding: .utf16)
    }
}
#else
/// Used for observing tests and handling internal library errors.
public class SwiftyMockyTestObserver: NSObject {
    /// [Internal] No setup whatsoever
    @objc public static func setup() {
        // Empty on purpose
    }
}
#endif

// MARK: - Custom assertions

#if Mocky
/// Allows to verify if error was thrown, and if it is of given type.
///
/// - Parameters:
///   - expression: Expression
///   - error: Expected error type
///   - message: Optional message
///   - file: File (optional)
///   - line: Line (optional)
public func XCTAssertThrowsError<T, E: Error>(_ expression: @autoclosure () throws -> T, of error: E.Type, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) {
    let throwMessage = message().isEmpty ? "Expected \(T.self) thrown" : message()
    XCTAssertThrowsError(expression, throwMessage, file: file, line: line) { errorThrown in
        let typeMessage = message().isEmpty ? "Expected \(T.self), got \(String(describing: errorThrown))" : message()
        XCTAssertTrue(errorThrown is E, typeMessage, file: file, line: line)
    }
}

/// Allows to verify if error was throws, and if its exactly the one expected.
///
/// - Parameters:
///   - expression: Expression
///   - error: Expected error conforming to Equatable, Error
///   - message: Optional message
///   - file: File (optional)
///   - line: Line (optional)
public func XCTAssertThrowsError<T, E>(_ expression: @autoclosure () throws -> T, error: E, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) where E: Error, E: Equatable {
    let throwMessage = message().isEmpty ? "Expected \(error) thrown" : message()
    XCTAssertThrowsError(expression, throwMessage, file: file, line: line) { errorThrown in
        let typeMessage = message().isEmpty ? "Expected \(error), got \(String(describing: errorThrown))" : message()
        XCTAssertTrue((errorThrown as? E) == error, typeMessage, file: file, line: line)
    }
}
#endif

// MARK: - Stubbing

/// [Internal] Generic Mock library errors
///
/// - notStubed: Calling method on mock, for which return value was not yet stubbed. DO NOT USE it as stub throw value!
public enum MockError: Error {
    case notStubed
}

/// [Internal] Possible Given products. Method can either return or throw an error (in general)
///
/// - `return`: Return value
/// - `throw`: Thrown error value
public enum StubProduct {
    case `return`(Any)
    case `throw`(Error)

    /// [Internal] If self is returns, and nested value can be casted to T, returns value. Can fail (fatalError)
    ///
    /// - Returns: Value if self is return
    /// - Throws: Error if self is throw
    public func casted<T>() throws -> T {
        switch self {
        case let .throw(error): throw error
        case let .return(value): return (value as? T).orFail("Casting to \(T.self) failed")
        }
    }
}

/// [Internal] Allows to reduce Mock.generated.swif size, by moving part of implementation here.
open class StubbedMethod: WithStubbingPolicy {
    /// [Internal] Returns whether there are still products to be used as stub return values
    public var isValid: Bool { return index < products.count }
    /// [Internal] Stubbing policy. By default uses parent mock policy
    public var policy: StubbingPolicy = .default
    /// [Internal] Array of stub return values
    private var products: [StubProduct]
    /// [Internal] Index of next retutn value. Can be out of bounds.
    private var index: Int = 0

    /// [Internal] Creates new method init with given products.
    ///
    /// - Parameter products: All stub return values
    public init(_ products: [StubProduct]) {
        self.products = products
        self.index = 0
    }

    /// [Internal] Get next product, with respect to self.policy and inherited policy
    ///
    /// - Parameter policy: Inherited policy
    /// - Returns: StubProduct from products array
    public func getProduct(policy: StubbingPolicy) -> StubProduct {
        defer { index = self.policy.real(policy).updated(index, with: products.count) }
        return products[index]
    }

    /// [Internal] New instance of stubber class, used to populate products array
    ///
    /// - Parameter type: Returned value type
    /// - Returns: Stubber instance
    public func stub<T>(for type: T.Type) -> Stubber<T> {
        return Stubber(self, returning: T.self)
    }

    /// [Internal] New instance of stubber class, used to populate products array
    ///
    /// - Parameter type: Returned value type
    /// - Returns: Stubber instance
    public func stubThrows<T>(for type: T.Type) -> StubberThrows<T> {
        return StubberThrows(self, returning: T.self)
    }

    /// Appends new product to products array
    ///
    /// - Parameter product: New stub return value (or error thrown) to append
    fileprivate func append(_ product: StubProduct) {
        products.append(product)
    }
}

/// Used to populate stubbed method with sequence of events. Call it's methods, to record subsequent stub return values.
public struct Stubber<ReturnedValue> {
    /// [Internal] stubbed method
    private var method: StubbedMethod
    /// Stubbing policy. If wrap - it will iterate over recorded values. If drop - it will remove value when stub returns. If default - it will use mock settings
    public var policy: StubbingPolicy {
        get { return method.policy }
        set { method.policy = newValue }
    }

    /// [Internal] New instance of stubber class, used to populate products array
    ///
    /// - Parameters:
    ///   - method: Stubbed method
    ///   - returning: Return
    public init(_ method: StubbedMethod, returning: ReturnedValue.Type) {
        self.method = method
    }

    /// Record return value
    ///
    /// - Parameter value: return value
    public func `return`(_ value: ReturnedValue) {
        method.append(.return(value))
    }

    /// Record subsequent return values, in given order (comma separated)
    ///
    /// - Parameter values: return values
    public func `return`(_ values: ReturnedValue...) {
        values.forEach(self.return)
    }
}

/// Used to populate stubbed method with sequence of events. Call it's methods, to record subsequent stub return/throw values.
public struct StubberThrows<ReturnedValue> {
    /// [Internal] stubbed method
    private var method: StubbedMethod
    /// Stubbing policy. If wrap - it will iterate over recorded values. If drop - it will remove value when stub returns. If default - it will use mock settings
    public var policy: StubbingPolicy {
        get { return method.policy }
        set { method.policy = newValue }
    }

    /// [Internal] New instance of stubber class, used to populate products array
    ///
    /// - Parameters:
    ///   - method: Stubbed method
    ///   - returning: Return
    public init(_ method: StubbedMethod, returning: ReturnedValue.Type) {
        self.method = method
    }

    /// Record return value
    ///
    /// - Parameter value: return value
    public func `return`(_ value: ReturnedValue) {
        method.append(.return(value))
    }

    /// Record subsequent return values, in given order (comma separated)
    ///
    /// - Parameter values: return values
    public func `return`(_ values: ReturnedValue...) {
        values.forEach(self.return)
    }

    /// Record thrown error
    ///
    /// - Parameter error: Error to throw
    public func `throw`(_ error: Error) {
        method.append(.throw(error))
    }

    /// Record subsequent thrown errors, in given order (comma separated)
    ///
    /// - Parameter errors: Errors to throw
    public func `throw`(_ errors: Error...) {
        errors.forEach(self.throw)
    }
}

// MARK: - Stubbing Policy
/// Given Policy for treating sequence of events (products). Used to determine if stub return values should be consumed
/// once (.drop), or reused (.wrap). Applies to sequence as well - .drop means remove from stack after using, while
/// .wrap iterates over sequence indefinitely.
///
/// - `default`: Use current policy specified for Mock method type
/// - `wrap`: Default policy in general. When reaching end of sequence of events, index will rewind to beginning (looping)
/// - `drop`: With this policy, every call drops event. When events count reaches zero, given is removed from mock.
public enum StubbingPolicy {
    case `default`  // use mock default policy for method type
    case wrap       // default
    case drop

    /// [Internal] Resolves used policy. If self is default, will use inherited, otherwise self
    ///
    /// - Parameter inherited: Inherited (usually global default) policy
    /// - Returns: Policy used. Always .wrap or .drop
    public func real(_ inherited: StubbingPolicy) -> StubbingPolicy {
        switch (self, inherited) {
        case (.default, .default): return .wrap // Special case, wrap is always default in general
        case (.default, _): return inherited    // Use inherited for real policy if self is default
        default: return self                    // If policy specified, use it instead of inherited
        }
    }

    /// [Internal] Computes new index for stubs array. For wrap will rewind if out of bounds, for drop will not.
    /// Default is handled as wrap.
    ///
    /// - Parameters:
    ///   - index: Index of current element
    ///   - count: Number of elements
    /// - Returns: New index
    public func updated(_ index: Int, with count: Int) -> Int {
        switch self {
        case .default, .wrap: return (index + 1) % count
        case .drop: return index + 1
        }
    }
}

/// [Internal] used for marking that stubs have configurable policy
public protocol WithStubbingPolicy: class {
    /// Stubbing policy
    var policy: StubbingPolicy { get set }
    /// [Internal] with new policy
    ///
    /// - Parameter policy: New policy
    /// - Returns: Self with new policy
    func with(_ policy: StubbingPolicy) -> Self
}

public extension WithStubbingPolicy {
    /// [Internal] with new policy
    ///
    /// - Parameter policy: New policy
    /// - Returns: Self with new policy
    func with(_ policy: StubbingPolicy) -> Self {
        self.policy = policy
        return self
    }
}

// MARK: - Sequencing policy
/// Sequencing policy - in which order Given would be resolved. Pleas ehve in mind that this policy is applied ONLY after
/// first ordering (based on how explicit is stub) is done.
///
/// - `lastWrittenResolvedFirst`: Default policy. Last given overrides previous, if they are both with same generocity level
/// - `inWritingOrder`: Givens would be recalled in order of generocity, respecting writing order (first line resolved first)
public enum SequencingPolicy {
    case lastWrittenResolvedFirst
    case inWritingOrder

    /// [Internal] Sorts stub return values / errors throw with respect to ordering rule and policy
    ///
    /// - Parameters:
    ///   - array: Array to sort
    ///   - order: Default ordering closure
    /// - Returns: Sorted with respoect to ordering and policy
    public func sorted<T>(_ array: [T], by order: (T, T) -> Bool) -> [T] {
        switch self {
        case .lastWrittenResolvedFirst: return array.reversed().sorted(by: order)
        case .inWritingOrder: return array.sorted(by: order)
        }
    }
}

/// Has sequencing policy for stubbing methods
public protocol WithSequencingPolicy {
    /// Used sequencibg policy
    var sequencingPolicy: SequencingPolicy { get set }
}

/// Has sequencing policy for stubbing static methods
public protocol WithStaticSequencingPolicy {
    /// Used sequencibg policy
    static var sequencingPolicy: SequencingPolicy { get set }
}

// MARK: - Mock

/// Every generated mock implementation adopts **Mock** protocol.
/// It defines base Mock structure and features.
public protocol Mock: class {
    /// Stubbed method and property type
    associatedtype Given
    /// Verification type
    associatedtype Verify
    /// Perform type
    associatedtype Perform

    /// Registers return value for stubbed method, for specified attributes set.
    ///
    /// When this method will be called on mock, it will check for first matching given, with following rules:
    /// 1. First check most specific givens (with explicit parameters - .value), then for wildcard parameters (.any)
    /// 2. More recent givens have higher priority than older ones
    /// 3. When two given's have same level of explicity, like:
    ///     ```
    ///     Given(mock, .do(with: .value(1), and: .any)
    ///     Given(mock, .do(with: .any, and: .value(1))
    ///     ```
    ///     Method stub will return most recent one.
    ///
    ///
    /// - Parameter method: signature, with attributes (any or explicit value). Type `.` for all available
    func given(_ method: Given)

    /// Registers perform closure, which will be executed upon calling stubbed method, for specified attribtes.
    ///
    /// When this method will be called on mock, it
    /// will check for first matching closure and execute it with parameters passed. Have in mind following rules:
    /// 1. First check most specific performs (with explicit parameters - .value), then for wildcard parameters (.any)
    /// 2. More recent performs have higher priority than older ones
    /// 3. When two performs have same level of explicity, like:
    ///     ```
    ///     Perform(mock, .do(with: .value(1), and: .any, perform: { ... }))
    ///     Perform(mock, .do(with: .any, and: .value(1), perform: { ... }))
    ///     ```
    ///     Method stub will return most recent one.
    ///
    /// - Parameter method: signature, with attributes (any or explicit value). Type `.` for all available
    func perform(_ method: Perform)

    /// Verifies, that given method stub was called exact number of times.
    ///
    /// - Parameters:
    ///   - method: Method signature with wrapped parameters (Parameter<ValueType>)
    ///   - count: Number of invocations
    ///   - file: for XCTest print purposes
    ///   - line: for XCTest print purposes
    func verify(_ method: Verify, count: Count, file: StaticString, line: UInt)
}

/// Every mock, that stubs static methods, should adopt **StaticMock** protocol.
/// It defines base StaticMock structure and features.
public protocol StaticMock: class {
    /// Stubbed method and property type
    associatedtype StaticGiven
    /// Verification type
    associatedtype StaticVerify
    /// Perform type
    associatedtype StaticPerform

    /// As verifying static members relies on static count of invocations, clear allows to 'reset' static mock internals.
    static func clear()

    /// Registers return value for stubbed method, for specified attributes set.
    ///
    /// When this method will be called on mock, it will check for first matching given, with following rules:
    /// 1. First check most specific givens (with explicit parameters - .value), then for wildcard parameters (.any)
    /// 2. More recent givens have higher priority than older ones
    /// 3. When two given's have same level of explicity, like:
    ///     ```
    ///     Given(mock, .do(with: .value(1), and: .any)
    ///     Given(mock, .do(with: .any, and: .value(1))
    ///     ```
    ///     Method stub will return most recent one.
    ///
    ///
    /// - Parameter method: signature, with attributes (any or explicit value). Type `.` for all available
    static func given(_ method: StaticGiven)

    /// Registers perform closure, which will be executed upon calling stubbed method, for specified attribtes.
    ///
    /// When this method will be called on mock, it
    /// will check for first matching closure and execute it with parameters passed. Have in mind following rules:
    /// 1. First check most specific performs (with explicit parameters - .value), then for wildcard parameters (.any)
    /// 2. More recent performs have higher priority than older ones
    /// 3. When two performs have same level of explicity, like:
    ///     ```
    ///     Perform(mock, .do(with: .value(1), and: .any, perform: { ... }))
    ///     Perform(mock, .do(with: .any, and: .value(1), perform: { ... }))
    ///     ```
    ///     Method stub will return most recent one.
    ///
    /// - Parameter method: signature, with attributes (any or explicit value). Type `.` for all available
    static func perform(_ method: StaticPerform)

    /// Verifies, that given method stub was called exact number of times.
    ///
    /// - Parameters:
    ///   - method: Method signature with wrapped parameters (Parameter<ValueType>)
    ///   - count: Number of invocations
    ///   - file: for XCTest print purposes
    ///   - line: for XCTest print purposes
    static func verify(_ method: StaticVerify, count: Count, file: StaticString, line: UInt)
}

// MARK: - Assertions and Mocking

// MARK: - At least once instance member called

/// Verify that given method was called on mock object **at least once**.
///
/// - Parameters:
///   - object: Mock instance
///   - method: Method signature with wrapped parameters (`Parameter`)
///   - file: for XCTest print purposes
///   - line: for XCTest print purposes
public func Verify<T: Mock>(_ object: T, _ method: T.Verify, file: StaticString = #file, line: UInt = #line) {
    object.verify(method, count: .moreOrEqual(to: 1), file: file, line: line)
}

/// Verify that given property getter or setter was called on mock object **at least once**.
///
/// - Parameters:
///   - object: Mock instance
///   - property: Property name, get or set with wrapped newValue (`Parameter`)
///   - file: for XCTest print purposes
///   - line: for XCTest print purposes
@available(*, deprecated, message: "Use Verify instead!")
public func VerifyProperty<T: Mock>(_ object: T, _ property: T.Verify, file: StaticString = #file, line: UInt = #line) {
    object.verify(property, count: .moreOrEqual(to: 1), file: file, line: line)
}

// MARK: - At least once static member called

/// Verify that given static method was called on mock type **at least once**.
///
/// - Parameters:
///   - object: Mock type
///   - method: Method signature with wrapped parameters (`Parameter`)
///   - file: for XCTest print purposes
///   - line: for XCTest print purposes
public func Verify<T: StaticMock>(_ type: T.Type, _ method: T.StaticVerify, file: StaticString = #file, line: UInt = #line) {
    T.verify(method, count: .moreOrEqual(to: 1), file: file, line: line)
}

/// Verify that given static property getter or setter was called on mock object **at least once**.
///
/// - Parameters:
///   - object: Mock type
///   - property: Property name, get or set with wrapped newValue (`Parameter`)
///   - file: for XCTest print purposes
///   - line: for XCTest print purposes
@available(*, deprecated, message: "Use Verify instead!")
public func VerifyProperty<T: StaticMock>(_ object: T.Type, _ property: T.StaticVerify, file: StaticString = #file, line: UInt = #line) {
    T.verify(property, count: .moreOrEqual(to: 1), file: file, line: line)
}

// MARK: - Instance member called with explicit count

/// Verify that given method was called on mock object **exact number of times**.
///
/// - Parameters:
///   - object: Mock instance
///   - count: Number of invocations
///   - method: Method signature with wrapped parameters (`Parameter`)
///   - file: for XCTest print purposes
///   - line: for XCTest print purposes
public func Verify<T: Mock>(_ object: T, _ count: Count, _ method: T.Verify, file: StaticString = #file, line: UInt = #line) {
    object.verify(method, count: count, file: file, line: line)
}

/// Verify that given property get / set was called on mock object **exact number of times**.
///
/// - Parameters:
///   - object: Mock instance
///   - count: Number of invocations
///   - method: Property name, get or set with wrapped newValue (`Parameter`)
///   - file: for XCTest print purposes
///   - line: for XCTest print purposes
@available(*, deprecated, message: "Use Verify instead!")
public func VerifyProperty<T: Mock>(_ object: T, _ count: Count, _ property: T.Verify, file: StaticString = #file, line: UInt = #line) {
    object.verify(property, count: count, file: file, line: line)
}

// MARK: - Static member called with explicit count

/// Verify that given static method was called on mock type **exact number of times**.
///
/// - Parameters:
///   - object: Mock type
///   - count: Number of invocations
///   - method: Static method signature with wrapped parameters (`Parameter`)
///   - file: for XCTest print purposes
///   - line: for XCTest print purposes
public func Verify<T: StaticMock>(_ type: T.Type, _ count: Count, _ method: T.StaticVerify, file: StaticString = #file, line: UInt = #line) {
    T.verify(method, count: count, file: file, line: line)
}

/// Verify that given static property get / set was called on mock type **exact number of times**.
///
/// - Parameters:
///   - object: Mock type
///   - count: Number of invocations
///   - method: Static property name, get or set with wrapped newValue (`Parameter`)
///   - file: for XCTest print purposes
///   - line: for XCTest print purposes
@available(*, deprecated, message: "Use Verify instead!")
public func VerifyProperty<T: StaticMock>(_ type: T.Type, _ count: Count, _ property: T.StaticVerify, file: StaticString = #file, line: UInt = #line) {
    T.verify(property, count: count, file: file, line: line)
}

// MARK: - Given

/// Setup return value for method stubs in mock instance. When this method will be called on mock, it
/// will check for first matching given, with following rules:
/// 1. First check most specific givens (with explicit parameters - .value), then for wildcard parameters (.any)
/// 2. More recent givens have higher priority than older ones
/// 3. When two given's have same level of explicity, like:
///     ```
///     Given(mock, .do(with: .value(1), and: .any)
///     Given(mock, .do(with: .any, and: .value(1))
///     ```
///     Method stub will return the one depending on mock sequencingPolicy. By default it means most recent one.
///
/// - Parameters:
///   - object: Mock instance
///   - method: Method signature with wrapped parameters (Parameter<ValueType>) and return value
///   - policy: Stubbing policy - uses mock policy by default (which defaults to .wrap)
public func Given<T: Mock>(_ object: T, _ method: T.Given, _ policy: StubbingPolicy = .default) {
    object.given(policy.apply(to: method))
}

/// Setup return value for static method stubs on mock type. When this static method will be called, it
/// will check for first matching given, with following rules:
/// 1. First check most specific givens (with explicit parameters - .value), then for wildcard parameters (.any)
/// 2. More recent givens have higher priority than older ones
/// 3. When two given's have same level of explicity, like:
///     ```
///     Given(T.self, .do(with: .value(1), and: .any)
///     Given(T.self, .do(with: .any, and: .value(1))
///     ```
///     Method stub will return the one depending on mock sequencingPolicy. By default it means most recent one.
///
/// - Parameters:
///   - object: Mock type
///   - method: Static method signature with wrapped parameters (Parameter<ValueType>) and return value
///   - policy: Stubbing policy - uses mock policy by default (which defaults to .wrap)
public func Given<T: StaticMock>(_ type: T.Type, _ method: T.StaticGiven, _ policy: StubbingPolicy = .default) {
    type.given(policy.apply(to: method))
}

// MARK: - Perform

/// Setup perform closure for method stubs in mock instance. When this method will be called on mock, it
/// will check for first matching closure and execute it with parameters passed. Have in mind following rules:
/// 1. First check most specific performs (with explicit parameters - .value), then for wildcard parameters (.any)
/// 2. More recent performs have higher priority than older ones
/// 3. When two performs have same level of explicity, like:
///     ```
///     Perform(mock, .do(with: .value(1), and: .any, perform: { ... }))
///     Perform(mock, .do(with: .any, and: .value(1), perform: { ... }))
///     ```
///     Method stub will return the one depending on mock sequencingPolicy. By default it means most recent one.
///
/// - Parameters:
///   - object: Mock instance
///   - method: Method signature with wrapped parameters (Parameter<ValueType>) and perform closure
public func Perform<T: Mock>(_ object: T, _ method: T.Perform) {
    object.perform(method)
}

/// Setup perform closure for static method stubs for mock type. When this method will be called on mock type, it
/// will check for first matching closure and execute it with parameters passed. Have in mind following rules:
/// 1. First check most specific performs (with explicit parameters - .value), then for wildcard parameters (.any)
/// 2. More recent performs have higher priority than older ones
/// 3. When two performs have same level of explicity, like:
///     ```
///     Perform(T.self, .do(with: .value(1), and: .any, perform: { ... }))
///     Perform(T.self, .do(with: .any, and: .value(1), perform: { ... }))
///     ```
///     Method stub will return the one depending on mock sequencingPolicy. By default it means most recent one.
///
/// - Parameters:
///   - object: Mock type
///   - method: Static method signature with wrapped parameters (Parameter<ValueType>) and perform closure
public func Perform<T: StaticMock>(_ object: T.Type, _ method: T.StaticPerform) {
    T.perform(method)
}

// MARK: - Helpers

/// [Internal] Fails flow with given message
///
/// - Parameter message: Failure message
/// - Returns: Never
public func Failure(_ message: String) -> Swift.Never {
    let errorMessage = "[FATAL] \(message)!"
    FatalErrorUtil.fatalError(errorMessage)
}

/// [Internal] Used for handling fatal errors inside library.
public struct FatalErrorUtil {
    /// [Internal] Handler
    private static var handler: (String) -> Never = {
        print($0)
        exit(0)
    }
    /// [Internal] Default handler
    private static var defalutHandler: (String) -> Never = {
        print($0)
        exit(0)
    }

    /// [Internal] Override handling error handler
    ///
    /// - Parameter new: New handler
    public static func set(_ new: @escaping (String) -> Never) {
        handler = new
    }

    /// [Internal] Restores default handler
    public static func restore() {
        handler = defalutHandler
    }

    /// [Internal] Perform fatal error handler
    ///
    /// - Parameter message: Message
    public static func fatalError(_ message: String) -> Never {
        handler(message)
    }
}

public extension Optional {
    /// Returns unwrapped value, or fails.
    ///
    /// - Parameter message: Failure message
    /// - Returns: Unwrapped value
    func orFail(_ message: String = "unwrapping nil") -> Wrapped {
        return self ?? { Failure(message) }()
    }
}

private extension StubbingPolicy {
    /// [Internal] Apply stubbing policy
    ///
    /// - Parameter method: Method
    /// - Returns: With new policy
    func apply<T>(to method: T) -> T {
        return ((method as? WithStubbingPolicy)?.with(self) as? T) ?? method
    }
}

// MARK: - Parameter

/// Parameter wraps method attribute, allowing to make a difference between explicit value,
/// expressed by `.value` case and wildcard value, expressed by `.any` case.
///
/// Whole idea is to be able to test and specify behaviours, in both generic and explicit way
/// (and any mix of these two). Every test method matches mock methods in signature, but changes attributes types
/// to Parameter.
///
/// That allows pattern like matching between two Parameter values:
/// - **.any** is equal to every other parameter. (**!!!** actual case name is `._`, but it is advised to use `.any`)
/// - **.value(p1)** is equal to **.value(p2)** only, when p1 == p2
///
/// **Important!** Comparing parameters, where ValueType is not Equatable will result in fatalError,
/// unless you register comparator for its *ValueType* in **Matcher** instance used (typically Matcher.default)
///
/// - any: represents and matches any parameter value
/// - value: represents explicit parameter value
public enum Parameter<ValueType> {
    /// Wildcard - any value
    case `_`
    /// Explicit value
    case value(ValueType)
    /// Any value matching
    case matching((ValueType) -> Bool)

    /// Represents and matches any parameter value - syntactic sugar for `._` case.
    public static var any: Parameter<ValueType> { return Parameter<ValueType>._ }

    /// Represents and matches any parameter value - syntactic sugar for `._` case. Used, when needs to explicitely specify
    /// wrapped *ValueType* type, to resolve ambiguity between methods with same signatures, but different attribute types.
    ///
    /// - Parameter type: Explicitly specify ValueType type
    /// - Returns: any parameter
    public static func any<T>(_ type: T.Type) -> Parameter<T> {
        return Parameter<T>._
    }
}

// MARK: - Optionality checks
public protocol OptionalType: ExpressibleByNilLiteral {
    var isNotNil: Bool { get }
}

extension Optional: OptionalType {
    public var isNotNil: Bool {
        switch self {
        case .some: return true
        case .none: return false
        }
    }
}

public extension Parameter where ValueType: OptionalType {
    static var notNil: Parameter<ValueType> {
        return Parameter.matching { $0.isNotNil }
    }
}

// MARK: - Order
public extension Parameter where ValueType: GenericAttributeType {
    /// Used for invocations sorting purpose.
    var intValue: Int {
        switch self {
        case ._: return 0
        case let .value(generic): return generic.intValue
        case .matching: return 1
        }
    }
}

public extension Parameter {
    /// Used for invocations sorting purpose.
    var intValue: Int {
        switch self {
        case ._: return 0
        case .value: return 1
        case .matching: return 1
        }
    }
}

//// MARK: - Equality
public extension Parameter {
    /// Returns whether given two parameters are matching each other, with following rules:
    ///
    /// 1. if parameter is .any - it is equal to any other parameter
    /// 2. if both are .value - then compare wrapped ValueType instances.
    /// 3. if they are not Equatable (or not a Sequences of Equatable), use provided matcher instance
    ///
    /// - Parameters:
    ///   - lhs: First parameter
    ///   - rhs: Second parameter
    ///   - matcher: Matcher instance
    /// - Returns: true, if first is matching second
    static func compare(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>, with matcher: Matcher) -> Bool {
        switch (lhs, rhs) {
        case (._, _): return true
        case (_, ._): return true
        case (.matching(let match), .value(let value)): return match(value)
        case (.value(let value), .matching(let match)): return match(value)
        case (.value(let lhsValue), .value(let rhsValue)):
            guard let compare = matcher.comparator(for: ValueType.self) else {
                print("[FATAL] No registered matcher comparator for \(String(describing: ValueType.self))")
                Failure("No registered comparators for \(String(describing: ValueType.self))")
            }
            return compare(lhsValue,rhsValue)
        default: return false
        }
    }

    /// [Internal] Wraps as generic Parameter instance. Should not be ever called directly.
    ///
    /// - Returns: Wrapped parameter
    func wrapAsGeneric() -> Parameter<GenericAttribute> {
        switch self {
        case ._:
            let attribute = GenericAttribute(Mirror(reflecting: ValueType.self), intValue, { (l, r, m) -> Bool in
                guard let lv = l as? Mirror else { return false }
                if let rv = r as? Mirror {
                    return lv.subjectType == rv.subjectType
                } else if let _ = r as? ValueType {
                    return true // .any comparing .value or .matching
                } else {
                    return false
                }
            })
            return Parameter<GenericAttribute>.value(attribute)
        case let .value(value):
            let attribute = GenericAttribute(value, intValue, { (l, r, m) -> Bool in
                guard let lv = l as? ValueType  else { return false }
                if let rv = r as? ValueType {
                    let lhs = Parameter<ValueType>.value(lv)
                    let rhs = Parameter<ValueType>.value(rv)
                    return Parameter<ValueType>.compare(lhs: lhs, rhs: rhs, with: m)
                } else if let rv = r as? ((ValueType) -> Bool) {
                    return rv(lv)
                } else if let rv = r as? Mirror {
                    return Mirror(reflecting: ValueType.self).subjectType == rv.subjectType
                } else {
                    return false
                }
            })
            return Parameter<GenericAttribute>.value(attribute)
        case let .matching(match):
            let attribute = GenericAttribute(match, intValue, { (l, r, m) -> Bool in
                guard let lv = l as? ((ValueType) -> Bool)  else { return false }
                if let rv = r as? ValueType {
                    let lhs = Parameter<ValueType>.matching(lv)
                    let rhs = Parameter<ValueType>.value(rv)
                    return Parameter<ValueType>.compare(lhs: lhs, rhs: rhs, with: m)
                } else if let rv = r as? Mirror {
                    return Mirror(reflecting: ValueType.self).subjectType == rv.subjectType
                } else {
                    return false
                }
            })
            return Parameter<GenericAttribute>.value(attribute)
        }
    }
}

public extension Parameter where ValueType: GenericAttributeType {
    /// [Internal] Compare two parameters
    ///
    /// - Parameters:
    ///   - lhs: one
    ///   - rhs: other
    ///   - matcher: Matcher instance used for comparison
    /// - Returns: true if they are matching, false otherwise
    static func compare(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>, with matcher: Matcher) -> Bool {
        switch (lhs, rhs) {
        case (._, _): return true
        case (_, ._): return true
        case (.value(let lhsGeneric), .value(let rhsGeneric)): return lhsGeneric.compare(lhsGeneric.value,rhsGeneric.value,matcher)
        default: return false
        }
    }
}

public extension Parameter where ValueType: Sequence, ValueType: Equatable {
    /// [Internal] Compare two parameters
    ///
    /// - Parameters:
    ///   - lhs: one
    ///   - rhs: other
    ///   - matcher: Matcher instance used for comparison
    /// - Returns: true if they are matching, false otherwise
    static func compare(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>, with matcher: Matcher) -> Bool {
        switch (lhs, rhs) {
        case (._, _): return true
        case (_, ._): return true
        case (.matching(let match), .value(let value)): return match(value)
        case (.value(let value), .matching(let match)): return match(value)
        case let (.value(left), .value(right)): return left == right
        default: return false
        }
    }
}

public extension Parameter where ValueType: Sequence, ValueType.Element: Equatable {
    /// [Internal] Compare two parameters
    ///
    /// - Parameters:
    ///   - lhs: one
    ///   - rhs: other
    ///   - matcher: Matcher instance used for comparison
    /// - Returns: true if they are matching, false otherwise
    static func compare(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>, with matcher: Matcher) -> Bool {
        switch (lhs, rhs) {
        case (._, _): return true
        case (_, ._): return true
        case (.matching(let match), .value(let value)): return match(value)
        case (.value(let value), .matching(let match)): return match(value)
        case (.value(let lhsSequence), .value(let rhsSequence)):
            let leftArray = lhsSequence.map { $0 }
            let rightArray = rhsSequence.map { $0 }

            guard leftArray.count == rightArray.count else { return false }

            let values = (0..<leftArray.count)
            .map { i -> (ValueType.Element, ValueType.Element) in
                return ((leftArray[i]),(rightArray[i]))
            }

            for (left,right) in values {
                guard left == right else { return false }
            }

            return true
        default: return false
        }
    }
}

public extension Parameter where ValueType: Sequence, ValueType.Element: Equatable, ValueType: Equatable {
    /// [Internal] Compare two parameters
    ///
    /// - Parameters:
    ///   - lhs: one
    ///   - rhs: other
    ///   - matcher: Matcher instance used for comparison
    /// - Returns: true if they are matching, false otherwise
    static func compare(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>, with matcher: Matcher) -> Bool {
        switch (lhs, rhs) {
        case (._, _): return true
        case (_, ._): return true
        case (.matching(let match), .value(let value)): return match(value)
        case (.value(let value), .matching(let match)): return match(value)
        case let (.value(left), .value(right)): return left == right
        default: return false
        }
    }
}

public extension Parameter where ValueType: Sequence {
    /// Element
    typealias Element = ValueType.Element
    /// [Internal] Compare two parameters
    ///
    /// - Parameters:
    ///   - lhs: one
    ///   - rhs: other
    ///   - matcher: Matcher instance used for comparison
    /// - Returns: true if they are matching, false otherwise
    static func compare(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>, with matcher: Matcher) -> Bool {
        switch (lhs, rhs) {
        case (._, _): return true
        case (_, ._): return true
        case (.matching(let match), .value(let value)): return match(value)
        case (.value(let value), .matching(let match)): return match(value)
        case (.value(let lhsSequence), .value(let rhsSequence)):
            let leftArray = lhsSequence.map { $0 }
            let rightArray = rhsSequence.map { $0 }

            guard leftArray.count == rightArray.count else { return false }

            let values = (0..<leftArray.count)
                .map { i -> (Element, Element) in
                    return ((leftArray[i]),(rightArray[i]))
            }

            guard let comparator = matcher.comparator(for: Element.self) else {
                print("[FATAL] No registered matcher comparator for \(Element.self)")
                Failure("Not registered comparator for \(Element.self)")
            }

            for (left,right) in values {
                guard comparator(left, right) else {
                    return false
                }
            }

            return true
        default: return false
        }
    }

    /// [Internal] Wraps as generic Parameter instance. Should not be ever called directly.
    ///
    /// - Returns: Wrapped parameter
    func wrapAsGeneric() -> Parameter<GenericAttribute> {
        switch self {
        case ._:
            let attribute = GenericAttribute(Mirror(reflecting: ValueType.self), intValue, { (l, r, m) -> Bool in
                guard let lv = l as? Mirror else { return false }
                if let rv = r as? Mirror {
                    return lv.subjectType == rv.subjectType
                } else if let _ = r as? ValueType {
                    return true // .any comparing .value
                } else {
                    return false
                }
            })
            return Parameter<GenericAttribute>.value(attribute)
        case let .value(value):
            let attribute = GenericAttribute(value, intValue, { (l, r, m) -> Bool in
                guard let lv = l as? ValueType  else { return false }
                if let rv = r as? ValueType {
                    let lhs = Parameter<ValueType>.value(lv)
                    let rhs = Parameter<ValueType>.value(rv)
                    return Parameter<ValueType>.compare(lhs: lhs, rhs: rhs, with: m)
                } else if let rv = r as? ((ValueType) -> Bool) {
                    return rv(lv)
                } else if let rv = r as? Mirror {
                    return Mirror(reflecting: ValueType.self).subjectType == rv.subjectType
                } else {
                    return false
                }
            })
            return Parameter<GenericAttribute>.value(attribute)
        case let .matching(match):
            let attribute = GenericAttribute(match, intValue, { (l, r, m) -> Bool in
                guard let lv = l as? ((ValueType) -> Bool)  else { return false }
                if let rv = r as? ValueType {
                    let lhs = Parameter<ValueType>.matching(lv)
                    let rhs = Parameter<ValueType>.value(rv)
                    return Parameter<ValueType>.compare(lhs: lhs, rhs: rhs, with: m)
                } else if let rv = r as? Mirror {
                    return Mirror(reflecting: ValueType.self).subjectType == rv.subjectType
                } else {
                    return false
                }
            })
            return Parameter<GenericAttribute>.value(attribute)
        }
    }
}

public extension Parameter where ValueType: Equatable {
    /// [Internal] Compare two parameters
    ///
    /// - Parameters:
    ///   - lhs: one
    ///   - rhs: other
    ///   - matcher: Matcher instance used for comparison
    /// - Returns: true if they are matching, false otherwise
    static func compare(lhs: Parameter<ValueType>, rhs: Parameter<ValueType>, with matcher: Matcher) -> Bool {
        switch (lhs, rhs) {
        case (._, _): return true
        case (_, ._): return true
        case (.matching(let match), .value(let value)): return match(value)
        case (.value(let value), .matching(let match)): return match(value)
        case let (.value(left), .value(right)): return left == right
        default: return false
        }
    }
}

// MARK: - Parameter + Literals

// MARK: - ExpressibleByStringLiteral
extension Optional: ExpressibleByStringLiteral, ExpressibleByExtendedGraphemeClusterLiteral, ExpressibleByUnicodeScalarLiteral where Wrapped: ExpressibleByStringLiteral {
    public typealias StringLiteralType = Wrapped.StringLiteralType
    public typealias ExtendedGraphemeClusterLiteralType = Wrapped.ExtendedGraphemeClusterLiteralType
    public typealias UnicodeScalarLiteralType = Wrapped.UnicodeScalarLiteralType

    public init(stringLiteral value: StringLiteralType) {
        self = .some(Wrapped.init(stringLiteral: value))
    }

    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self = .some(Wrapped.init(extendedGraphemeClusterLiteral: value))
    }

    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self = .some(Wrapped.init(unicodeScalarLiteral: value))
    }
}

extension Parameter: ExpressibleByStringLiteral, ExpressibleByExtendedGraphemeClusterLiteral, ExpressibleByUnicodeScalarLiteral where ValueType: ExpressibleByStringLiteral {
    public typealias StringLiteralType = ValueType.StringLiteralType
    public typealias ExtendedGraphemeClusterLiteralType = ValueType.ExtendedGraphemeClusterLiteralType
    public typealias UnicodeScalarLiteralType = ValueType.UnicodeScalarLiteralType

    public init(stringLiteral value: StringLiteralType) {
        self = .value(ValueType.init(stringLiteral: value))
    }

    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self = .value(ValueType.init(extendedGraphemeClusterLiteral: value))
    }

    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self = .value(ValueType.init(unicodeScalarLiteral: value))
    }
}

// MARK: - ExpressibleByNilLiteral
extension Parameter: ExpressibleByNilLiteral where ValueType: ExpressibleByNilLiteral {
    public init(nilLiteral: ()) {
        self = .value(nil)
    }
}

// MARK: - ExpressibleByIntegerLiteral
extension Optional: ExpressibleByIntegerLiteral where Wrapped: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = Wrapped.IntegerLiteralType

    public init(integerLiteral value: IntegerLiteralType) {
        self = .some(Wrapped.init(integerLiteral: value))
    }
}

extension Parameter: ExpressibleByIntegerLiteral where ValueType: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = ValueType.IntegerLiteralType

    public init(integerLiteral value: ValueType.IntegerLiteralType) {
        self = .value(ValueType.init(integerLiteral: value))
    }
}

// MARK: - ExpressibleByBooleanLiteral
extension Optional: ExpressibleByBooleanLiteral where Wrapped: ExpressibleByBooleanLiteral {
    public typealias BooleanLiteralType = Wrapped.BooleanLiteralType

    public init(booleanLiteral value: BooleanLiteralType) {
        self = .some(Wrapped.init(booleanLiteral: value))
    }
}

extension Parameter: ExpressibleByBooleanLiteral where ValueType: ExpressibleByBooleanLiteral {
    public typealias BooleanLiteralType = ValueType.BooleanLiteralType

    public init(booleanLiteral value: BooleanLiteralType) {
        self = .value(ValueType.init(booleanLiteral: value))
    }
}

// MARK: - ExpressibleByFloatLiteral
extension Optional: ExpressibleByFloatLiteral where Wrapped: ExpressibleByFloatLiteral {
    public typealias FloatLiteralType = Wrapped.FloatLiteralType

    public init(floatLiteral value: FloatLiteralType) {
        self = .some(Wrapped.init(floatLiteral: value))
    }
}

extension Parameter: ExpressibleByFloatLiteral where ValueType: ExpressibleByFloatLiteral {
    public typealias FloatLiteralType = ValueType.FloatLiteralType

    public init(floatLiteral value: FloatLiteralType) {
        self = .value(ValueType.init(floatLiteral: value))
    }
}

// MARK: - ExpressibleByArrayLiteral
private extension ExpressibleByArrayLiteral {
    init(_ elements: [ArrayLiteralElement]) {
        self = elements as! Self  // TODO: Check if can be fixed. For some reason could not use init(arayLiteral elements: ...)
    }
}

extension Optional: ExpressibleByArrayLiteral where Wrapped: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = Wrapped.ArrayLiteralElement

    public init(arrayLiteral elements: ArrayLiteralElement...) {
        self = .some(Wrapped.init(elements))
    }
}

extension Parameter: ExpressibleByArrayLiteral where ValueType: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = ValueType.ArrayLiteralElement

    public init(arrayLiteral elements: ArrayLiteralElement...) {
        self = .value(ValueType.init(elements))
    }
}

// MARK: - ExpressibleByDictionaryLiteral
private extension ExpressibleByDictionaryLiteral where Key: Hashable {
    init(_ elements: [(Key, Value)]) {
        let value: [Key: Value] = Dictionary.init(uniqueKeysWithValues: elements)
        self = value as! Self  // TODO: Check if can be fixed. For some reason could not use init(arayLiteral elements: ...)
    }
}

extension Optional: ExpressibleByDictionaryLiteral where Wrapped: ExpressibleByDictionaryLiteral, Wrapped.Key: Hashable {
    public typealias Key = Wrapped.Key
    public typealias Value = Wrapped.Value

    public init(dictionaryLiteral elements: (Key, Value)...) {
        self = .some(Wrapped.init(elements))
    }
}

extension Parameter: ExpressibleByDictionaryLiteral where ValueType: ExpressibleByDictionaryLiteral, ValueType.Key: Hashable {
    public typealias Key = ValueType.Key
    public typealias Value = ValueType.Value

    public init(dictionaryLiteral elements: (Key, Value)...) {
        self = .value(ValueType.init(elements))
    }
}

// MARK: - Matcher

/// Matcher is container class, responsible for storing and resolving comparators for given types.
public class Matcher {
    /// Shared **Matcher** instance
    public static var `default` = Matcher()
    /// [Internal] Matchers storage
    private var matchers: [(Mirror,Any)] = []

    /// Create new clean matcher instance.
    public init() {
        registerBasicTypes()
        register(GenericAttribute.self) { [unowned self] (a, b) -> Bool in
            return a.compare(a.value,b.value,self)
        }
    }

    /// Creante new matcher instance, copying existing comparator from another instance.
    ///
    /// - Parameter matcher: other matcher instance
    public init(matcher: Matcher) {
        self.matchers = matcher.matchers
    }

    /// Registers array comparators for all basic types, their optional versions
    /// and arrays containing elements of that type. For all of them, no manual
    /// registering of comparator is needed.
    ///
    /// We defined basic types as:
    ///
    /// - Bool
    /// - String
    /// - Float
    /// - Double
    /// - Character
    /// - Int
    /// - Int8
    /// - Int16
    /// - Int32
    /// - Int64
    /// - UInt
    /// - UInt8
    /// - UInt16
    /// - UInt32
    /// - UInt64
    ///
    /// Called automatically in every Matcher init.
    ///
    internal func registerBasicTypes() {
#if swift(>=4.1)
        register([Bool].self)
        register([String].self)
        register([Float].self)
        register([Double].self)
        register([Character].self)
        register([Int].self)
        register([Int8].self)
        register([Int16].self)
        register([Int32].self)
        register([Int64].self)
        register([UInt].self)
        register([UInt8].self)
        register([UInt16].self)
        register([UInt32].self)
        register([UInt64].self)
        register([Data].self)
        register([Bool?].self)
        register([String?].self)
        register([Float?].self)
        register([Double?].self)
        register([Character?].self)
        register([Int?].self)
        register([Int8?].self)
        register([Int16?].self)
        register([Int32?].self)
        register([Int64?].self)
        register([UInt?].self)
        register([UInt8?].self)
        register([UInt16?].self)
        register([UInt32?].self)
        register([UInt64?].self)
        register([Data?].self)

        // Types
        register(Bool.self)
        register(String.self)
        register(Float.self)
        register(Double.self)
        register(Character.self)
        register(Int.self)
        register(Int8.self)
        register(Int16.self)
        register(Int32.self)
        register(Int64.self)
        register(UInt.self)
        register(UInt8.self)
        register(UInt16.self)
        register(UInt32.self)
        register(UInt64.self)
        register(Data.self)
        register(Bool?.self)
        register(String?.self)
        register(Float?.self)
        register(Double?.self)
        register(Character?.self)
        register(Int?.self)
        register(Int8?.self)
        register(Int16?.self)
        register(Int32?.self)
        register(Int64?.self)
        register(UInt?.self)
        register(UInt8?.self)
        register(UInt16?.self)
        register(UInt32?.self)
        register(UInt64?.self)
        register(Data?.self)
#else
        register([Bool].self) { (a: Bool, b: Bool) in return a == b }
        register([String].self) { (a: String, b: String) in return a == b }
        register([Float].self)  { (a: Float, b: Float) in return a == b }
        register([Double].self)  { (a: Double, b: Double) in return a == b }
        register([Character].self) { (a: Character, b: Character) in return a == b }
        register([Int].self) { (a: Int, b: Int) in return a == b }
        register([Int8].self) { (a: Int8, b: Int8) in return a == b }
        register([Int16].self) { (a: Int16, b: Int16) in return a == b }
        register([Int32].self)  { (a: Int32, b: Int32) in return a == b }
        register([Int64].self) { (a: Int64, b: Int64) in return a == b }
        register([UInt].self) { (a: UInt, b: UInt) in return a == b }
        register([UInt8].self) { (a: UInt8, b: UInt8) in return a == b }
        register([UInt16].self) { (a: UInt16, b: UInt16) in return a == b }
        register([UInt32].self) { (a: UInt32, b: UInt32) in return a == b }
        register([UInt64].self) { (a: UInt64, b: UInt64) in return a == b }
        register([Data].self) { (a: Data, b: Data) in return a == b }
        register([Bool?].self) { (a: Bool?, b: Bool?) in return a == b }
        register([String?].self) { (a: String?, b: String?) in return a == b }
        register([Float?].self) { (a: Float?, b: Float?) in return a == b }
        register([Double?].self) { (a: Double?, b: Double?) in return a == b }
        register([Character?].self) { (a: Character?, b: Character?) in return a == b }
        register([Int?].self) { (a: Int?, b: Int?) in return a == b }
        register([Int8?].self) { (a: Int8?, b: Int8?) in return a == b }
        register([Int16?].self) { (a: Int16?, b: Int16?) in return a == b }
        register([Int32?].self) { (a: Int32?, b: Int32?) in return a == b }
        register([Int64?].self) { (a: Int64?, b: Int64?) in return a == b }
        register([UInt?].self) { (a: UInt?, b: UInt?) in return a == b }
        register([UInt8?].self) { (a: UInt8?, b: UInt8?) in return a == b }
        register([UInt16?].self) { (a: UInt16?, b: UInt16?) in return a == b }
        register([UInt32?].self) { (a: UInt32?, b: UInt32?) in return a == b }
        register([UInt64?].self) { (a: UInt64?, b: UInt64?) in return a == b }
        register([Data?].self) { (a: Data?, b: Data?) in return a == b }
#endif

        // Types
        register(Any.Type.self) { _, _ in return true }
        register(Bool.Type.self)
        register(String.Type.self)
        register(Float.Type.self)
        register(Double.Type.self)
        register(Character.Type.self)
        register(Int.Type.self)
        register(Int8.Type.self)
        register(Int16.Type.self)
        register(Int32.Type.self)
        register(Int64.Type.self)
        register(UInt.Type.self)
        register(UInt8.Type.self)
        register(UInt16.Type.self)
        register(UInt32.Type.self)
        register(UInt64.Type.self)
        register(Data.Type.self)
        register(Any?.Type.self) { _, _ in return true }
        register(Bool?.Type.self)
        register(String?.Type.self)
        register(Float?.Type.self)
        register(Double?.Type.self)
        register(Character?.Type.self)
        register(Int?.Type.self)
        register(Int8?.Type.self)
        register(Int16?.Type.self)
        register(Int32?.Type.self)
        register(Int64?.Type.self)
        register(UInt?.Type.self)
        register(UInt8?.Type.self)
        register(UInt16?.Type.self)
        register(UInt32?.Type.self)
        register(UInt64?.Type.self)
        register(Data?.Type.self)
    }

    /// Registers comparator for given type **T**.
    ///
    /// Comparator is a closure of `(T,T) -> Bool`.
    ///
    /// When several comparators for same type  are registered to common
    /// **Matcher** instance - it will resolve the most receont one.
    ///
    /// - Parameters:
    ///   - valueType: compared type
    ///   - match: comparator closure
    public func register<T>(_ valueType: T.Type, match: @escaping (T,T) -> Bool) {
        let mirror = Mirror(reflecting: valueType)
        matchers.append((mirror, match as Any))
    }

    /// Registers comparator for type, like comparing Int.self to Int.self. These types of comparators always returns true. Register like: `Matcher.default.register(CustomType.Type.self)`
    ///
    /// - Parameter valueType: Type.Type.self
    public func register<T>(_ valueType: T.Type.Type) {
        self.register(valueType, match: { _, _ in return true })
    }

#if swift(>=4.1)
    // Use equatable
#else
    /// Register sequence comparator, based on elements comparing.
    ///
    /// - Parameters:
    ///   - valueType: Sequence type
    ///   - match: Element comparator closure
    public func register<T,E>(_ valueType: T.Type, match: @escaping (E,E) -> Bool) where T: Sequence, E == T.Element {
        let mirror = Mirror(reflecting: E.self)
        matchers.append((mirror, match as Any))
        register(T.self) { (l: T, r: T) -> Bool in
            let lhs = l.map { $0 }
            let rhs = r.map { $0 }
            guard lhs.count == rhs.count else { return false }

            for i in 0..<lhs.count {
                guard match(lhs[i],rhs[i]) else { return false }
            }

            return true
        }
    }
#endif
    
    /// Register default comparatot for Equatable types. Required for generic mocks to work.
    ///
    /// - Parameter valueType: Equatable type
    public func register<T>(_ valueType: T.Type) where T: Equatable {
        let mirror = Mirror(reflecting: valueType)
        matchers.append((mirror, comparator(for: T.self) as Any))
    }

    /// Returns comparator closure for given type (if any).
    ///
    /// Comparator is a closure of `(T,T) -> Bool`.
    ///
    /// When several comparators for same type  are registered to common
    /// **Matcher** instance - it will resolve the most receont one.
    ///
    /// - Parameter valueType: compared type
    /// - Returns: comparator closure
    public func comparator<T>(for valueType: T.Type) -> ((T,T) -> Bool)? {
        let mirror = Mirror(reflecting: valueType)
        let comparator = matchers.reversed().first { (current, _) -> Bool in
            return current.subjectType == mirror.subjectType
        }?.1

        return comparator as? (T,T) -> Bool
    }

    /// Default Sequence comparator, compares count, and then element by element.
    ///
    /// - Parameter valueType: Sequence type
    /// - Returns: comparator closure
    public func comparator<T>(for valueType: T.Type) -> ((T,T) -> Bool)? where T: Sequence {
        let mirror = Mirror(reflecting: valueType)
        let comparator = matchers.reversed().first { (current, _) -> Bool in
            return current.subjectType == mirror.subjectType
        }?.1

        if let compare = comparator as? (T,T) -> Bool {
            return compare
        } else if let compare = self.comparator(for: T.Element.self) {
            return { (l: T, r: T) -> Bool in
                let lhs = l.map { $0 }
                let rhs = r.map { $0 }
                guard lhs.count == rhs.count else { return false }

                for i in 0..<lhs.count {
                    guard compare(lhs[i],rhs[i]) else { return false }
                }

                return true
            }
        } else {
            return nil
        }
    }

    /// Default Equatable comparator, compares if elements are equal.
    ///
    /// - Parameter valueType: Equatable type
    /// - Returns: comparator closure
    public func comparator<T>(for valueType: T.Type) -> ((T,T) -> Bool)? where T: Equatable {
        return { $0 == $1 }
    }

    /// Default Equatable Sequence comparator, compares count, and then for every element equal element.
    ///
    /// - Parameter valueType: Equatable Sequence type
    /// - Returns: comparator closure
    public func comparator<T>(for valueType: T.Type) -> ((T,T) -> Bool)? where T: Equatable, T: Sequence {
        return { $0 == $1 }
    }
}

// MARK: - Count

/// Count enum. Use it for all Verify features, when checking how many times something happened.
///
/// There are three ways of using it:
///   1. Explicit literal - you can pass 0, 1, 2 ... to verify exact number
///   2. Using predefined .custom, to specify custom matching rule.
///   3. Using one of predefined rules, for example:
///       - .atLeastOnce
///       - .exactly(1)
///       - .from(2, to: 4)
///       - .less(than: 2)
///       - .lessOrEqual(to: 1)
///       - .more(than: 2)
///       - .moreOrEqual(to: 3)
///       - .never
public enum Count: ExpressibleByIntegerLiteral {

    public typealias CustomMatchingClosure = ( _ value: Int ) -> Bool

    /// [Internal] Count is represented by integer literals, with type Int
    public typealias IntegerLiteralType = Int

    case atLeastOnce
    case once
    case custom(CustomMatchingClosure)
    case exactly(Int)
    case from(Int, to: Int)
    case less(than: Int)
    case lessOrEqual(to: Int)
    case more(than: Int)
    case moreOrEqual(to: Int)
    case never

    /// Creates new count instance, matching specific count
    ///
    /// - Parameter value: Exact count value
    public init(integerLiteral value: IntegerLiteralType) {
        self = .exactly(value)
    }
}

// MARK: - CustomStringConvertible
extension Count: CustomStringConvertible {

    public var description: String {
        switch self {
        case .atLeastOnce:
            return "at least 1"
        case .once:
            return "once"
        case .custom:
            return "custom"
        case .exactly(let value):
            return "exactly \(value)"
        case .from(let lowerBound, let upperBound):
            return "from \(lowerBound) to \(upperBound)"
        case .less(let value):
            return "less than \(value)"
        case .lessOrEqual(let value):
            return "less than or equal to \(value)"
        case .more(let value):
            return "more than \(value)"
        case .moreOrEqual(let value):
            return "more than or equal to \(value)"
        case .never:
            return "none"
        }
    }
}

// MARK: - Countable
extension Count: Countable {

    /// Returns whether given count matches countable case.
    ///
    /// - Parameter count: Given count
    /// - Returns: true, if it is within boundaries, false otherwise
    public func matches(_ count: Int) -> Bool {
        switch self {
        case .atLeastOnce:
            return count >= 1
        case .once:
            return count == 1
        case .custom(let matchingRule):
            return matchingRule(count)
        case .exactly(let value):
            return count == value
        case .from(let lowerBound, to: let upperBound):
            return count >= lowerBound && count <= upperBound
        case .less(let value):
            return count < value
        case .lessOrEqual(let value):
            return count <= value
        case .more(let value):
            return count > value
        case .moreOrEqual(let value):
            return count >= value
        case .never:
            return count == 0
        }
    }
}

// MARK: - Countable

/// Allows matching count, verifying whether given count is right or not
public protocol Countable {
    /// Returns whether given count matches countable case.
    ///
    /// - Parameter count: Given count
    /// - Returns: true, if it is within boundaries, false otherwise
    func matches(_ count: Int) -> Bool
}

extension UInt: Countable {
    /// Returns whether given count matches countable case.
    ///
    /// - Parameter count: Given count
    /// - Returns: true, if it is within boundaries, false otherwise
    public func matches(_ count: Int) -> Bool {
        return Int(self) == count
    }
}

extension Int: Countable {
    /// Returns whether given count matches countable case.
    ///
    /// - Parameter count: Given count
    /// - Returns: true, if it is within boundaries, false otherwise
    public func matches(_ count: Int) -> Bool {
        return self == count
    }
}

// MARK: - Generic Attribute

/// [Internal] Used as generic constraint for generic method stubs.
public protocol GenericAttributeType {
    /// [internal] Returned value
    var value: Any { get }
    /// [internal] Used to describe attribute generocity (0 is general, 1 is specific)
    var intValue: Int { get }
    /// [internal] Used to compare with other generic attributes values
    var compare: (Any,Any,Matcher) -> Bool { get }
}

/// [Internal] Used to wrap generic parameters, for sake of generic method stubs.
public struct GenericAttribute: GenericAttributeType {
    /// [internal]Returned value
    public let value: Any
    /// [internal] Used to describe attribute generocity (0 is general, 1 is specific)
    public var intValue: Int
    /// [internal] Used to compare with other generic attributes
    public let compare: (Any,Any,Matcher) -> Bool

    /// [internal] Creates new GenericAttribute instance, with specified return value and compare closure
    ///
    /// - Parameters:
    ///   - value: Returned value
    ///   - compare: Used to compare with other generic attributes values
    public init(_ value: Any, _ intValue: Int, _ compare: @escaping (Any,Any,Matcher) -> Bool) {
        self.value = value
        self.intValue = intValue
        self.compare = compare
    }
}
