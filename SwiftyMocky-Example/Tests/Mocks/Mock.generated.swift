// Generated using Sourcery 0.9.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


#if Mocky
import SwiftyMocky
import XCTest
import RxSwift
@testable import Mocky_Example
#else
import Sourcery
import SourceryRuntime
#endif

//swiftlint:disable force_cast
//swiftlint:disable function_body_length
//swiftlint:disable line_length
//swiftlint:disable vertical_whitespace

// MARK: - AMassiveTestProtocol
class AMassiveTestProtocolMock: AMassiveTestProtocol, Mock, StaticMock {
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default
    static private var invocations: [StaticMethodType] = []
    static private var methodReturnValues: [StaticGiven] = []
    static private var methodPerformValues: [StaticPerform] = []
    static var matcher: Matcher = Matcher.default

    var nonOptionalClosure: () -> Void { 
		get { return __nonOptionalClosure.orFail("AMassiveTestProtocolMock - value for nonOptionalClosure was not defined") }
		set { __nonOptionalClosure = newValue }
	}
	private var __nonOptionalClosure: (() -> Void)?
    var optionalClosure: (() -> Int)? { 
		get { return __optionalClosure }
		set { __optionalClosure = newValue }
	}
	private var __optionalClosure: (() -> Int)?
    var implicitelyUnwrappedClosure: (() -> Void)! { 
		get { return __implicitelyUnwrappedClosure.orFail("AMassiveTestProtocolMock - value for implicitelyUnwrappedClosure was not defined") }
		set { __implicitelyUnwrappedClosure = newValue }
	}
	private var __implicitelyUnwrappedClosure: (() -> Void)?
    static var optionalClosure: (() -> Int)? { 
		get { return AMassiveTestProtocolMock.__optionalClosure }
		set { AMassiveTestProtocolMock.__optionalClosure = newValue }
	}
	private static var __optionalClosure: (() -> Int)?

