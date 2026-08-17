import Foundation

// MARK: - At least once instance member called

/// Verify that given method was called on mock object **at least once**.
///
/// The magic literals are spelled out here rather than hidden behind a
/// `MockyLocation` default argument on purpose: a default argument expands at the call site of
/// the expression it belongs to, so `location: MockyLocation = MockyLocation()` would capture
/// this file instead of the test that called `Verify`.
///
/// - Parameters:
///   - object: Mock instance
///   - method: Method signature with wrapped parameters (`Parameter`)
public func Verify<T: Mock>(
    _ object: T,
    _ method: T.Verify,
    fileID: StaticString = #fileID,
    filePath: StaticString = #filePath,
    line: UInt = #line,
    column: UInt = #column
) {
    object.verify(
        method,
        count: .moreOrEqual(to: 1),
        at: MockyLocation(fileID: fileID, filePath: filePath, line: line, column: column)
    )
}

// MARK: - At least once static member called

/// Verify that given static method was called on mock type **at least once**.
///
/// - Parameters:
///   - object: Mock type
///   - method: Method signature with wrapped parameters (`Parameter`)
public func Verify<T: StaticMock>(
    _ type: T.Type,
    _ method: T.StaticVerify,
    fileID: StaticString = #fileID,
    filePath: StaticString = #filePath,
    line: UInt = #line,
    column: UInt = #column
) {
    T.verify(
        method,
        count: .moreOrEqual(to: 1),
        at: MockyLocation(fileID: fileID, filePath: filePath, line: line, column: column)
    )
}

// MARK: - Instance member called with explicit count

/// Verify that given method was called on mock object **exact number of times**.
///
/// - Parameters:
///   - object: Mock instance
///   - count: Number of invocations
///   - method: Method signature with wrapped parameters (`Parameter`)
public func Verify<T: Mock>(
    _ object: T,
    _ count: Count,
    _ method: T.Verify,
    fileID: StaticString = #fileID,
    filePath: StaticString = #filePath,
    line: UInt = #line,
    column: UInt = #column
) {
    object.verify(
        method,
        count: count,
        at: MockyLocation(fileID: fileID, filePath: filePath, line: line, column: column)
    )
}

// MARK: - Static member called with explicit count

/// Verify that given static method was called on mock type **exact number of times**.
///
/// - Parameters:
///   - object: Mock type
///   - count: Number of invocations
///   - method: Static method signature with wrapped parameters (`Parameter`)
public func Verify<T: StaticMock>(
    _ type: T.Type,
    _ count: Count,
    _ method: T.StaticVerify,
    fileID: StaticString = #fileID,
    filePath: StaticString = #filePath,
    line: UInt = #line,
    column: UInt = #column
) {
    T.verify(
        method,
        count: count,
        at: MockyLocation(fileID: fileID, filePath: filePath, line: line, column: column)
    )
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
    let errorMessage = "[FATAL] \(message)"
    FatalErrorUtil.fatalError(errorMessage)
}

/// [Internal] Used for handling fatal errors inside library.
///
/// Both handlers crash instead of calling `exit(0)`, which used to leave the process with a
/// success status right after a failure had been reported. A missing stub is a defect in the
/// test, so it must be impossible to mistake for a passing run: `fatalError` gives a message,
/// a stack trace and a debugger stop at the offending call.
public struct FatalErrorUtil {
    /// [Internal] Handler
    nonisolated(unsafe) private static var handler: (String) -> Never = {
        fatalError($0)
    }
    /// [Internal] Default handler
    nonisolated(unsafe) private static var defalutHandler: (String) -> Never = {
        fatalError($0)
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
