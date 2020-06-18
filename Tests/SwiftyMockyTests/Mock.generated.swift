// Generated using Sourcery 0.18.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



// Generated with SwiftyMocky 4.0.0

import SwiftyMocky
import XCTest
import Foundation
@testable import Mocky_Example_SPM


// MARK: - SimpleProtocolUsingCollections
open class SimpleProtocolUsingCollectionsMock: SimpleProtocolUsingCollections, SwiftyMocky.Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func getArray() -> [Int] {
        addInvocation(.m_getArray)
		let perform = methodPerformValue(.m_getArray) as? () -> Void
		perform?()
		var __value: [Int]
		do {
		    __value = try methodReturnValue(.m_getArray).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getArray(). Use given")
			Failure("Stub return value not specified for getArray(). Use given")
		}
		return __value
    }

    open func map(array: [String], param: Int) -> [Int: String] {
        addInvocation(.m_map__array_arrayparam_param(Parameter<[String]>.value(`array`), Parameter<Int>.value(`param`)))
		let perform = methodPerformValue(.m_map__array_arrayparam_param(Parameter<[String]>.value(`array`), Parameter<Int>.value(`param`))) as? ([String], Int) -> Void
		perform?(`array`, `param`)
		var __value: [Int: String]
		do {
		    __value = try methodReturnValue(.m_map__array_arrayparam_param(Parameter<[String]>.value(`array`), Parameter<Int>.value(`param`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for map(array: [String], param: Int). Use given")
			Failure("Stub return value not specified for map(array: [String], param: Int). Use given")
		}
		return __value
    }

    open func use(dictionary: [Int: String]) -> [Int: String] {
        addInvocation(.m_use__dictionary_dictionary(Parameter<[Int: String]>.value(`dictionary`)))
		let perform = methodPerformValue(.m_use__dictionary_dictionary(Parameter<[Int: String]>.value(`dictionary`))) as? ([Int: String]) -> Void
		perform?(`dictionary`)
		var __value: [Int: String]
		do {
		    __value = try methodReturnValue(.m_use__dictionary_dictionary(Parameter<[Int: String]>.value(`dictionary`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for use(dictionary: [Int: String]). Use given")
			Failure("Stub return value not specified for use(dictionary: [Int: String]). Use given")
		}
		return __value
    }

    open func verify(set: Set<Int>) -> Bool {
        addInvocation(.m_verify__set_set(Parameter<Set<Int>>.value(`set`)))
		let perform = methodPerformValue(.m_verify__set_set(Parameter<Set<Int>>.value(`set`))) as? (Set<Int>) -> Void
		perform?(`set`)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.m_verify__set_set(Parameter<Set<Int>>.value(`set`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for verify(set: Set<Int>). Use given")
			Failure("Stub return value not specified for verify(set: Set<Int>). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_getArray
        case m_map__array_arrayparam_param(Parameter<[String]>, Parameter<Int>)
        case m_use__dictionary_dictionary(Parameter<[Int: String]>)
        case m_verify__set_set(Parameter<Set<Int>>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_getArray, .m_getArray):
                return true
            case (.m_map__array_arrayparam_param(let lhsArray, let lhsParam), .m_map__array_arrayparam_param(let rhsArray, let rhsParam)):
                guard Parameter.compare(lhs: lhsArray, rhs: rhsArray, with: matcher) else { return false }
                guard Parameter.compare(lhs: lhsParam, rhs: rhsParam, with: matcher) else { return false }
                return true
            case (.m_use__dictionary_dictionary(let lhsDictionary), .m_use__dictionary_dictionary(let rhsDictionary)):
                guard Parameter.compare(lhs: lhsDictionary, rhs: rhsDictionary, with: matcher) else { return false }
                return true
            case (.m_verify__set_set(let lhsSet), .m_verify__set_set(let rhsSet)):
                guard Parameter.compare(lhs: lhsSet, rhs: rhsSet, with: matcher) else { return false }
                return true
            default: return false
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_getArray: return 0
            case let .m_map__array_arrayparam_param(p0, p1): return p0.intValue + p1.intValue
            case let .m_use__dictionary_dictionary(p0): return p0.intValue
            case let .m_verify__set_set(p0): return p0.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func getArray(willReturn: [Int]...) -> MethodStub {
            return Given(method: .m_getArray, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func map(array: Parameter<[String]>, param: Parameter<Int>, willReturn: [Int: String]...) -> MethodStub {
            return Given(method: .m_map__array_arrayparam_param(`array`, `param`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func use(dictionary: Parameter<[Int: String]>, willReturn: [Int: String]...) -> MethodStub {
            return Given(method: .m_use__dictionary_dictionary(`dictionary`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func verify(set: Parameter<Set<Int>>, willReturn: Bool...) -> MethodStub {
            return Given(method: .m_verify__set_set(`set`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getArray(willProduce: (Stubber<[Int]>) -> Void) -> MethodStub {
            let willReturn: [[Int]] = []
			let given: Given = { return Given(method: .m_getArray, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: ([Int]).self)
			willProduce(stubber)
			return given
        }
        public static func map(array: Parameter<[String]>, param: Parameter<Int>, willProduce: (Stubber<[Int: String]>) -> Void) -> MethodStub {
            let willReturn: [[Int: String]] = []
			let given: Given = { return Given(method: .m_map__array_arrayparam_param(`array`, `param`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: ([Int: String]).self)
			willProduce(stubber)
			return given
        }
        public static func use(dictionary: Parameter<[Int: String]>, willProduce: (Stubber<[Int: String]>) -> Void) -> MethodStub {
            let willReturn: [[Int: String]] = []
			let given: Given = { return Given(method: .m_use__dictionary_dictionary(`dictionary`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: ([Int: String]).self)
			willProduce(stubber)
			return given
        }
        public static func verify(set: Parameter<Set<Int>>, willProduce: (Stubber<Bool>) -> Void) -> MethodStub {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .m_verify__set_set(`set`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getArray() -> Verify { return Verify(method: .m_getArray)}
        public static func map(array: Parameter<[String]>, param: Parameter<Int>) -> Verify { return Verify(method: .m_map__array_arrayparam_param(`array`, `param`))}
        public static func use(dictionary: Parameter<[Int: String]>) -> Verify { return Verify(method: .m_use__dictionary_dictionary(`dictionary`))}
        public static func verify(set: Parameter<Set<Int>>) -> Verify { return Verify(method: .m_verify__set_set(`set`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getArray(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_getArray, performs: perform)
        }
        public static func map(array: Parameter<[String]>, param: Parameter<Int>, perform: @escaping ([String], Int) -> Void) -> Perform {
            return Perform(method: .m_map__array_arrayparam_param(`array`, `param`), performs: perform)
        }
        public static func use(dictionary: Parameter<[Int: String]>, perform: @escaping ([Int: String]) -> Void) -> Perform {
            return Perform(method: .m_use__dictionary_dictionary(`dictionary`), performs: perform)
        }
        public static func verify(set: Parameter<Set<Int>>, perform: @escaping (Set<Int>) -> Void) -> Perform {
            return Perform(method: .m_verify__set_set(`set`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
    }
}