    static func methodThatThrows() throws {
        addInvocation(.smethodThatThrows)
		let perform = methodPerformValue(.smethodThatThrows) as? () -> Void
		perform?()
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.smethodThatThrows)
		if let error = givenValue.error { throw error }
    }

    static func methodThatReturnsAndThrows(param: String) throws -> Int {
        addInvocation(.smethodThatReturnsAndThrows__param_param(Parameter<String>.value(param)))
		let perform = methodPerformValue(.smethodThatReturnsAndThrows__param_param(Parameter<String>.value(param))) as? (String) -> Void
		perform?(param)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.smethodThatReturnsAndThrows__param_param(Parameter<String>.value(param)))
		if let error = givenValue.error { throw error }
		let value = givenValue.value as? Int
		return value.orFail("stub return value not specified for methodThatReturnsAndThrows(param: String). Use given")
    }

    static func methodThatRethrows(param: (String) throws -> Int) rethrows -> Int {
        addInvocation(.smethodThatRethrows__param_param(Parameter<(String) throws -> Int>.any))
		let perform = methodPerformValue(.smethodThatRethrows__param_param(Parameter<(String) throws -> Int>.any)) as? ((String) throws -> Int) -> Void
		perform?(param)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.smethodThatRethrows__param_param(Parameter<(String) throws -> Int>.any))
		let value = givenValue.value as? Int
		return value.orFail("stub return value not specified for methodThatRethrows(param: (String) throws -> Int). Use given")
    }

    required init() { }

    required init(_ sth: Int) { }

    func methodThatThrows() throws {
        addInvocation(.imethodThatThrows)
		let perform = methodPerformValue(.imethodThatThrows) as? () -> Void
		perform?()
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.imethodThatThrows)
		if let error = givenValue.error { throw error }
    }

    func methodThatReturnsAndThrows(param: String) throws -> Int {
        addInvocation(.imethodThatReturnsAndThrows__param_param(Parameter<String>.value(param)))
		let perform = methodPerformValue(.imethodThatReturnsAndThrows__param_param(Parameter<String>.value(param))) as? (String) -> Void
		perform?(param)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.imethodThatReturnsAndThrows__param_param(Parameter<String>.value(param)))
		if let error = givenValue.error { throw error }
		let value = givenValue.value as? Int
		return value.orFail("stub return value not specified for methodThatReturnsAndThrows(param: String). Use given")
    }

    func methodThatRethrows(param: (String) throws -> Int) rethrows -> Int {
        addInvocation(.imethodThatRethrows__param_param(Parameter<(String) throws -> Int>.any))
		let perform = methodPerformValue(.imethodThatRethrows__param_param(Parameter<(String) throws -> Int>.any)) as? ((String) throws -> Int) -> Void
		perform?(param)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.imethodThatRethrows__param_param(Parameter<(String) throws -> Int>.any))
		let value = givenValue.value as? Int
		return value.orFail("stub return value not specified for methodThatRethrows(param: (String) throws -> Int). Use given")
    }

    fileprivate enum StaticMethodType {
        case smethodThatThrows
        case smethodThatReturnsAndThrows__param_param(Parameter<String>)
        case smethodThatRethrows__param_param(Parameter<(String) throws -> Int>)

        static func compareParameters(lhs: StaticMethodType, rhs: StaticMethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.smethodThatThrows, .smethodThatThrows): 
                    return true 
                case (.smethodThatReturnsAndThrows__param_param(let lhsParam), .smethodThatReturnsAndThrows__param_param(let rhsParam)): 
                    guard Parameter.compare(lhs: lhsParam, rhs: rhsParam, with: matcher) else { return false } 
                    return true 
                case (.smethodThatRethrows__param_param(let lhsParam), .smethodThatRethrows__param_param(let rhsParam)): 
                    guard Parameter.compare(lhs: lhsParam, rhs: rhsParam, with: matcher) else { return false } 
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case .smethodThatThrows: return 0
                case let .smethodThatReturnsAndThrows__param_param(p0): return p0.intValue
                case let .smethodThatRethrows__param_param(p0): return p0.intValue
            }
        }
    }

    struct StaticGiven {
        fileprivate var method: StaticMethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: StaticMethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

        static func methodThatReturnsAndThrows(param: Parameter<String>, willReturn: Int) -> StaticGiven {
            return StaticGiven(method: .smethodThatReturnsAndThrows__param_param(param), returns: willReturn, throws: nil)
        }
        static func methodThatRethrows(param: Parameter<(String) throws -> Int>, willReturn: Int) -> StaticGiven {
            return StaticGiven(method: .smethodThatRethrows__param_param(param), returns: willReturn, throws: nil)
        }
        static func methodThatThrows(willThrow: Error) -> StaticGiven {
            return StaticGiven(method: .smethodThatThrows, returns: nil, throws: willThrow)
        }
        static func methodThatReturnsAndThrows(param: Parameter<String>, willThrow: Error) -> StaticGiven {
            return StaticGiven(method: .smethodThatReturnsAndThrows__param_param(param), returns: nil, throws: willThrow)
        }
        static func methodThatRethrows(param: Parameter<(String) throws -> Int>, willThrow: Error) -> StaticGiven {
            return StaticGiven(method: .smethodThatRethrows__param_param(param), returns: nil, throws: willThrow)
        }
    }

    struct StaticVerify {
        fileprivate var method: StaticMethodType

        static func methodThatThrows() -> StaticVerify {
            return StaticVerify(method: .smethodThatThrows)
        }
        static func methodThatReturnsAndThrows(param: Parameter<String>) -> StaticVerify {
            return StaticVerify(method: .smethodThatReturnsAndThrows__param_param(param))
        }
        static func methodThatRethrows(param: Parameter<(String) throws -> Int>) -> StaticVerify {
            return StaticVerify(method: .smethodThatRethrows__param_param(param))
        }
    }

    struct StaticPerform {
        fileprivate var method: StaticMethodType
        var performs: Any

        static func methodThatThrows(perform: () -> Void) -> StaticPerform {
            return StaticPerform(method: .smethodThatThrows, performs: perform)
        }
        static func methodThatReturnsAndThrows(param: Parameter<String>, perform: (String) -> Void) -> StaticPerform {
            return StaticPerform(method: .smethodThatReturnsAndThrows__param_param(param), performs: perform)
        }
        static func methodThatRethrows(param: Parameter<(String) throws -> Int>, perform: ((String) throws -> Int) -> Void) -> StaticPerform {
            return StaticPerform(method: .smethodThatRethrows__param_param(param), performs: perform)
        }
    }

        fileprivate enum MethodType {
        case imethodThatThrows
        case imethodThatReturnsAndThrows__param_param(Parameter<String>)
        case imethodThatRethrows__param_param(Parameter<(String) throws -> Int>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.imethodThatThrows, .imethodThatThrows): 
                    return true 
                case (.imethodThatReturnsAndThrows__param_param(let lhsParam), .imethodThatReturnsAndThrows__param_param(let rhsParam)): 
                    guard Parameter.compare(lhs: lhsParam, rhs: rhsParam, with: matcher) else { return false } 
                    return true 
                case (.imethodThatRethrows__param_param(let lhsParam), .imethodThatRethrows__param_param(let rhsParam)): 
                    guard Parameter.compare(lhs: lhsParam, rhs: rhsParam, with: matcher) else { return false } 
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case .imethodThatThrows: return 0
                case let .imethodThatReturnsAndThrows__param_param(p0): return p0.intValue
                case let .imethodThatRethrows__param_param(p0): return p0.intValue
            }
        }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

        static func methodThatReturnsAndThrows(param: Parameter<String>, willReturn: Int) -> Given {
            return Given(method: .imethodThatReturnsAndThrows__param_param(param), returns: willReturn, throws: nil)
        }
        static func methodThatRethrows(param: Parameter<(String) throws -> Int>, willReturn: Int) -> Given {
            return Given(method: .imethodThatRethrows__param_param(param), returns: willReturn, throws: nil)
        }
        static func methodThatThrows(willThrow: Error) -> Given {
            return Given(method: .imethodThatThrows, returns: nil, throws: willThrow)
        }
        static func methodThatReturnsAndThrows(param: Parameter<String>, willThrow: Error) -> Given {
            return Given(method: .imethodThatReturnsAndThrows__param_param(param), returns: nil, throws: willThrow)
        }
        static func methodThatRethrows(param: Parameter<(String) throws -> Int>, willThrow: Error) -> Given {
            return Given(method: .imethodThatRethrows__param_param(param), returns: nil, throws: willThrow)
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func methodThatThrows() -> Verify {
            return Verify(method: .imethodThatThrows)
        }
        static func methodThatReturnsAndThrows(param: Parameter<String>) -> Verify {
            return Verify(method: .imethodThatReturnsAndThrows__param_param(param))
        }
        static func methodThatRethrows(param: Parameter<(String) throws -> Int>) -> Verify {
            return Verify(method: .imethodThatRethrows__param_param(param))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func methodThatThrows(perform: () -> Void) -> Perform {
            return Perform(method: .imethodThatThrows, performs: perform)
        }
        static func methodThatReturnsAndThrows(param: Parameter<String>, perform: (String) -> Void) -> Perform {
            return Perform(method: .imethodThatReturnsAndThrows__param_param(param), performs: perform)
        }
        static func methodThatRethrows(param: Parameter<(String) throws -> Int>, perform: ((String) throws -> Int) -> Void) -> Perform {
            return Perform(method: .imethodThatRethrows__param_param(param), performs: perform)
        }
    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> (value: Any?, error: Error?) {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher)  }
        return (value: matched?.returns, error: matched?.`throws`)
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }

    static public func matchingCalls(_ method: StaticVerify) -> Int {
        return matchingCalls(method.method).count
    }

    static public func given(_ method: StaticGiven) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    static public func perform(_ method: StaticPerform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    static public func verify(_ method: StaticVerify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    static private func addInvocation(_ call: StaticMethodType) {
        invocations.append(call)
    }

    static private func methodReturnValue(_ method: StaticMethodType) -> (value: Any?, error: Error?) {
        let matched = methodReturnValues.reversed().first { StaticMethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher)  }
        return (value: matched?.returns, error: matched?.`throws`)
    }

    static private func methodPerformValue(_ method: StaticMethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { StaticMethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    static private func matchingCalls(_ method: StaticMethodType) -> [StaticMethodType] {
        return invocations.filter { StaticMethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}

// MARK: - AVeryAssociatedProtocol
class AVeryAssociatedProtocolMock<TypeT1,TypeT2>: AVeryAssociatedProtocol, Mock where TypeT1: Sequence, TypeT2: Comparable, TypeT2: EmptyProtocol {

	typealias T1 = TypeT1
	typealias T2 = TypeT2

    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default


    func fetch(for value: T2) -> T1 {
        addInvocation(.ifetch__for_value(Parameter<T2>.value(value)))
		let perform = methodPerformValue(.ifetch__for_value(Parameter<T2>.value(value))) as? (T2) -> Void
		perform?(value)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.ifetch__for_value(Parameter<T2>.value(value)))
		let value = givenValue.value as? T1
		return value.orFail("stub return value not specified for fetch(for value: T2). Use given")
    }

    fileprivate enum MethodType {
        case ifetch__for_value(Parameter<T2>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.ifetch__for_value(let lhsValue), .ifetch__for_value(let rhsValue)): 
                    guard Parameter.compare(lhs: lhsValue, rhs: rhsValue, with: matcher) else { return false } 
                    return true 
            }
        }

        func intValue() -> Int {
            switch self {
                case let .ifetch__for_value(p0): return p0.intValue
            }
        }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

        static func fetch(for value: Parameter<T2>, willReturn: T1) -> Given {
            return Given(method: .ifetch__for_value(value), returns: willReturn, throws: nil)
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func fetch(for value: Parameter<T2>) -> Verify {
            return Verify(method: .ifetch__for_value(value))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func fetch(for value: Parameter<T2>, perform: (T2) -> Void) -> Perform {
            return Perform(method: .ifetch__for_value(value), performs: perform)
        }
    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> (value: Any?, error: Error?) {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher)  }
        return (value: matched?.returns, error: matched?.`throws`)
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}

// MARK: - AVeryGenericProtocol
class AVeryGenericProtocolMock: AVeryGenericProtocol, Mock, StaticMock {
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default
    static private var invocations: [StaticMethodType] = []
    static private var methodReturnValues: [StaticGiven] = []
    static private var methodPerformValues: [StaticPerform] = []
    static var matcher: Matcher = Matcher.default


    static func generic<Q>(lhs: Q, rhs: Q) -> Bool where Q: Equatable {
        addInvocation(.sgeneric__lhs_lhsrhs_rhs(Parameter<Q>.value(lhs).wrapAsGeneric(), Parameter<Q>.value(rhs).wrapAsGeneric()))
		let perform = methodPerformValue(.sgeneric__lhs_lhsrhs_rhs(Parameter<Q>.value(lhs).wrapAsGeneric(), Parameter<Q>.value(rhs).wrapAsGeneric())) as? (Q, Q) -> Void
		perform?(lhs, rhs)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.sgeneric__lhs_lhsrhs_rhs(Parameter<Q>.value(lhs).wrapAsGeneric(), Parameter<Q>.value(rhs).wrapAsGeneric()))
		let value = givenValue.value as? Bool
		return value.orFail("stub return value not specified for generic<Q>(lhs: Q, rhs: Q). Use given")
    }

    static func veryConstrained<Q: Sequence>(lhs: Q, rhs: Q) -> Bool where Q: Equatable {
        addInvocation(.sveryConstrained__lhs_lhsrhs_rhs(Parameter<Q>.value(lhs).wrapAsGeneric(), Parameter<Q>.value(rhs).wrapAsGeneric()))
		let perform = methodPerformValue(.sveryConstrained__lhs_lhsrhs_rhs(Parameter<Q>.value(lhs).wrapAsGeneric(), Parameter<Q>.value(rhs).wrapAsGeneric())) as? (Q, Q) -> Void
		perform?(lhs, rhs)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.sveryConstrained__lhs_lhsrhs_rhs(Parameter<Q>.value(lhs).wrapAsGeneric(), Parameter<Q>.value(rhs).wrapAsGeneric()))
		let value = givenValue.value as? Bool
		return value.orFail("stub return value not specified for veryConstrained<Q: Sequence>(lhs: Q, rhs: Q). Use given")
    }

    required init<V>(value: V) { }

    func methodConstrained<A,B,C>(param: A) -> (B,C) {
        addInvocation(.imethodConstrained__param_param(Parameter<A>.value(param).wrapAsGeneric()))
		let perform = methodPerformValue(.imethodConstrained__param_param(Parameter<A>.value(param).wrapAsGeneric())) as? (A) -> Void
		perform?(param)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.imethodConstrained__param_param(Parameter<A>.value(param).wrapAsGeneric()))
		let value = givenValue.value as? (B,C)
		return value.orFail("stub return value not specified for methodConstrained<A,B,C>(param: A). Use given")
    }

    fileprivate enum StaticMethodType {
        case sgeneric__lhs_lhsrhs_rhs(Parameter<GenericAttribute>, Parameter<GenericAttribute>)
        case sveryConstrained__lhs_lhsrhs_rhs(Parameter<GenericAttribute>, Parameter<GenericAttribute>)

        static func compareParameters(lhs: StaticMethodType, rhs: StaticMethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.sgeneric__lhs_lhsrhs_rhs(let lhsLhs, let lhsRhs), .sgeneric__lhs_lhsrhs_rhs(let rhsLhs, let rhsRhs)): 
                    guard Parameter.compare(lhs: lhsLhs, rhs: rhsLhs, with: matcher) else { return false } 
                    guard Parameter.compare(lhs: lhsRhs, rhs: rhsRhs, with: matcher) else { return false } 
                    return true 
                case (.sveryConstrained__lhs_lhsrhs_rhs(let lhsLhs, let lhsRhs), .sveryConstrained__lhs_lhsrhs_rhs(let rhsLhs, let rhsRhs)): 
                    guard Parameter.compare(lhs: lhsLhs, rhs: rhsLhs, with: matcher) else { return false } 
                    guard Parameter.compare(lhs: lhsRhs, rhs: rhsRhs, with: matcher) else { return false } 
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case let .sgeneric__lhs_lhsrhs_rhs(p0, p1): return p0.intValue + p1.intValue
                case let .sveryConstrained__lhs_lhsrhs_rhs(p0, p1): return p0.intValue + p1.intValue
            }
        }
    }

    struct StaticGiven {
        fileprivate var method: StaticMethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: StaticMethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

        static func generic<Q>(lhs: Parameter<Q>, rhs: Parameter<Q>, willReturn: Bool) -> StaticGiven {
            return StaticGiven(method: .sgeneric__lhs_lhsrhs_rhs(lhs.wrapAsGeneric(), rhs.wrapAsGeneric()), returns: willReturn, throws: nil)
        }
        static func veryConstrained<Q: Sequence>(lhs: Parameter<Q>, rhs: Parameter<Q>, willReturn: Bool) -> StaticGiven {
            return StaticGiven(method: .sveryConstrained__lhs_lhsrhs_rhs(lhs.wrapAsGeneric(), rhs.wrapAsGeneric()), returns: willReturn, throws: nil)
        }
    }

    struct StaticVerify {
        fileprivate var method: StaticMethodType

        static func generic<Q>(lhs: Parameter<Q>, rhs: Parameter<Q>) -> StaticVerify {
            return StaticVerify(method: .sgeneric__lhs_lhsrhs_rhs(lhs.wrapAsGeneric(), rhs.wrapAsGeneric()))
        }
        static func veryConstrained<Q>(lhs: Parameter<Q>, rhs: Parameter<Q>) -> StaticVerify {
            return StaticVerify(method: .sveryConstrained__lhs_lhsrhs_rhs(lhs.wrapAsGeneric(), rhs.wrapAsGeneric()))
        }
    }

    struct StaticPerform {
        fileprivate var method: StaticMethodType
        var performs: Any

        static func generic<Q>(lhs: Parameter<Q>, rhs: Parameter<Q>, perform: (Q, Q) -> Void) -> StaticPerform {
            return StaticPerform(method: .sgeneric__lhs_lhsrhs_rhs(lhs.wrapAsGeneric(), rhs.wrapAsGeneric()), performs: perform)
        }
        static func veryConstrained<Q>(lhs: Parameter<Q>, rhs: Parameter<Q>, perform: (Q, Q) -> Void) -> StaticPerform {
            return StaticPerform(method: .sveryConstrained__lhs_lhsrhs_rhs(lhs.wrapAsGeneric(), rhs.wrapAsGeneric()), performs: perform)
        }
    }

        fileprivate enum MethodType {
        case imethodConstrained__param_param(Parameter<GenericAttribute>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.imethodConstrained__param_param(let lhsParam), .imethodConstrained__param_param(let rhsParam)): 
                    guard Parameter.compare(lhs: lhsParam, rhs: rhsParam, with: matcher) else { return false } 
                    return true 
            }
        }

        func intValue() -> Int {
            switch self {
                case let .imethodConstrained__param_param(p0): return p0.intValue
            }
        }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

        static func methodConstrained<A,B,C>(param: Parameter<A>, willReturn: (B,C)) -> Given {
            return Given(method: .imethodConstrained__param_param(param.wrapAsGeneric()), returns: willReturn, throws: nil)
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func methodConstrained<A>(param: Parameter<A>) -> Verify {
            return Verify(method: .imethodConstrained__param_param(param.wrapAsGeneric()))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func methodConstrained<A>(param: Parameter<A>, perform: (A) -> Void) -> Perform {
            return Perform(method: .imethodConstrained__param_param(param.wrapAsGeneric()), performs: perform)
        }
    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> (value: Any?, error: Error?) {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher)  }
        return (value: matched?.returns, error: matched?.`throws`)
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }

    static public func matchingCalls(_ method: StaticVerify) -> Int {
        return matchingCalls(method.method).count
    }

    static public func given(_ method: StaticGiven) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    static public func perform(_ method: StaticPerform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    static public func verify(_ method: StaticVerify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    static private func addInvocation(_ call: StaticMethodType) {
        invocations.append(call)
    }

    static private func methodReturnValue(_ method: StaticMethodType) -> (value: Any?, error: Error?) {
        let matched = methodReturnValues.reversed().first { StaticMethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher)  }
        return (value: matched?.returns, error: matched?.`throws`)
    }

    static private func methodPerformValue(_ method: StaticMethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { StaticMethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    static private func matchingCalls(_ method: StaticMethodType) -> [StaticMethodType] {
        return invocations.filter { StaticMethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}

// MARK: - ComplicatedServiceType
class ComplicatedServiceTypeMock: ComplicatedServiceType, Mock {
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default

    var youCouldOnlyGetThis: String { 
		get { return __youCouldOnlyGetThis.orFail("ComplicatedServiceTypeMock - value for youCouldOnlyGetThis was not defined") }
		set { __youCouldOnlyGetThis = newValue }
	}
	private var __youCouldOnlyGetThis: (String)?

    func serviceName() -> String {
        addInvocation(.iserviceName)
		let perform = methodPerformValue(.iserviceName) as? () -> Void
		perform?()
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.iserviceName)
		let value = givenValue.value as? String
		return value.orFail("stub return value not specified for serviceName(). Use given")
    }

    func aNewWayToSayHooray() {
        addInvocation(.iaNewWayToSayHooray)
		let perform = methodPerformValue(.iaNewWayToSayHooray) as? () -> Void
		perform?()
    }

    func getPoint(from point: Point) -> Point {
        addInvocation(.igetPoint__from_point(Parameter<Point>.value(point)))
		let perform = methodPerformValue(.igetPoint__from_point(Parameter<Point>.value(point))) as? (Point) -> Void
		perform?(point)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.igetPoint__from_point(Parameter<Point>.value(point)))
		let value = givenValue.value as? Point
		return value.orFail("stub return value not specified for getPoint(from point: Point). Use given")
    }

    func getPoint(from tuple: (Float,Float)) -> Point {
        addInvocation(.igetPoint__from_tuple(Parameter<(Float,Float)>.value(tuple)))
		let perform = methodPerformValue(.igetPoint__from_tuple(Parameter<(Float,Float)>.value(tuple))) as? ((Float,Float)) -> Void
		perform?(tuple)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.igetPoint__from_tuple(Parameter<(Float,Float)>.value(tuple)))
		let value = givenValue.value as? Point
		return value.orFail("stub return value not specified for getPoint(from tuple: (Float,Float)). Use given")
    }

    func similarMethodThatDiffersOnType(_ value: Float) -> Bool {
        addInvocation(.isimilarMethodThatDiffersOnType__value_1(Parameter<Float>.value(value)))
		let perform = methodPerformValue(.isimilarMethodThatDiffersOnType__value_1(Parameter<Float>.value(value))) as? (Float) -> Void
		perform?(value)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.isimilarMethodThatDiffersOnType__value_1(Parameter<Float>.value(value)))
		let value = givenValue.value as? Bool
		return value.orFail("stub return value not specified for similarMethodThatDiffersOnType(_ value: Float). Use given")
    }

    func similarMethodThatDiffersOnType(_ value: Point) -> Bool {
        addInvocation(.isimilarMethodThatDiffersOnType__value_2(Parameter<Point>.value(value)))
		let perform = methodPerformValue(.isimilarMethodThatDiffersOnType__value_2(Parameter<Point>.value(value))) as? (Point) -> Void
		perform?(value)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.isimilarMethodThatDiffersOnType__value_2(Parameter<Point>.value(value)))
		let value = givenValue.value as? Bool
		return value.orFail("stub return value not specified for similarMethodThatDiffersOnType(_ value: Point). Use given")
    }

    func methodWithTypedef(_ scalar: Scalar) {
        addInvocation(.imethodWithTypedef__scalar(Parameter<Scalar>.value(scalar)))
		let perform = methodPerformValue(.imethodWithTypedef__scalar(Parameter<Scalar>.value(scalar))) as? (Scalar) -> Void
		perform?(scalar)
    }

    func methodWithClosures(success function: LinearFunction) -> ClosureFabric {
        addInvocation(.imethodWithClosures__success_function_1(Parameter<LinearFunction>.any))
		let perform = methodPerformValue(.imethodWithClosures__success_function_1(Parameter<LinearFunction>.any)) as? (LinearFunction) -> Void
		perform?(function)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.imethodWithClosures__success_function_1(Parameter<LinearFunction>.any))
		let value = givenValue.value as? ClosureFabric
		return value.orFail("stub return value not specified for methodWithClosures(success function: LinearFunction). Use given")
    }

    func methodWithClosures(success function: ((Scalar,Scalar) -> Scalar)?) -> ((Int) -> Void) {
        addInvocation(.imethodWithClosures__success_function_2(Parameter<((Scalar,Scalar) -> Scalar)?>.value(function)))
		let perform = methodPerformValue(.imethodWithClosures__success_function_2(Parameter<((Scalar,Scalar) -> Scalar)?>.value(function))) as? (((Scalar,Scalar) -> Scalar)?) -> Void
		perform?(function)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.imethodWithClosures__success_function_2(Parameter<((Scalar,Scalar) -> Scalar)?>.value(function)))
		let value = givenValue.value as? (Int) -> Void
		return value.orFail("stub return value not specified for methodWithClosures(success function: ((Scalar,Scalar) -> Scalar)?). Use given")
    }

    fileprivate enum MethodType {
        case iserviceName
        case iaNewWayToSayHooray
        case igetPoint__from_point(Parameter<Point>)
        case igetPoint__from_tuple(Parameter<(Float,Float)>)
        case isimilarMethodThatDiffersOnType__value_1(Parameter<Float>)
        case isimilarMethodThatDiffersOnType__value_2(Parameter<Point>)
        case imethodWithTypedef__scalar(Parameter<Scalar>)
        case imethodWithClosures__success_function_1(Parameter<LinearFunction>)
        case imethodWithClosures__success_function_2(Parameter<((Scalar,Scalar) -> Scalar)?>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.iserviceName, .iserviceName): 
                    return true 
                case (.iaNewWayToSayHooray, .iaNewWayToSayHooray): 
                    return true 
                case (.igetPoint__from_point(let lhsPoint), .igetPoint__from_point(let rhsPoint)): 
                    guard Parameter.compare(lhs: lhsPoint, rhs: rhsPoint, with: matcher) else { return false } 
                    return true 
                case (.igetPoint__from_tuple(let lhsTuple), .igetPoint__from_tuple(let rhsTuple)): 
                    guard Parameter.compare(lhs: lhsTuple, rhs: rhsTuple, with: matcher) else { return false } 
                    return true 
                case (.isimilarMethodThatDiffersOnType__value_1(let lhsValue), .isimilarMethodThatDiffersOnType__value_1(let rhsValue)): 
                    guard Parameter.compare(lhs: lhsValue, rhs: rhsValue, with: matcher) else { return false } 
                    return true 
                case (.isimilarMethodThatDiffersOnType__value_2(let lhsValue), .isimilarMethodThatDiffersOnType__value_2(let rhsValue)): 
                    guard Parameter.compare(lhs: lhsValue, rhs: rhsValue, with: matcher) else { return false } 
                    return true 
                case (.imethodWithTypedef__scalar(let lhsScalar), .imethodWithTypedef__scalar(let rhsScalar)): 
                    guard Parameter.compare(lhs: lhsScalar, rhs: rhsScalar, with: matcher) else { return false } 
                    return true 
                case (.imethodWithClosures__success_function_1(let lhsFunction), .imethodWithClosures__success_function_1(let rhsFunction)): 
                    guard Parameter.compare(lhs: lhsFunction, rhs: rhsFunction, with: matcher) else { return false } 
                    return true 
                case (.imethodWithClosures__success_function_2(let lhsFunction), .imethodWithClosures__success_function_2(let rhsFunction)): 
                    guard Parameter.compare(lhs: lhsFunction, rhs: rhsFunction, with: matcher) else { return false } 
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case .iserviceName: return 0
                case .iaNewWayToSayHooray: return 0
                case let .igetPoint__from_point(p0): return p0.intValue
                case let .igetPoint__from_tuple(p0): return p0.intValue
                case let .isimilarMethodThatDiffersOnType__value_1(p0): return p0.intValue
                case let .isimilarMethodThatDiffersOnType__value_2(p0): return p0.intValue
                case let .imethodWithTypedef__scalar(p0): return p0.intValue
                case let .imethodWithClosures__success_function_1(p0): return p0.intValue
                case let .imethodWithClosures__success_function_2(p0): return p0.intValue
            }
        }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

        static func serviceName(willReturn: String) -> Given {
            return Given(method: .iserviceName, returns: willReturn, throws: nil)
        }
        static func getPoint(from point: Parameter<Point>, willReturn: Point) -> Given {
            return Given(method: .igetPoint__from_point(point), returns: willReturn, throws: nil)
        }
        static func getPoint(from tuple: Parameter<(Float,Float)>, willReturn: Point) -> Given {
            return Given(method: .igetPoint__from_tuple(tuple), returns: willReturn, throws: nil)
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Float>, willReturn: Bool) -> Given {
            return Given(method: .isimilarMethodThatDiffersOnType__value_1(value), returns: willReturn, throws: nil)
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Point>, willReturn: Bool) -> Given {
            return Given(method: .isimilarMethodThatDiffersOnType__value_2(value), returns: willReturn, throws: nil)
        }
        static func methodWithClosures(success function: Parameter<LinearFunction>, willReturn: ClosureFabric) -> Given {
            return Given(method: .imethodWithClosures__success_function_1(function), returns: willReturn, throws: nil)
        }
        static func methodWithClosures(success function: Parameter<((Scalar,Scalar) -> Scalar)?>, willReturn: (Int) -> Void) -> Given {
            return Given(method: .imethodWithClosures__success_function_2(function), returns: willReturn, throws: nil)
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func serviceName() -> Verify {
            return Verify(method: .iserviceName)
        }
        static func aNewWayToSayHooray() -> Verify {
            return Verify(method: .iaNewWayToSayHooray)
        }
        static func getPoint(from point: Parameter<Point>) -> Verify {
            return Verify(method: .igetPoint__from_point(point))
        }
        static func getPoint(from tuple: Parameter<(Float,Float)>) -> Verify {
            return Verify(method: .igetPoint__from_tuple(tuple))
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Float>) -> Verify {
            return Verify(method: .isimilarMethodThatDiffersOnType__value_1(value))
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Point>) -> Verify {
            return Verify(method: .isimilarMethodThatDiffersOnType__value_2(value))
        }
        static func methodWithTypedef(scalar: Parameter<Scalar>) -> Verify {
            return Verify(method: .imethodWithTypedef__scalar(scalar))
        }
        static func methodWithClosures(success function: Parameter<LinearFunction>) -> Verify {
            return Verify(method: .imethodWithClosures__success_function_1(function))
        }
        static func methodWithClosures(success function: Parameter<((Scalar,Scalar) -> Scalar)?>) -> Verify {
            return Verify(method: .imethodWithClosures__success_function_2(function))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func serviceName(perform: () -> Void) -> Perform {
            return Perform(method: .iserviceName, performs: perform)
        }
        static func aNewWayToSayHooray(perform: () -> Void) -> Perform {
            return Perform(method: .iaNewWayToSayHooray, performs: perform)
        }
        static func getPoint(from point: Parameter<Point>, perform: (Point) -> Void) -> Perform {
            return Perform(method: .igetPoint__from_point(point), performs: perform)
        }
        static func getPoint(from tuple: Parameter<(Float,Float)>, perform: ((Float,Float)) -> Void) -> Perform {
            return Perform(method: .igetPoint__from_tuple(tuple), performs: perform)
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Float>, perform: (Float) -> Void) -> Perform {
            return Perform(method: .isimilarMethodThatDiffersOnType__value_1(value), performs: perform)
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Point>, perform: (Point) -> Void) -> Perform {
            return Perform(method: .isimilarMethodThatDiffersOnType__value_2(value), performs: perform)
        }
        static func methodWithTypedef(scalar: Parameter<Scalar>, perform: (Scalar) -> Void) -> Perform {
            return Perform(method: .imethodWithTypedef__scalar(scalar), performs: perform)
        }
        static func methodWithClosures(success function: Parameter<LinearFunction>, perform: (LinearFunction) -> Void) -> Perform {
            return Perform(method: .imethodWithClosures__success_function_1(function), performs: perform)
        }
        static func methodWithClosures(success function: Parameter<((Scalar,Scalar) -> Scalar)?>, perform: (((Scalar,Scalar) -> Scalar)?) -> Void) -> Perform {
            return Perform(method: .imethodWithClosures__success_function_2(function), performs: perform)
        }
    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> (value: Any?, error: Error?) {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher)  }
        return (value: matched?.returns, error: matched?.`throws`)
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}

