import Foundation

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