// MARK: - DateSortable
class DateSortableMock: DateSortable, Mock {
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default

    var date: Date { 
		get { return __date.orFail("DateSortableMock - value for date was not defined") }
		set { __date = newValue }
	}
	private var __date: (Date)?


    fileprivate struct MethodType {
        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool { return true }
        func intValue() -> Int { return 0 }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

    }

    struct Verify {
        fileprivate var method: MethodType

    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> (value: Any?, error: Error?) {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher)  }
        return (value: matched?.returns, error: matched?.`throws`)
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}

// MARK: - EmptyProtocol
class EmptyProtocolMock: EmptyProtocol, Mock {
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default



    fileprivate struct MethodType {
        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool { return true }
        func intValue() -> Int { return 0 }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

    }

    struct Verify {
        fileprivate var method: MethodType

    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> (value: Any?, error: Error?) {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher)  }
        return (value: matched?.returns, error: matched?.`throws`)
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}

// MARK: - HistorySectionMapperType
class HistorySectionMapperTypeMock: HistorySectionMapperType, Mock {
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default


    func map<T: DateSortable>(_ items: [T]) -> [(key: String, items: [T])] {
        addInvocation(.imap__items(Parameter<[T]>.value(items).wrapAsGeneric()))
		let perform = methodPerformValue(.imap__items(Parameter<[T]>.value(items).wrapAsGeneric())) as? ([T]) -> Void
		perform?(items)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.imap__items(Parameter<[T]>.value(items).wrapAsGeneric()))
		let value = givenValue.value as? [(key: String, items: [T])]
		return value.orFail("stub return value not specified for map<T: DateSortable>(_ items: [T]). Use given")
    }

    fileprivate enum MethodType {
        case imap__items(Parameter<GenericAttribute>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.imap__items(let lhsItems), .imap__items(let rhsItems)): 
                    guard Parameter.compare(lhs: lhsItems, rhs: rhsItems, with: matcher) else { return false } 
                    return true 
            }
        }

        func intValue() -> Int {
            switch self {
                case let .imap__items(p0): return p0.intValue
            }
        }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

        static func map<T: DateSortable>(items: Parameter<[T]>, willReturn: [(key: String, items: [T])]) -> Given {
            return Given(method: .imap__items(items.wrapAsGeneric()), returns: willReturn, throws: nil)
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func map<T>(items: Parameter<[T]>) -> Verify {
            return Verify(method: .imap__items(items.wrapAsGeneric()))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func map<T>(items: Parameter<[T]>, perform: ([T]) -> Void) -> Perform {
            return Perform(method: .imap__items(items.wrapAsGeneric()), performs: perform)
        }
    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> (value: Any?, error: Error?) {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher)  }
        return (value: matched?.returns, error: matched?.`throws`)
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}

// MARK: - NonSwiftProtocol
class NonSwiftProtocolMock: NSObject, NonSwiftProtocol, Mock {
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default


    func returnNoting() {
        addInvocation(.ireturnNoting)
		let perform = methodPerformValue(.ireturnNoting) as? () -> Void
		perform?()
    }

    func someMethod() {
        addInvocation(.isomeMethod)
		let perform = methodPerformValue(.isomeMethod) as? () -> Void
		perform?()
    }

    fileprivate enum MethodType {
        case ireturnNoting
        case isomeMethod

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.ireturnNoting, .ireturnNoting): 
                    return true 
                case (.isomeMethod, .isomeMethod): 
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case .ireturnNoting: return 0
                case .isomeMethod: return 0
            }
        }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

    }

    struct Verify {
        fileprivate var method: MethodType

        static func returnNoting() -> Verify {
            return Verify(method: .ireturnNoting)
        }
        static func someMethod() -> Verify {
            return Verify(method: .isomeMethod)
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func returnNoting(perform: () -> Void) -> Perform {
            return Perform(method: .ireturnNoting, performs: perform)
        }
        static func someMethod(perform: () -> Void) -> Perform {
            return Perform(method: .isomeMethod, performs: perform)
        }
    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> (value: Any?, error: Error?) {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher)  }
        return (value: matched?.returns, error: matched?.`throws`)
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}

// MARK: - ProtocolWithAssociatedType
class ProtocolWithAssociatedTypeMock<TypeT>: ProtocolWithAssociatedType, Mock where TypeT: Sequence {

	typealias T = TypeT

    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default

    var sequence: T { 
		get { return __sequence.orFail("ProtocolWithAssociatedTypeMock - value for sequence was not defined") }
		set { __sequence = newValue }
	}
	private var __sequence: (T)?

    func methodWithType(t: T) -> Bool {
        addInvocation(.imethodWithType__t_t(Parameter<T>.value(t)))
		let perform = methodPerformValue(.imethodWithType__t_t(Parameter<T>.value(t))) as? (T) -> Void
		perform?(t)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.imethodWithType__t_t(Parameter<T>.value(t)))
		let value = givenValue.value as? Bool
		return value.orFail("stub return value not specified for methodWithType(t: T). Use given")
    }

    fileprivate enum MethodType {
        case imethodWithType__t_t(Parameter<T>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.imethodWithType__t_t(let lhsT), .imethodWithType__t_t(let rhsT)): 
                    guard Parameter.compare(lhs: lhsT, rhs: rhsT, with: matcher) else { return false } 
                    return true 
            }
        }

        func intValue() -> Int {
            switch self {
                case let .imethodWithType__t_t(p0): return p0.intValue
            }
        }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

        static func methodWithType(t: Parameter<T>, willReturn: Bool) -> Given {
            return Given(method: .imethodWithType__t_t(t), returns: willReturn, throws: nil)
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func methodWithType(t: Parameter<T>) -> Verify {
            return Verify(method: .imethodWithType__t_t(t))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func methodWithType(t: Parameter<T>, perform: (T) -> Void) -> Perform {
            return Perform(method: .imethodWithType__t_t(t), performs: perform)
        }
    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> (value: Any?, error: Error?) {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher)  }
        return (value: matched?.returns, error: matched?.`throws`)
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}

// MARK: - ProtocolWithClosures
class ProtocolWithClosuresMock: ProtocolWithClosures, Mock {
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default


    func methodThatTakes(closure: (Int) -> Int) {
        addInvocation(.imethodThatTakes__closure_closure(Parameter<(Int) -> Int>.any))
		let perform = methodPerformValue(.imethodThatTakes__closure_closure(Parameter<(Int) -> Int>.any)) as? ((Int) -> Int) -> Void
		perform?(closure)
    }

    func methodThatTakesEscaping(closure: @escaping (Int) -> Int) {
        addInvocation(.imethodThatTakesEscaping__closure_closure(Parameter<(Int) -> Int>.value(closure)))
		let perform = methodPerformValue(.imethodThatTakesEscaping__closure_closure(Parameter<(Int) -> Int>.value(closure))) as? (@escaping (Int) -> Int) -> Void
		perform?(closure)
    }

    func methodThatTakesCompletionBlock(completion: (Bool,Error?) -> Void) {
        addInvocation(.imethodThatTakesCompletionBlock__completion_completion(Parameter<(Bool,Error?) -> Void>.any))
		let perform = methodPerformValue(.imethodThatTakesCompletionBlock__completion_completion(Parameter<(Bool,Error?) -> Void>.any)) as? ((Bool,Error?) -> Void) -> Void
		perform?(completion)
    }

    fileprivate enum MethodType {
        case imethodThatTakes__closure_closure(Parameter<(Int) -> Int>)
        case imethodThatTakesEscaping__closure_closure(Parameter<(Int) -> Int>)
        case imethodThatTakesCompletionBlock__completion_completion(Parameter<(Bool,Error?) -> Void>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.imethodThatTakes__closure_closure(let lhsClosure), .imethodThatTakes__closure_closure(let rhsClosure)): 
                    guard Parameter.compare(lhs: lhsClosure, rhs: rhsClosure, with: matcher) else { return false } 
                    return true 
                case (.imethodThatTakesEscaping__closure_closure(let lhsClosure), .imethodThatTakesEscaping__closure_closure(let rhsClosure)): 
                    guard Parameter.compare(lhs: lhsClosure, rhs: rhsClosure, with: matcher) else { return false } 
                    return true 
                case (.imethodThatTakesCompletionBlock__completion_completion(let lhsCompletion), .imethodThatTakesCompletionBlock__completion_completion(let rhsCompletion)): 
                    guard Parameter.compare(lhs: lhsCompletion, rhs: rhsCompletion, with: matcher) else { return false } 
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case let .imethodThatTakes__closure_closure(p0): return p0.intValue
                case let .imethodThatTakesEscaping__closure_closure(p0): return p0.intValue
                case let .imethodThatTakesCompletionBlock__completion_completion(p0): return p0.intValue
            }
        }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

    }

    struct Verify {
        fileprivate var method: MethodType

        static func methodThatTakes(closure: Parameter<(Int) -> Int>) -> Verify {
            return Verify(method: .imethodThatTakes__closure_closure(closure))
        }
        static func methodThatTakesEscaping(closure: Parameter<(Int) -> Int>) -> Verify {
            return Verify(method: .imethodThatTakesEscaping__closure_closure(closure))
        }
        static func methodThatTakesCompletionBlock(completion: Parameter<(Bool,Error?) -> Void>) -> Verify {
            return Verify(method: .imethodThatTakesCompletionBlock__completion_completion(completion))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func methodThatTakes(closure: Parameter<(Int) -> Int>, perform: ((Int) -> Int) -> Void) -> Perform {
            return Perform(method: .imethodThatTakes__closure_closure(closure), performs: perform)
        }
        static func methodThatTakesEscaping(closure: Parameter<(Int) -> Int>, perform: (@escaping (Int) -> Int) -> Void) -> Perform {
            return Perform(method: .imethodThatTakesEscaping__closure_closure(closure), performs: perform)
        }
        static func methodThatTakesCompletionBlock(completion: Parameter<(Bool,Error?) -> Void>, perform: ((Bool,Error?) -> Void) -> Void) -> Perform {
            return Perform(method: .imethodThatTakesCompletionBlock__completion_completion(completion), performs: perform)
        }
    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> (value: Any?, error: Error?) {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher)  }
        return (value: matched?.returns, error: matched?.`throws`)
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}

// MARK: - ProtocolWithCustomAttributes
class ProtocolWithCustomAttributesMock: ProtocolWithCustomAttributes, Mock {
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default


    func methodWith(point: CGPoint) -> Int {
        addInvocation(.imethodWith__point_point(Parameter<CGPoint>.value(point)))
		let perform = methodPerformValue(.imethodWith__point_point(Parameter<CGPoint>.value(point))) as? (CGPoint) -> Void
		perform?(point)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.imethodWith__point_point(Parameter<CGPoint>.value(point)))
		let value = givenValue.value as? Int
		return value.orFail("stub return value not specified for methodWith(point: CGPoint). Use given")
    }

    func methodThatTakesUser(user: UserObject) throws {
        addInvocation(.imethodThatTakesUser__user_user(Parameter<UserObject>.value(user)))
		let perform = methodPerformValue(.imethodThatTakesUser__user_user(Parameter<UserObject>.value(user))) as? (UserObject) -> Void
		perform?(user)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.imethodThatTakesUser__user_user(Parameter<UserObject>.value(user)))
		if let error = givenValue.error { throw error }
    }

    func methodThatTakesArrayOfUsers(array: [UserObject]) -> Int {
        addInvocation(.imethodThatTakesArrayOfUsers__array_array(Parameter<[UserObject]>.value(array)))
		let perform = methodPerformValue(.imethodThatTakesArrayOfUsers__array_array(Parameter<[UserObject]>.value(array))) as? ([UserObject]) -> Void
		perform?(array)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.imethodThatTakesArrayOfUsers__array_array(Parameter<[UserObject]>.value(array)))
		let value = givenValue.value as? Int
		return value.orFail("stub return value not specified for methodThatTakesArrayOfUsers(array: [UserObject]). Use given")
    }

    fileprivate enum MethodType {
        case imethodWith__point_point(Parameter<CGPoint>)
        case imethodThatTakesUser__user_user(Parameter<UserObject>)
        case imethodThatTakesArrayOfUsers__array_array(Parameter<[UserObject]>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.imethodWith__point_point(let lhsPoint), .imethodWith__point_point(let rhsPoint)): 
                    guard Parameter.compare(lhs: lhsPoint, rhs: rhsPoint, with: matcher) else { return false } 
                    return true 
                case (.imethodThatTakesUser__user_user(let lhsUser), .imethodThatTakesUser__user_user(let rhsUser)): 
                    guard Parameter.compare(lhs: lhsUser, rhs: rhsUser, with: matcher) else { return false } 
                    return true 
                case (.imethodThatTakesArrayOfUsers__array_array(let lhsArray), .imethodThatTakesArrayOfUsers__array_array(let rhsArray)): 
                    guard Parameter.compare(lhs: lhsArray, rhs: rhsArray, with: matcher) else { return false } 
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case let .imethodWith__point_point(p0): return p0.intValue
                case let .imethodThatTakesUser__user_user(p0): return p0.intValue
                case let .imethodThatTakesArrayOfUsers__array_array(p0): return p0.intValue
            }
        }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

        static func methodWith(point: Parameter<CGPoint>, willReturn: Int) -> Given {
            return Given(method: .imethodWith__point_point(point), returns: willReturn, throws: nil)
        }
        static func methodThatTakesArrayOfUsers(array: Parameter<[UserObject]>, willReturn: Int) -> Given {
            return Given(method: .imethodThatTakesArrayOfUsers__array_array(array), returns: willReturn, throws: nil)
        }
        static func methodThatTakesUser(user: Parameter<UserObject>, willThrow: Error) -> Given {
            return Given(method: .imethodThatTakesUser__user_user(user), returns: nil, throws: willThrow)
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func methodWith(point: Parameter<CGPoint>) -> Verify {
            return Verify(method: .imethodWith__point_point(point))
        }
        static func methodThatTakesUser(user: Parameter<UserObject>) -> Verify {
            return Verify(method: .imethodThatTakesUser__user_user(user))
        }
        static func methodThatTakesArrayOfUsers(array: Parameter<[UserObject]>) -> Verify {
            return Verify(method: .imethodThatTakesArrayOfUsers__array_array(array))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func methodWith(point: Parameter<CGPoint>, perform: (CGPoint) -> Void) -> Perform {
            return Perform(method: .imethodWith__point_point(point), performs: perform)
        }
        static func methodThatTakesUser(user: Parameter<UserObject>, perform: (UserObject) -> Void) -> Perform {
            return Perform(method: .imethodThatTakesUser__user_user(user), performs: perform)
        }
        static func methodThatTakesArrayOfUsers(array: Parameter<[UserObject]>, perform: ([UserObject]) -> Void) -> Perform {
            return Perform(method: .imethodThatTakesArrayOfUsers__array_array(array), performs: perform)
        }
    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> (value: Any?, error: Error?) {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher)  }
        return (value: matched?.returns, error: matched?.`throws`)
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}

// MARK: - ProtocolWithGenericMethods
class ProtocolWithGenericMethodsMock: ProtocolWithGenericMethods, Mock {
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default


    func methodWithGeneric<T>(lhs: T, rhs: T) -> Bool {
        addInvocation(.imethodWithGeneric__lhs_lhsrhs_rhs(Parameter<T>.value(lhs).wrapAsGeneric(), Parameter<T>.value(rhs).wrapAsGeneric()))
		let perform = methodPerformValue(.imethodWithGeneric__lhs_lhsrhs_rhs(Parameter<T>.value(lhs).wrapAsGeneric(), Parameter<T>.value(rhs).wrapAsGeneric())) as? (T, T) -> Void
		perform?(lhs, rhs)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.imethodWithGeneric__lhs_lhsrhs_rhs(Parameter<T>.value(lhs).wrapAsGeneric(), Parameter<T>.value(rhs).wrapAsGeneric()))
		let value = givenValue.value as? Bool
		return value.orFail("stub return value not specified for methodWithGeneric<T>(lhs: T, rhs: T). Use given")
    }

    func methodWithGenericConstraint<U>(param: [U]) -> U where U: Equatable {
        addInvocation(.imethodWithGenericConstraint__param_param(Parameter<[U]>.value(param).wrapAsGeneric()))
		let perform = methodPerformValue(.imethodWithGenericConstraint__param_param(Parameter<[U]>.value(param).wrapAsGeneric())) as? ([U]) -> Void
		perform?(param)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.imethodWithGenericConstraint__param_param(Parameter<[U]>.value(param).wrapAsGeneric()))
		let value = givenValue.value as? U
		return value.orFail("stub return value not specified for methodWithGenericConstraint<U>(param: [U]). Use given")
    }

    fileprivate enum MethodType {
        case imethodWithGeneric__lhs_lhsrhs_rhs(Parameter<GenericAttribute>, Parameter<GenericAttribute>)
        case imethodWithGenericConstraint__param_param(Parameter<GenericAttribute>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.imethodWithGeneric__lhs_lhsrhs_rhs(let lhsLhs, let lhsRhs), .imethodWithGeneric__lhs_lhsrhs_rhs(let rhsLhs, let rhsRhs)): 
                    guard Parameter.compare(lhs: lhsLhs, rhs: rhsLhs, with: matcher) else { return false } 
                    guard Parameter.compare(lhs: lhsRhs, rhs: rhsRhs, with: matcher) else { return false } 
                    return true 
                case (.imethodWithGenericConstraint__param_param(let lhsParam), .imethodWithGenericConstraint__param_param(let rhsParam)): 
                    guard Parameter.compare(lhs: lhsParam, rhs: rhsParam, with: matcher) else { return false } 
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case let .imethodWithGeneric__lhs_lhsrhs_rhs(p0, p1): return p0.intValue + p1.intValue
                case let .imethodWithGenericConstraint__param_param(p0): return p0.intValue
            }
        }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

        static func methodWithGeneric<T>(lhs: Parameter<T>, rhs: Parameter<T>, willReturn: Bool) -> Given {
            return Given(method: .imethodWithGeneric__lhs_lhsrhs_rhs(lhs.wrapAsGeneric(), rhs.wrapAsGeneric()), returns: willReturn, throws: nil)
        }
        static func methodWithGenericConstraint<U>(param: Parameter<[U]>, willReturn: U) -> Given {
            return Given(method: .imethodWithGenericConstraint__param_param(param.wrapAsGeneric()), returns: willReturn, throws: nil)
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func methodWithGeneric<T>(lhs: Parameter<T>, rhs: Parameter<T>) -> Verify {
            return Verify(method: .imethodWithGeneric__lhs_lhsrhs_rhs(lhs.wrapAsGeneric(), rhs.wrapAsGeneric()))
        }
        static func methodWithGenericConstraint<U>(param: Parameter<[U]>) -> Verify {
            return Verify(method: .imethodWithGenericConstraint__param_param(param.wrapAsGeneric()))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func methodWithGeneric<T>(lhs: Parameter<T>, rhs: Parameter<T>, perform: (T, T) -> Void) -> Perform {
            return Perform(method: .imethodWithGeneric__lhs_lhsrhs_rhs(lhs.wrapAsGeneric(), rhs.wrapAsGeneric()), performs: perform)
        }
        static func methodWithGenericConstraint<U>(param: Parameter<[U]>, perform: ([U]) -> Void) -> Perform {
            return Perform(method: .imethodWithGenericConstraint__param_param(param.wrapAsGeneric()), performs: perform)
        }
    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> (value: Any?, error: Error?) {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher)  }
        return (value: matched?.returns, error: matched?.`throws`)
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}

// MARK: - ProtocolWithInitializers
class ProtocolWithInitializersMock: ProtocolWithInitializers, Mock {
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default

    var param: Int { 
		get { return __param.orFail("ProtocolWithInitializersMock - value for param was not defined") }
		set { __param = newValue }
	}
	private var __param: (Int)?
    var other: String { 
		get { return __other.orFail("ProtocolWithInitializersMock - value for other was not defined") }
		set { __other = newValue }
	}
	private var __other: (String)?

    required init(param: Int, other: String) { }

    required init(param: Int) { }


    fileprivate struct MethodType {
        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool { return true }
        func intValue() -> Int { return 0 }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

    }

    struct Verify {
        fileprivate var method: MethodType

    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> (value: Any?, error: Error?) {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher)  }
        return (value: matched?.returns, error: matched?.`throws`)
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}

// MARK: - ProtocolWithStaticMembers
class ProtocolWithStaticMembersMock: ProtocolWithStaticMembers, Mock, StaticMock {
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default
    static private var invocations: [StaticMethodType] = []
    static private var methodReturnValues: [StaticGiven] = []
    static private var methodPerformValues: [StaticPerform] = []
    static var matcher: Matcher = Matcher.default

    static var staticProperty: String { 
		get { return ProtocolWithStaticMembersMock.__staticProperty.orFail("ProtocolWithStaticMembersMock - value for staticProperty was not defined") }
		set { ProtocolWithStaticMembersMock.__staticProperty = newValue }
	}
	private static var __staticProperty: (String)?

    static func staticMethod(param: Int) throws -> Int {
        addInvocation(.sstaticMethod__param_param(Parameter<Int>.value(param)))
		let perform = methodPerformValue(.sstaticMethod__param_param(Parameter<Int>.value(param))) as? (Int) -> Void
		perform?(param)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.sstaticMethod__param_param(Parameter<Int>.value(param)))
		if let error = givenValue.error { throw error }
		let value = givenValue.value as? Int
		return value.orFail("stub return value not specified for staticMethod(param: Int). Use given")
    }

    fileprivate enum StaticMethodType {
        case sstaticMethod__param_param(Parameter<Int>)

        static func compareParameters(lhs: StaticMethodType, rhs: StaticMethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.sstaticMethod__param_param(let lhsParam), .sstaticMethod__param_param(let rhsParam)): 
                    guard Parameter.compare(lhs: lhsParam, rhs: rhsParam, with: matcher) else { return false } 
                    return true 
            }
        }

        func intValue() -> Int {
            switch self {
                case let .sstaticMethod__param_param(p0): return p0.intValue
            }
        }
    }

    struct StaticGiven {
        fileprivate var method: StaticMethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: StaticMethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

        static func staticMethod(param: Parameter<Int>, willReturn: Int) -> StaticGiven {
            return StaticGiven(method: .sstaticMethod__param_param(param), returns: willReturn, throws: nil)
        }
        static func staticMethod(param: Parameter<Int>, willThrow: Error) -> StaticGiven {
            return StaticGiven(method: .sstaticMethod__param_param(param), returns: nil, throws: willThrow)
        }
    }

    struct StaticVerify {
        fileprivate var method: StaticMethodType

        static func staticMethod(param: Parameter<Int>) -> StaticVerify {
            return StaticVerify(method: .sstaticMethod__param_param(param))
        }
    }

    struct StaticPerform {
        fileprivate var method: StaticMethodType
        var performs: Any

        static func staticMethod(param: Parameter<Int>, perform: (Int) -> Void) -> StaticPerform {
            return StaticPerform(method: .sstaticMethod__param_param(param), performs: perform)
        }
    }

    
    fileprivate struct MethodType {
        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool { return true }
        func intValue() -> Int { return 0 }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

    }

    struct Verify {
        fileprivate var method: MethodType

    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> (value: Any?, error: Error?) {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher)  }
        return (value: matched?.returns, error: matched?.`throws`)
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }

    static public func matchingCalls(_ method: StaticVerify) -> Int {
        return matchingCalls(method.method).count
    }

    static public func given(_ method: StaticGiven) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    static public func perform(_ method: StaticPerform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    static public func verify(_ method: StaticVerify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    static private func addInvocation(_ call: StaticMethodType) {
        invocations.append(call)
    }

    static private func methodReturnValue(_ method: StaticMethodType) -> (value: Any?, error: Error?) {
        let matched = methodReturnValues.reversed().first { StaticMethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher)  }
        return (value: matched?.returns, error: matched?.`throws`)
    }

    static private func methodPerformValue(_ method: StaticMethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { StaticMethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    static private func matchingCalls(_ method: StaticMethodType) -> [StaticMethodType] {
        return invocations.filter { StaticMethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}

// MARK: - ProtocolWithThrowingMethods
class ProtocolWithThrowingMethodsMock: ProtocolWithThrowingMethods, Mock {
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default


    func methodThatThrows() throws {
        addInvocation(.imethodThatThrows)
		let perform = methodPerformValue(.imethodThatThrows) as? () -> Void
		perform?()
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.imethodThatThrows)
		if let error = givenValue.error { throw error }
    }

    func methodThatReturnsAndThrows(param: Int) throws -> Bool {
        addInvocation(.imethodThatReturnsAndThrows__param_param(Parameter<Int>.value(param)))
		let perform = methodPerformValue(.imethodThatReturnsAndThrows__param_param(Parameter<Int>.value(param))) as? (Int) -> Void
		perform?(param)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.imethodThatReturnsAndThrows__param_param(Parameter<Int>.value(param)))
		if let error = givenValue.error { throw error }
		let value = givenValue.value as? Bool
		return value.orFail("stub return value not specified for methodThatReturnsAndThrows(param: Int). Use given")
    }

    fileprivate enum MethodType {
        case imethodThatThrows
        case imethodThatReturnsAndThrows__param_param(Parameter<Int>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.imethodThatThrows, .imethodThatThrows): 
                    return true 
                case (.imethodThatReturnsAndThrows__param_param(let lhsParam), .imethodThatReturnsAndThrows__param_param(let rhsParam)): 
                    guard Parameter.compare(lhs: lhsParam, rhs: rhsParam, with: matcher) else { return false } 
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case .imethodThatThrows: return 0
                case let .imethodThatReturnsAndThrows__param_param(p0): return p0.intValue
            }
        }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

        static func methodThatReturnsAndThrows(param: Parameter<Int>, willReturn: Bool) -> Given {
            return Given(method: .imethodThatReturnsAndThrows__param_param(param), returns: willReturn, throws: nil)
        }
        static func methodThatThrows(willThrow: Error) -> Given {
            return Given(method: .imethodThatThrows, returns: nil, throws: willThrow)
        }
        static func methodThatReturnsAndThrows(param: Parameter<Int>, willThrow: Error) -> Given {
            return Given(method: .imethodThatReturnsAndThrows__param_param(param), returns: nil, throws: willThrow)
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func methodThatThrows() -> Verify {
            return Verify(method: .imethodThatThrows)
        }
        static func methodThatReturnsAndThrows(param: Parameter<Int>) -> Verify {
            return Verify(method: .imethodThatReturnsAndThrows__param_param(param))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func methodThatThrows(perform: () -> Void) -> Perform {
            return Perform(method: .imethodThatThrows, performs: perform)
        }
        static func methodThatReturnsAndThrows(param: Parameter<Int>, perform: (Int) -> Void) -> Perform {
            return Perform(method: .imethodThatReturnsAndThrows__param_param(param), performs: perform)
        }
    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> (value: Any?, error: Error?) {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher)  }
        return (value: matched?.returns, error: matched?.`throws`)
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}

// MARK: - ProtocolWithTuples
class ProtocolWithTuplesMock: ProtocolWithTuples, Mock {
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default


    func methodThatTakesTuple(tuple: (String,Int)) -> Int {
        addInvocation(.imethodThatTakesTuple__tuple_tuple(Parameter<(String,Int)>.value(tuple)))
		let perform = methodPerformValue(.imethodThatTakesTuple__tuple_tuple(Parameter<(String,Int)>.value(tuple))) as? ((String,Int)) -> Void
		perform?(tuple)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.imethodThatTakesTuple__tuple_tuple(Parameter<(String,Int)>.value(tuple)))
		let value = givenValue.value as? Int
		return value.orFail("stub return value not specified for methodThatTakesTuple(tuple: (String,Int)). Use given")
    }

    fileprivate enum MethodType {
        case imethodThatTakesTuple__tuple_tuple(Parameter<(String,Int)>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.imethodThatTakesTuple__tuple_tuple(let lhsTuple), .imethodThatTakesTuple__tuple_tuple(let rhsTuple)): 
                    guard Parameter.compare(lhs: lhsTuple, rhs: rhsTuple, with: matcher) else { return false } 
                    return true 
            }
        }

        func intValue() -> Int {
            switch self {
                case let .imethodThatTakesTuple__tuple_tuple(p0): return p0.intValue
            }
        }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

        static func methodThatTakesTuple(tuple: Parameter<(String,Int)>, willReturn: Int) -> Given {
            return Given(method: .imethodThatTakesTuple__tuple_tuple(tuple), returns: willReturn, throws: nil)
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func methodThatTakesTuple(tuple: Parameter<(String,Int)>) -> Verify {
            return Verify(method: .imethodThatTakesTuple__tuple_tuple(tuple))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func methodThatTakesTuple(tuple: Parameter<(String,Int)>, perform: ((String,Int)) -> Void) -> Perform {
            return Perform(method: .imethodThatTakesTuple__tuple_tuple(tuple), performs: perform)
        }
    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> (value: Any?, error: Error?) {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher)  }
        return (value: matched?.returns, error: matched?.`throws`)
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}

// MARK: - SampleServiceType
class SampleServiceTypeMock: SampleServiceType, Mock {
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default


    func serviceName() -> String {
        addInvocation(.iserviceName)
		let perform = methodPerformValue(.iserviceName) as? () -> Void
		perform?()
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.iserviceName)
		let value = givenValue.value as? String
		return value.orFail("stub return value not specified for serviceName(). Use given")
    }

    func getPoint(from point: Point) -> Point {
        addInvocation(.igetPoint__from_point(Parameter<Point>.value(point)))
		let perform = methodPerformValue(.igetPoint__from_point(Parameter<Point>.value(point))) as? (Point) -> Void
		perform?(point)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.igetPoint__from_point(Parameter<Point>.value(point)))
		let value = givenValue.value as? Point
		return value.orFail("stub return value not specified for getPoint(from point: Point). Use given")
    }

    func getPoint(from tuple: (Float,Float)) -> Point {
        addInvocation(.igetPoint__from_tuple(Parameter<(Float,Float)>.value(tuple)))
		let perform = methodPerformValue(.igetPoint__from_tuple(Parameter<(Float,Float)>.value(tuple))) as? ((Float,Float)) -> Void
		perform?(tuple)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.igetPoint__from_tuple(Parameter<(Float,Float)>.value(tuple)))
		let value = givenValue.value as? Point
		return value.orFail("stub return value not specified for getPoint(from tuple: (Float,Float)). Use given")
    }

    func similarMethodThatDiffersOnType(_ value: Float) -> Bool {
        addInvocation(.isimilarMethodThatDiffersOnType__value_1(Parameter<Float>.value(value)))
		let perform = methodPerformValue(.isimilarMethodThatDiffersOnType__value_1(Parameter<Float>.value(value))) as? (Float) -> Void
		perform?(value)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.isimilarMethodThatDiffersOnType__value_1(Parameter<Float>.value(value)))
		let value = givenValue.value as? Bool
		return value.orFail("stub return value not specified for similarMethodThatDiffersOnType(_ value: Float). Use given")
    }

    func similarMethodThatDiffersOnType(_ value: Point) -> Bool {
        addInvocation(.isimilarMethodThatDiffersOnType__value_2(Parameter<Point>.value(value)))
		let perform = methodPerformValue(.isimilarMethodThatDiffersOnType__value_2(Parameter<Point>.value(value))) as? (Point) -> Void
		perform?(value)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.isimilarMethodThatDiffersOnType__value_2(Parameter<Point>.value(value)))
		let value = givenValue.value as? Bool
		return value.orFail("stub return value not specified for similarMethodThatDiffersOnType(_ value: Point). Use given")
    }

    func methodWithTypedef(_ scalar: Scalar) {
        addInvocation(.imethodWithTypedef__scalar(Parameter<Scalar>.value(scalar)))
		let perform = methodPerformValue(.imethodWithTypedef__scalar(Parameter<Scalar>.value(scalar))) as? (Scalar) -> Void
		perform?(scalar)
    }

    func methodWithClosures(success function: LinearFunction) -> ClosureFabric {
        addInvocation(.imethodWithClosures__success_function_1(Parameter<LinearFunction>.any))
		let perform = methodPerformValue(.imethodWithClosures__success_function_1(Parameter<LinearFunction>.any)) as? (LinearFunction) -> Void
		perform?(function)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.imethodWithClosures__success_function_1(Parameter<LinearFunction>.any))
		let value = givenValue.value as? ClosureFabric
		return value.orFail("stub return value not specified for methodWithClosures(success function: LinearFunction). Use given")
    }

    func methodWithClosures(success function: ((Scalar,Scalar) -> Scalar)?) -> ((Int) -> Void) {
        addInvocation(.imethodWithClosures__success_function_2(Parameter<((Scalar,Scalar) -> Scalar)?>.value(function)))
		let perform = methodPerformValue(.imethodWithClosures__success_function_2(Parameter<((Scalar,Scalar) -> Scalar)?>.value(function))) as? (((Scalar,Scalar) -> Scalar)?) -> Void
		perform?(function)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.imethodWithClosures__success_function_2(Parameter<((Scalar,Scalar) -> Scalar)?>.value(function)))
		let value = givenValue.value as? (Int) -> Void
		return value.orFail("stub return value not specified for methodWithClosures(success function: ((Scalar,Scalar) -> Scalar)?). Use given")
    }

    fileprivate enum MethodType {
        case iserviceName
        case igetPoint__from_point(Parameter<Point>)
        case igetPoint__from_tuple(Parameter<(Float,Float)>)
        case isimilarMethodThatDiffersOnType__value_1(Parameter<Float>)
        case isimilarMethodThatDiffersOnType__value_2(Parameter<Point>)
        case imethodWithTypedef__scalar(Parameter<Scalar>)
        case imethodWithClosures__success_function_1(Parameter<LinearFunction>)
        case imethodWithClosures__success_function_2(Parameter<((Scalar,Scalar) -> Scalar)?>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.iserviceName, .iserviceName): 
                    return true 
                case (.igetPoint__from_point(let lhsPoint), .igetPoint__from_point(let rhsPoint)): 
                    guard Parameter.compare(lhs: lhsPoint, rhs: rhsPoint, with: matcher) else { return false } 
                    return true 
                case (.igetPoint__from_tuple(let lhsTuple), .igetPoint__from_tuple(let rhsTuple)): 
                    guard Parameter.compare(lhs: lhsTuple, rhs: rhsTuple, with: matcher) else { return false } 
                    return true 
                case (.isimilarMethodThatDiffersOnType__value_1(let lhsValue), .isimilarMethodThatDiffersOnType__value_1(let rhsValue)): 
                    guard Parameter.compare(lhs: lhsValue, rhs: rhsValue, with: matcher) else { return false } 
                    return true 
                case (.isimilarMethodThatDiffersOnType__value_2(let lhsValue), .isimilarMethodThatDiffersOnType__value_2(let rhsValue)): 
                    guard Parameter.compare(lhs: lhsValue, rhs: rhsValue, with: matcher) else { return false } 
                    return true 
                case (.imethodWithTypedef__scalar(let lhsScalar), .imethodWithTypedef__scalar(let rhsScalar)): 
                    guard Parameter.compare(lhs: lhsScalar, rhs: rhsScalar, with: matcher) else { return false } 
                    return true 
                case (.imethodWithClosures__success_function_1(let lhsFunction), .imethodWithClosures__success_function_1(let rhsFunction)): 
                    guard Parameter.compare(lhs: lhsFunction, rhs: rhsFunction, with: matcher) else { return false } 
                    return true 
                case (.imethodWithClosures__success_function_2(let lhsFunction), .imethodWithClosures__success_function_2(let rhsFunction)): 
                    guard Parameter.compare(lhs: lhsFunction, rhs: rhsFunction, with: matcher) else { return false } 
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case .iserviceName: return 0
                case let .igetPoint__from_point(p0): return p0.intValue
                case let .igetPoint__from_tuple(p0): return p0.intValue
                case let .isimilarMethodThatDiffersOnType__value_1(p0): return p0.intValue
                case let .isimilarMethodThatDiffersOnType__value_2(p0): return p0.intValue
                case let .imethodWithTypedef__scalar(p0): return p0.intValue
                case let .imethodWithClosures__success_function_1(p0): return p0.intValue
                case let .imethodWithClosures__success_function_2(p0): return p0.intValue
            }
        }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

        static func serviceName(willReturn: String) -> Given {
            return Given(method: .iserviceName, returns: willReturn, throws: nil)
        }
        static func getPoint(from point: Parameter<Point>, willReturn: Point) -> Given {
            return Given(method: .igetPoint__from_point(point), returns: willReturn, throws: nil)
        }
        static func getPoint(from tuple: Parameter<(Float,Float)>, willReturn: Point) -> Given {
            return Given(method: .igetPoint__from_tuple(tuple), returns: willReturn, throws: nil)
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Float>, willReturn: Bool) -> Given {
            return Given(method: .isimilarMethodThatDiffersOnType__value_1(value), returns: willReturn, throws: nil)
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Point>, willReturn: Bool) -> Given {
            return Given(method: .isimilarMethodThatDiffersOnType__value_2(value), returns: willReturn, throws: nil)
        }
        static func methodWithClosures(success function: Parameter<LinearFunction>, willReturn: ClosureFabric) -> Given {
            return Given(method: .imethodWithClosures__success_function_1(function), returns: willReturn, throws: nil)
        }
        static func methodWithClosures(success function: Parameter<((Scalar,Scalar) -> Scalar)?>, willReturn: (Int) -> Void) -> Given {
            return Given(method: .imethodWithClosures__success_function_2(function), returns: willReturn, throws: nil)
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func serviceName() -> Verify {
            return Verify(method: .iserviceName)
        }
        static func getPoint(from point: Parameter<Point>) -> Verify {
            return Verify(method: .igetPoint__from_point(point))
        }
        static func getPoint(from tuple: Parameter<(Float,Float)>) -> Verify {
            return Verify(method: .igetPoint__from_tuple(tuple))
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Float>) -> Verify {
            return Verify(method: .isimilarMethodThatDiffersOnType__value_1(value))
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Point>) -> Verify {
            return Verify(method: .isimilarMethodThatDiffersOnType__value_2(value))
        }
        static func methodWithTypedef(scalar: Parameter<Scalar>) -> Verify {
            return Verify(method: .imethodWithTypedef__scalar(scalar))
        }
        static func methodWithClosures(success function: Parameter<LinearFunction>) -> Verify {
            return Verify(method: .imethodWithClosures__success_function_1(function))
        }
        static func methodWithClosures(success function: Parameter<((Scalar,Scalar) -> Scalar)?>) -> Verify {
            return Verify(method: .imethodWithClosures__success_function_2(function))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func serviceName(perform: () -> Void) -> Perform {
            return Perform(method: .iserviceName, performs: perform)
        }
        static func getPoint(from point: Parameter<Point>, perform: (Point) -> Void) -> Perform {
            return Perform(method: .igetPoint__from_point(point), performs: perform)
        }
        static func getPoint(from tuple: Parameter<(Float,Float)>, perform: ((Float,Float)) -> Void) -> Perform {
            return Perform(method: .igetPoint__from_tuple(tuple), performs: perform)
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Float>, perform: (Float) -> Void) -> Perform {
            return Perform(method: .isimilarMethodThatDiffersOnType__value_1(value), performs: perform)
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Point>, perform: (Point) -> Void) -> Perform {
            return Perform(method: .isimilarMethodThatDiffersOnType__value_2(value), performs: perform)
        }
        static func methodWithTypedef(scalar: Parameter<Scalar>, perform: (Scalar) -> Void) -> Perform {
            return Perform(method: .imethodWithTypedef__scalar(scalar), performs: perform)
        }
        static func methodWithClosures(success function: Parameter<LinearFunction>, perform: (LinearFunction) -> Void) -> Perform {
            return Perform(method: .imethodWithClosures__success_function_1(function), performs: perform)
        }
        static func methodWithClosures(success function: Parameter<((Scalar,Scalar) -> Scalar)?>, perform: (((Scalar,Scalar) -> Scalar)?) -> Void) -> Perform {
            return Perform(method: .imethodWithClosures__success_function_2(function), performs: perform)
        }
    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> (value: Any?, error: Error?) {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher)  }
        return (value: matched?.returns, error: matched?.`throws`)
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}

// MARK: - SimpleProtocolUsingCollections
class SimpleProtocolUsingCollectionsMock: SimpleProtocolUsingCollections, Mock {
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default


    func getArray() -> [Int] {
        addInvocation(.igetArray)
		let perform = methodPerformValue(.igetArray) as? () -> Void
		perform?()
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.igetArray)
		let value = givenValue.value as? [Int]
		return value.orFail("stub return value not specified for getArray(). Use given")
    }

    func map(array: [String], param: Int) -> [Int: String] {
        addInvocation(.imap__array_arrayparam_param(Parameter<[String]>.value(array), Parameter<Int>.value(param)))
		let perform = methodPerformValue(.imap__array_arrayparam_param(Parameter<[String]>.value(array), Parameter<Int>.value(param))) as? ([String], Int) -> Void
		perform?(array, param)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.imap__array_arrayparam_param(Parameter<[String]>.value(array), Parameter<Int>.value(param)))
		let value = givenValue.value as? [Int: String]
		return value.orFail("stub return value not specified for map(array: [String], param: Int). Use given")
    }

    func verify(set: Set<Int>) -> Bool {
        addInvocation(.iverify__set_set(Parameter<Set<Int>>.value(set)))
		let perform = methodPerformValue(.iverify__set_set(Parameter<Set<Int>>.value(set))) as? (Set<Int>) -> Void
		perform?(set)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.iverify__set_set(Parameter<Set<Int>>.value(set)))
		let value = givenValue.value as? Bool
		return value.orFail("stub return value not specified for verify(set: Set<Int>). Use given")
    }

    fileprivate enum MethodType {
        case igetArray
        case imap__array_arrayparam_param(Parameter<[String]>, Parameter<Int>)
        case iverify__set_set(Parameter<Set<Int>>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.igetArray, .igetArray): 
                    return true 
                case (.imap__array_arrayparam_param(let lhsArray, let lhsParam), .imap__array_arrayparam_param(let rhsArray, let rhsParam)): 
                    guard Parameter.compare(lhs: lhsArray, rhs: rhsArray, with: matcher) else { return false } 
                    guard Parameter.compare(lhs: lhsParam, rhs: rhsParam, with: matcher) else { return false } 
                    return true 
                case (.iverify__set_set(let lhsSet), .iverify__set_set(let rhsSet)): 
                    guard Parameter.compare(lhs: lhsSet, rhs: rhsSet, with: matcher) else { return false } 
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case .igetArray: return 0
                case let .imap__array_arrayparam_param(p0, p1): return p0.intValue + p1.intValue
                case let .iverify__set_set(p0): return p0.intValue
            }
        }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

        static func getArray(willReturn: [Int]) -> Given {
            return Given(method: .igetArray, returns: willReturn, throws: nil)
        }
        static func map(array: Parameter<[String]>, param: Parameter<Int>, willReturn: [Int: String]) -> Given {
            return Given(method: .imap__array_arrayparam_param(array, param), returns: willReturn, throws: nil)
        }
        static func verify(set: Parameter<Set<Int>>, willReturn: Bool) -> Given {
            return Given(method: .iverify__set_set(set), returns: willReturn, throws: nil)
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func getArray() -> Verify {
            return Verify(method: .igetArray)
        }
        static func map(array: Parameter<[String]>, param: Parameter<Int>) -> Verify {
            return Verify(method: .imap__array_arrayparam_param(array, param))
        }
        static func verify(set: Parameter<Set<Int>>) -> Verify {
            return Verify(method: .iverify__set_set(set))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func getArray(perform: () -> Void) -> Perform {
            return Perform(method: .igetArray, performs: perform)
        }
        static func map(array: Parameter<[String]>, param: Parameter<Int>, perform: ([String], Int) -> Void) -> Perform {
            return Perform(method: .imap__array_arrayparam_param(array, param), performs: perform)
        }
        static func verify(set: Parameter<Set<Int>>, perform: (Set<Int>) -> Void) -> Perform {
            return Perform(method: .iverify__set_set(set), performs: perform)
        }
    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> (value: Any?, error: Error?) {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher)  }
        return (value: matched?.returns, error: matched?.`throws`)
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}

// MARK: - SimpleProtocolWithBothMethodsAndProperties
class SimpleProtocolWithBothMethodsAndPropertiesMock: SimpleProtocolWithBothMethodsAndProperties, Mock {
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default

    var property: String { 
		get { return __property.orFail("SimpleProtocolWithBothMethodsAndPropertiesMock - value for property was not defined") }
		set { __property = newValue }
	}
	private var __property: (String)?

    func simpleMethod() -> String {
        addInvocation(.isimpleMethod)
		let perform = methodPerformValue(.isimpleMethod) as? () -> Void
		perform?()
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.isimpleMethod)
		let value = givenValue.value as? String
		return value.orFail("stub return value not specified for simpleMethod(). Use given")
    }

    fileprivate enum MethodType {
        case isimpleMethod

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.isimpleMethod, .isimpleMethod): 
                    return true 
            }
        }

        func intValue() -> Int {
            switch self {
                case .isimpleMethod: return 0
            }
        }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

        static func simpleMethod(willReturn: String) -> Given {
            return Given(method: .isimpleMethod, returns: willReturn, throws: nil)
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func simpleMethod() -> Verify {
            return Verify(method: .isimpleMethod)
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func simpleMethod(perform: () -> Void) -> Perform {
            return Perform(method: .isimpleMethod, performs: perform)
        }
    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> (value: Any?, error: Error?) {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher)  }
        return (value: matched?.returns, error: matched?.`throws`)
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}

// MARK: - SimpleProtocolWithMethods
class SimpleProtocolWithMethodsMock: SimpleProtocolWithMethods, Mock {
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default


    func simpleMethod() {
        addInvocation(.isimpleMethod)
		let perform = methodPerformValue(.isimpleMethod) as? () -> Void
		perform?()
    }

    func simpleMehtodThatReturns() -> Int {
        addInvocation(.isimpleMehtodThatReturns)
		let perform = methodPerformValue(.isimpleMehtodThatReturns) as? () -> Void
		perform?()
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.isimpleMehtodThatReturns)
		let value = givenValue.value as? Int
		return value.orFail("stub return value not specified for simpleMehtodThatReturns(). Use given")
    }

    func simpleMehtodThatReturns(param: String) -> String {
        addInvocation(.isimpleMehtodThatReturns__param_param(Parameter<String>.value(param)))
		let perform = methodPerformValue(.isimpleMehtodThatReturns__param_param(Parameter<String>.value(param))) as? (String) -> Void
		perform?(param)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.isimpleMehtodThatReturns__param_param(Parameter<String>.value(param)))
		let value = givenValue.value as? String
		return value.orFail("stub return value not specified for simpleMehtodThatReturns(param: String). Use given")
    }

    func simpleMehtodThatReturns(optionalParam: String?) -> String? {
        addInvocation(.isimpleMehtodThatReturns__optionalParam_optionalParam(Parameter<String?>.value(optionalParam)))
		let perform = methodPerformValue(.isimpleMehtodThatReturns__optionalParam_optionalParam(Parameter<String?>.value(optionalParam))) as? (String?) -> Void
		perform?(optionalParam)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.isimpleMehtodThatReturns__optionalParam_optionalParam(Parameter<String?>.value(optionalParam)))
		let value = givenValue.value as? String?
		return value.orFail("stub return value not specified for simpleMehtodThatReturns(optionalParam: String?). Use given")
    }

    fileprivate enum MethodType {
        case isimpleMethod
        case isimpleMehtodThatReturns
        case isimpleMehtodThatReturns__param_param(Parameter<String>)
        case isimpleMehtodThatReturns__optionalParam_optionalParam(Parameter<String?>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.isimpleMethod, .isimpleMethod): 
                    return true 
                case (.isimpleMehtodThatReturns, .isimpleMehtodThatReturns): 
                    return true 
                case (.isimpleMehtodThatReturns__param_param(let lhsParam), .isimpleMehtodThatReturns__param_param(let rhsParam)): 
                    guard Parameter.compare(lhs: lhsParam, rhs: rhsParam, with: matcher) else { return false } 
                    return true 
                case (.isimpleMehtodThatReturns__optionalParam_optionalParam(let lhsOptionalparam), .isimpleMehtodThatReturns__optionalParam_optionalParam(let rhsOptionalparam)): 
                    guard Parameter.compare(lhs: lhsOptionalparam, rhs: rhsOptionalparam, with: matcher) else { return false } 
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case .isimpleMethod: return 0
                case .isimpleMehtodThatReturns: return 0
                case let .isimpleMehtodThatReturns__param_param(p0): return p0.intValue
                case let .isimpleMehtodThatReturns__optionalParam_optionalParam(p0): return p0.intValue
            }
        }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

        static func simpleMehtodThatReturns(willReturn: Int) -> Given {
            return Given(method: .isimpleMehtodThatReturns, returns: willReturn, throws: nil)
        }
        static func simpleMehtodThatReturns(param: Parameter<String>, willReturn: String) -> Given {
            return Given(method: .isimpleMehtodThatReturns__param_param(param), returns: willReturn, throws: nil)
        }
        static func simpleMehtodThatReturns(optionalParam: Parameter<String?>, willReturn: String?) -> Given {
            return Given(method: .isimpleMehtodThatReturns__optionalParam_optionalParam(optionalParam), returns: willReturn, throws: nil)
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func simpleMethod() -> Verify {
            return Verify(method: .isimpleMethod)
        }
        static func simpleMehtodThatReturns() -> Verify {
            return Verify(method: .isimpleMehtodThatReturns)
        }
        static func simpleMehtodThatReturns(param: Parameter<String>) -> Verify {
            return Verify(method: .isimpleMehtodThatReturns__param_param(param))
        }
        static func simpleMehtodThatReturns(optionalParam: Parameter<String?>) -> Verify {
            return Verify(method: .isimpleMehtodThatReturns__optionalParam_optionalParam(optionalParam))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func simpleMethod(perform: () -> Void) -> Perform {
            return Perform(method: .isimpleMethod, performs: perform)
        }
        static func simpleMehtodThatReturns(perform: () -> Void) -> Perform {
            return Perform(method: .isimpleMehtodThatReturns, performs: perform)
        }
        static func simpleMehtodThatReturns(param: Parameter<String>, perform: (String) -> Void) -> Perform {
            return Perform(method: .isimpleMehtodThatReturns__param_param(param), performs: perform)
        }
        static func simpleMehtodThatReturns(optionalParam: Parameter<String?>, perform: (String?) -> Void) -> Perform {
            return Perform(method: .isimpleMehtodThatReturns__optionalParam_optionalParam(optionalParam), performs: perform)
        }
    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> (value: Any?, error: Error?) {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher)  }
        return (value: matched?.returns, error: matched?.`throws`)
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}

// MARK: - SimpleProtocolWithProperties
class SimpleProtocolWithPropertiesMock: SimpleProtocolWithProperties, Mock {
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default

    var property: String { 
		get { return __property.orFail("SimpleProtocolWithPropertiesMock - value for property was not defined") }
		set { __property = newValue }
	}
	private var __property: (String)?
    var weakProperty: AnyObject! { 
		get { return __weakProperty.orFail("SimpleProtocolWithPropertiesMock - value for weakProperty was not defined") }
		set { __weakProperty = newValue }
	}
	private var __weakProperty: (AnyObject)?
    var propertyGetOnly: String { 
		get { return __propertyGetOnly.orFail("SimpleProtocolWithPropertiesMock - value for propertyGetOnly was not defined") }
		set { __propertyGetOnly = newValue }
	}
	private var __propertyGetOnly: (String)?
    var propertyOptional: Int? { 
		get { return __propertyOptional }
		set { __propertyOptional = newValue }
	}
	private var __propertyOptional: (Int)?
    var propertyImplicit: Int! { 
		get { return __propertyImplicit.orFail("SimpleProtocolWithPropertiesMock - value for propertyImplicit was not defined") }
		set { __propertyImplicit = newValue }
	}
	private var __propertyImplicit: (Int)?


    fileprivate struct MethodType {
        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool { return true }
        func intValue() -> Int { return 0 }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

    }

    struct Verify {
        fileprivate var method: MethodType

    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> (value: Any?, error: Error?) {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher)  }
        return (value: matched?.returns, error: matched?.`throws`)
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}

// MARK: - UserNetworkType
class UserNetworkTypeMock: UserNetworkType, Mock {
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default


    required init(config: NetworkConfig) { }

    required init(baseUrl: String) { }

    func getUser(for id: String, completion: (User?) -> Void) {
        addInvocation(.igetUser__for_idcompletion_completion(Parameter<String>.value(id), Parameter<(User?) -> Void>.any))
		let perform = methodPerformValue(.igetUser__for_idcompletion_completion(Parameter<String>.value(id), Parameter<(User?) -> Void>.any)) as? (String, (User?) -> Void) -> Void
		perform?(id, completion)
    }

    func getUserEscaping(for id: String, completion: @escaping (User?,Error?) -> Void) {
        addInvocation(.igetUserEscaping__for_idcompletion_completion(Parameter<String>.value(id), Parameter<(User?,Error?) -> Void>.value(completion)))
		let perform = methodPerformValue(.igetUserEscaping__for_idcompletion_completion(Parameter<String>.value(id), Parameter<(User?,Error?) -> Void>.value(completion))) as? (String, @escaping (User?,Error?) -> Void) -> Void
		perform?(id, completion)
    }

    func doSomething(prop: @autoclosure () -> String) {
        addInvocation(.idoSomething__prop_prop(Parameter<() -> String>.any))
		let perform = methodPerformValue(.idoSomething__prop_prop(Parameter<() -> String>.any)) as? (@autoclosure () -> String) -> Void
		perform?(prop)
    }

    func testDefaultValues(value: String) {
        addInvocation(.itestDefaultValues__value_value(Parameter<String>.value(value)))
		let perform = methodPerformValue(.itestDefaultValues__value_value(Parameter<String>.value(value))) as? (String) -> Void
		perform?(value)
    }

    fileprivate enum MethodType {
        case igetUser__for_idcompletion_completion(Parameter<String>, Parameter<(User?) -> Void>)
        case igetUserEscaping__for_idcompletion_completion(Parameter<String>, Parameter<(User?,Error?) -> Void>)
        case idoSomething__prop_prop(Parameter<() -> String>)
        case itestDefaultValues__value_value(Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.igetUser__for_idcompletion_completion(let lhsId, let lhsCompletion), .igetUser__for_idcompletion_completion(let rhsId, let rhsCompletion)): 
                    guard Parameter.compare(lhs: lhsId, rhs: rhsId, with: matcher) else { return false } 
                    guard Parameter.compare(lhs: lhsCompletion, rhs: rhsCompletion, with: matcher) else { return false } 
                    return true 
                case (.igetUserEscaping__for_idcompletion_completion(let lhsId, let lhsCompletion), .igetUserEscaping__for_idcompletion_completion(let rhsId, let rhsCompletion)): 
                    guard Parameter.compare(lhs: lhsId, rhs: rhsId, with: matcher) else { return false } 
                    guard Parameter.compare(lhs: lhsCompletion, rhs: rhsCompletion, with: matcher) else { return false } 
                    return true 
                case (.idoSomething__prop_prop(let lhsProp), .idoSomething__prop_prop(let rhsProp)): 
                    guard Parameter.compare(lhs: lhsProp, rhs: rhsProp, with: matcher) else { return false } 
                    return true 
                case (.itestDefaultValues__value_value(let lhsValue), .itestDefaultValues__value_value(let rhsValue)): 
                    guard Parameter.compare(lhs: lhsValue, rhs: rhsValue, with: matcher) else { return false } 
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case let .igetUser__for_idcompletion_completion(p0, p1): return p0.intValue + p1.intValue
                case let .igetUserEscaping__for_idcompletion_completion(p0, p1): return p0.intValue + p1.intValue
                case let .idoSomething__prop_prop(p0): return p0.intValue
                case let .itestDefaultValues__value_value(p0): return p0.intValue
            }
        }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

    }

    struct Verify {
        fileprivate var method: MethodType

        static func getUser(for id: Parameter<String>, completion: Parameter<(User?) -> Void>) -> Verify {
            return Verify(method: .igetUser__for_idcompletion_completion(id, completion))
        }
        static func getUserEscaping(for id: Parameter<String>, completion: Parameter<(User?,Error?) -> Void>) -> Verify {
            return Verify(method: .igetUserEscaping__for_idcompletion_completion(id, completion))
        }
        static func doSomething(prop: Parameter<() -> String>) -> Verify {
            return Verify(method: .idoSomething__prop_prop(prop))
        }
        static func testDefaultValues(value: Parameter<String>) -> Verify {
            return Verify(method: .itestDefaultValues__value_value(value))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func getUser(for id: Parameter<String>, completion: Parameter<(User?) -> Void>, perform: (String, (User?) -> Void) -> Void) -> Perform {
            return Perform(method: .igetUser__for_idcompletion_completion(id, completion), performs: perform)
        }
        static func getUserEscaping(for id: Parameter<String>, completion: Parameter<(User?,Error?) -> Void>, perform: (String, @escaping (User?,Error?) -> Void) -> Void) -> Perform {
            return Perform(method: .igetUserEscaping__for_idcompletion_completion(id, completion), performs: perform)
        }
        static func doSomething(prop: Parameter<() -> String>, perform: (@autoclosure () -> String) -> Void) -> Perform {
            return Perform(method: .idoSomething__prop_prop(prop), performs: perform)
        }
        static func testDefaultValues(value: Parameter<String>, perform: (String) -> Void) -> Perform {
            return Perform(method: .itestDefaultValues__value_value(value), performs: perform)
        }
    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> (value: Any?, error: Error?) {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher)  }
        return (value: matched?.returns, error: matched?.`throws`)
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}

// MARK: - UserStorageType
class UserStorageTypeMock: UserStorageType, Mock {
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default


    func surname(for name: String) -> String {
        addInvocation(.isurname__for_name(Parameter<String>.value(name)))
		let perform = methodPerformValue(.isurname__for_name(Parameter<String>.value(name))) as? (String) -> Void
		perform?(name)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.isurname__for_name(Parameter<String>.value(name)))
		let value = givenValue.value as? String
		return value.orFail("stub return value not specified for surname(for name: String). Use given")
    }

    func storeUser(name: String, surname: String) {
        addInvocation(.istoreUser__name_namesurname_surname(Parameter<String>.value(name), Parameter<String>.value(surname)))
		let perform = methodPerformValue(.istoreUser__name_namesurname_surname(Parameter<String>.value(name), Parameter<String>.value(surname))) as? (String, String) -> Void
		perform?(name, surname)
    }

    fileprivate enum MethodType {
        case isurname__for_name(Parameter<String>)
        case istoreUser__name_namesurname_surname(Parameter<String>, Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.isurname__for_name(let lhsName), .isurname__for_name(let rhsName)): 
                    guard Parameter.compare(lhs: lhsName, rhs: rhsName, with: matcher) else { return false } 
                    return true 
                case (.istoreUser__name_namesurname_surname(let lhsName, let lhsSurname), .istoreUser__name_namesurname_surname(let rhsName, let rhsSurname)): 
                    guard Parameter.compare(lhs: lhsName, rhs: rhsName, with: matcher) else { return false } 
                    guard Parameter.compare(lhs: lhsSurname, rhs: rhsSurname, with: matcher) else { return false } 
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case let .isurname__for_name(p0): return p0.intValue
                case let .istoreUser__name_namesurname_surname(p0, p1): return p0.intValue + p1.intValue
            }
        }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

        static func surname(for name: Parameter<String>, willReturn: String) -> Given {
            return Given(method: .isurname__for_name(name), returns: willReturn, throws: nil)
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func surname(for name: Parameter<String>) -> Verify {
            return Verify(method: .isurname__for_name(name))
        }
        static func storeUser(name: Parameter<String>, surname: Parameter<String>) -> Verify {
            return Verify(method: .istoreUser__name_namesurname_surname(name, surname))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func surname(for name: Parameter<String>, perform: (String) -> Void) -> Perform {
            return Perform(method: .isurname__for_name(name), performs: perform)
        }
        static func storeUser(name: Parameter<String>, surname: Parameter<String>, perform: (String, String) -> Void) -> Perform {
            return Perform(method: .istoreUser__name_namesurname_surname(name, surname), performs: perform)
        }
    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> (value: Any?, error: Error?) {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher)  }
        return (value: matched?.returns, error: matched?.`throws`)
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}

