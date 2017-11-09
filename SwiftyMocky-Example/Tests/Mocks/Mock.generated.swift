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
		get { return __optionalClosure.orFail("AMassiveTestProtocolMock - value for optionalClosure was not defined") }
		set { __optionalClosure = newValue }
	}
	private var __optionalClosure: (() -> Int)?
    var implicitelyUnwrappedClosure: (() -> Void)! { 
		get { return __implicitelyUnwrappedClosure.orFail("AMassiveTestProtocolMock - value for implicitelyUnwrappedClosure was not defined") }
		set { __implicitelyUnwrappedClosure = newValue }
	}
	private var __implicitelyUnwrappedClosure: (() -> Void)?
    static var optionalClosure: (() -> Int)? { 
		get { return AMassiveTestProtocolMock.__optionalClosure.orFail("AMassiveTestProtocolMock - value for optionalClosure was not defined") }
		set { AMassiveTestProtocolMock.__optionalClosure = newValue }
	}
	private static var __optionalClosure: (() -> Int)?

    static func methodThatThrows() throws {
        addInvocation(.smethodThatThrows)
		let perform = methodPerformValue(.smethodThatThrows) as? () -> Void
		perform?()
		if let error = methodThrowValue(.smethodThatThrows) { throw error }
    }

    static func methodThatReturnsAndThrows(param: String) throws -> Int {
        addInvocation(.smethodThatReturnsAndThrows__param_param(.value(param)))
		let perform = methodPerformValue(.smethodThatReturnsAndThrows__param_param(.value(param))) as? (String) -> Void
		perform?(param)
		if let error = methodThrowValue(.smethodThatReturnsAndThrows__param_param(.value(param))) { throw error }
		let value = methodReturnValue(.smethodThatReturnsAndThrows__param_param(.value(param))) as? Int
		return value.orFail("stub return value not specified for methodThatReturnsAndThrows(param: String). Use given")
    }

    static func methodThatRethrows(param: (String) throws -> Int) rethrows -> Int {
        addInvocation(.smethodThatRethrows__param_param(Parameter<(String) throws -> Int>.any))
		let perform = methodPerformValue(.smethodThatRethrows__param_param(Parameter<(String) throws -> Int>.any)) as? ((String) throws -> Int) -> Void
		perform?(param)
		let value = methodReturnValue(.smethodThatRethrows__param_param(Parameter<(String) throws -> Int>.any)) as? Int
		return value.orFail("stub return value not specified for methodThatRethrows(param: (String) throws -> Int). Use given")
    }

    required init() { }

    required init(_ sth: Int) { }

    func methodThatThrows() throws {
        addInvocation(.imethodThatThrows)
		let perform = methodPerformValue(.imethodThatThrows) as? () -> Void
		perform?()
		if let error = methodThrowValue(.imethodThatThrows) { throw error }
    }

    func methodThatReturnsAndThrows(param: String) throws -> Int {
        addInvocation(.imethodThatReturnsAndThrows__param_param(.value(param)))
		let perform = methodPerformValue(.imethodThatReturnsAndThrows__param_param(.value(param))) as? (String) -> Void
		perform?(param)
		if let error = methodThrowValue(.imethodThatReturnsAndThrows__param_param(.value(param))) { throw error }
		let value = methodReturnValue(.imethodThatReturnsAndThrows__param_param(.value(param))) as? Int
		return value.orFail("stub return value not specified for methodThatReturnsAndThrows(param: String). Use given")
    }

    func methodThatRethrows(param: (String) throws -> Int) rethrows -> Int {
        addInvocation(.imethodThatRethrows__param_param(Parameter<(String) throws -> Int>.any))
		let perform = methodPerformValue(.imethodThatRethrows__param_param(Parameter<(String) throws -> Int>.any)) as? ((String) throws -> Int) -> Void
		perform?(param)
		let value = methodReturnValue(.imethodThatRethrows__param_param(Parameter<(String) throws -> Int>.any)) as? Int
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

    private func methodReturnValue(_ method: MethodType) -> Any? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.returns != nil  }
        return matched?.returns
    }

    private func methodThrowValue(_ method: MethodType) -> Error? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.`throws` != nil  }
        return matched?.`throws`
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

    static private func methodReturnValue(_ method: StaticMethodType) -> Any? {
        let matched = methodReturnValues.reversed().first { StaticMethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.returns != nil  }
        return matched?.returns
    }

    static private func methodThrowValue(_ method: StaticMethodType) -> Error? {
        let matched = methodReturnValues.reversed().first { StaticMethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.`throws` != nil  }
        return matched?.`throws`
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
		let value = methodReturnValue(.iserviceName) as? String
		return value.orFail("stub return value not specified for serviceName(). Use given")
    }

    func aNewWayToSayHooray() {
        addInvocation(.iaNewWayToSayHooray)
		let perform = methodPerformValue(.iaNewWayToSayHooray) as? () -> Void
		perform?()
    }

    func getPoint(from point: Point) -> Point {
        addInvocation(.igetPoint__from_point(.value(point)))
		let perform = methodPerformValue(.igetPoint__from_point(.value(point))) as? (Point) -> Void
		perform?(point)
		let value = methodReturnValue(.igetPoint__from_point(.value(point))) as? Point
		return value.orFail("stub return value not specified for getPoint(from point: Point). Use given")
    }

    func getPoint(from tuple: (Float,Float)) -> Point {
        addInvocation(.igetPoint__from_tuple(.value(tuple)))
		let perform = methodPerformValue(.igetPoint__from_tuple(.value(tuple))) as? ((Float,Float)) -> Void
		perform?(tuple)
		let value = methodReturnValue(.igetPoint__from_tuple(.value(tuple))) as? Point
		return value.orFail("stub return value not specified for getPoint(from tuple: (Float,Float)). Use given")
    }

    func similarMethodThatDiffersOnType(_ value: Float) -> Bool {
        addInvocation(.isimilarMethodThatDiffersOnType__value_1(.value(value)))
		let perform = methodPerformValue(.isimilarMethodThatDiffersOnType__value_1(.value(value))) as? (Float) -> Void
		perform?(value)
		let value = methodReturnValue(.isimilarMethodThatDiffersOnType__value_1(.value(value))) as? Bool
		return value.orFail("stub return value not specified for similarMethodThatDiffersOnType(_ value: Float). Use given")
    }

    func similarMethodThatDiffersOnType(_ value: Point) -> Bool {
        addInvocation(.isimilarMethodThatDiffersOnType__value_2(.value(value)))
		let perform = methodPerformValue(.isimilarMethodThatDiffersOnType__value_2(.value(value))) as? (Point) -> Void
		perform?(value)
		let value = methodReturnValue(.isimilarMethodThatDiffersOnType__value_2(.value(value))) as? Bool
		return value.orFail("stub return value not specified for similarMethodThatDiffersOnType(_ value: Point). Use given")
    }

    func methodWithTypedef(_ scalar: Scalar) {
        addInvocation(.imethodWithTypedef__scalar(.value(scalar)))
		let perform = methodPerformValue(.imethodWithTypedef__scalar(.value(scalar))) as? (Scalar) -> Void
		perform?(scalar)
    }

    func methodWithClosures(success function: LinearFunction) -> ClosureFabric {
        addInvocation(.imethodWithClosures__success_function_1(Parameter<LinearFunction>.any))
		let perform = methodPerformValue(.imethodWithClosures__success_function_1(Parameter<LinearFunction>.any)) as? (LinearFunction) -> Void
		perform?(function)
		let value = methodReturnValue(.imethodWithClosures__success_function_1(Parameter<LinearFunction>.any)) as? ClosureFabric
		return value.orFail("stub return value not specified for methodWithClosures(success function: LinearFunction). Use given")
    }

    func methodWithClosures(success function: ((Scalar,Scalar) -> Scalar)?) -> ((Int) -> Void) {
        addInvocation(.imethodWithClosures__success_function_2(.value(function)))
		let perform = methodPerformValue(.imethodWithClosures__success_function_2(.value(function))) as? (((Scalar,Scalar) -> Scalar)?) -> Void
		perform?(function)
		let value = methodReturnValue(.imethodWithClosures__success_function_2(.value(function))) as? ((Int) -> Void)
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
        static func methodWithClosures(success function: Parameter<((Scalar,Scalar) -> Scalar)?>, willReturn: ((Int) -> Void)) -> Given {
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

    private func methodReturnValue(_ method: MethodType) -> Any? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.returns != nil  }
        return matched?.returns
    }

    private func methodThrowValue(_ method: MethodType) -> Error? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.`throws` != nil  }
        return matched?.`throws`
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

    private func methodReturnValue(_ method: MethodType) -> Any? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.returns != nil  }
        return matched?.returns
    }

    private func methodThrowValue(_ method: MethodType) -> Error? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.`throws` != nil  }
        return matched?.`throws`
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

    private func methodReturnValue(_ method: MethodType) -> Any? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.returns != nil  }
        return matched?.returns
    }

    private func methodThrowValue(_ method: MethodType) -> Error? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.`throws` != nil  }
        return matched?.`throws`
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
		let value = methodReturnValue(.iserviceName) as? String
		return value.orFail("stub return value not specified for serviceName(). Use given")
    }

    func getPoint(from point: Point) -> Point {
        addInvocation(.igetPoint__from_point(.value(point)))
		let perform = methodPerformValue(.igetPoint__from_point(.value(point))) as? (Point) -> Void
		perform?(point)
		let value = methodReturnValue(.igetPoint__from_point(.value(point))) as? Point
		return value.orFail("stub return value not specified for getPoint(from point: Point). Use given")
    }

    func getPoint(from tuple: (Float,Float)) -> Point {
        addInvocation(.igetPoint__from_tuple(.value(tuple)))
		let perform = methodPerformValue(.igetPoint__from_tuple(.value(tuple))) as? ((Float,Float)) -> Void
		perform?(tuple)
		let value = methodReturnValue(.igetPoint__from_tuple(.value(tuple))) as? Point
		return value.orFail("stub return value not specified for getPoint(from tuple: (Float,Float)). Use given")
    }

    func similarMethodThatDiffersOnType(_ value: Float) -> Bool {
        addInvocation(.isimilarMethodThatDiffersOnType__value_1(.value(value)))
		let perform = methodPerformValue(.isimilarMethodThatDiffersOnType__value_1(.value(value))) as? (Float) -> Void
		perform?(value)
		let value = methodReturnValue(.isimilarMethodThatDiffersOnType__value_1(.value(value))) as? Bool
		return value.orFail("stub return value not specified for similarMethodThatDiffersOnType(_ value: Float). Use given")
    }

    func similarMethodThatDiffersOnType(_ value: Point) -> Bool {
        addInvocation(.isimilarMethodThatDiffersOnType__value_2(.value(value)))
		let perform = methodPerformValue(.isimilarMethodThatDiffersOnType__value_2(.value(value))) as? (Point) -> Void
		perform?(value)
		let value = methodReturnValue(.isimilarMethodThatDiffersOnType__value_2(.value(value))) as? Bool
		return value.orFail("stub return value not specified for similarMethodThatDiffersOnType(_ value: Point). Use given")
    }

    func methodWithTypedef(_ scalar: Scalar) {
        addInvocation(.imethodWithTypedef__scalar(.value(scalar)))
		let perform = methodPerformValue(.imethodWithTypedef__scalar(.value(scalar))) as? (Scalar) -> Void
		perform?(scalar)
    }

    func methodWithClosures(success function: LinearFunction) -> ClosureFabric {
        addInvocation(.imethodWithClosures__success_function_1(Parameter<LinearFunction>.any))
		let perform = methodPerformValue(.imethodWithClosures__success_function_1(Parameter<LinearFunction>.any)) as? (LinearFunction) -> Void
		perform?(function)
		let value = methodReturnValue(.imethodWithClosures__success_function_1(Parameter<LinearFunction>.any)) as? ClosureFabric
		return value.orFail("stub return value not specified for methodWithClosures(success function: LinearFunction). Use given")
    }

    func methodWithClosures(success function: ((Scalar,Scalar) -> Scalar)?) -> ((Int) -> Void) {
        addInvocation(.imethodWithClosures__success_function_2(.value(function)))
		let perform = methodPerformValue(.imethodWithClosures__success_function_2(.value(function))) as? (((Scalar,Scalar) -> Scalar)?) -> Void
		perform?(function)
		let value = methodReturnValue(.imethodWithClosures__success_function_2(.value(function))) as? ((Int) -> Void)
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
        static func methodWithClosures(success function: Parameter<((Scalar,Scalar) -> Scalar)?>, willReturn: ((Int) -> Void)) -> Given {
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

    private func methodReturnValue(_ method: MethodType) -> Any? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.returns != nil  }
        return matched?.returns
    }

    private func methodThrowValue(_ method: MethodType) -> Error? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.`throws` != nil  }
        return matched?.`throws`
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
        addInvocation(.igetUser__for_idcompletion_completion(.value(id), Parameter<(User?) -> Void>.any))
		let perform = methodPerformValue(.igetUser__for_idcompletion_completion(.value(id), Parameter<(User?) -> Void>.any)) as? (String, (User?) -> Void) -> Void
		perform?(id, completion)
    }

    func getUserEscaping(for id: String, completion: @escaping (User?,Error?) -> Void) {
        addInvocation(.igetUserEscaping__for_idcompletion_completion(.value(id), .value(completion)))
		let perform = methodPerformValue(.igetUserEscaping__for_idcompletion_completion(.value(id), .value(completion))) as? (String, @escaping (User?,Error?) -> Void) -> Void
		perform?(id, completion)
    }

    func doSomething(prop: @autoclosure () -> String) {
        addInvocation(.idoSomething__prop_prop(Parameter< () -> String>.any))
		let perform = methodPerformValue(.idoSomething__prop_prop(Parameter< () -> String>.any)) as? (@autoclosure () -> String) -> Void
		perform?(prop)
    }

    func testDefaultValues(value: String) {
        addInvocation(.itestDefaultValues__value_value(.value(value)))
		let perform = methodPerformValue(.itestDefaultValues__value_value(.value(value))) as? (String) -> Void
		perform?(value)
    }

    fileprivate enum MethodType {
        case igetUser__for_idcompletion_completion(Parameter<String>, Parameter<(User?) -> Void>)
        case igetUserEscaping__for_idcompletion_completion(Parameter<String>, Parameter< (User?,Error?) -> Void>)
        case idoSomething__prop_prop(Parameter< () -> String>)
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
        static func getUserEscaping(for id: Parameter<String>, completion: Parameter< (User?,Error?) -> Void>) -> Verify {
            return Verify(method: .igetUserEscaping__for_idcompletion_completion(id, completion))
        }
        static func doSomething(prop: Parameter< () -> String>) -> Verify {
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
        static func getUserEscaping(for id: Parameter<String>, completion: Parameter< (User?,Error?) -> Void>, perform: (String, @escaping (User?,Error?) -> Void) -> Void) -> Perform {
            return Perform(method: .igetUserEscaping__for_idcompletion_completion(id, completion), performs: perform)
        }
        static func doSomething(prop: Parameter< () -> String>, perform: (@autoclosure () -> String) -> Void) -> Perform {
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

    private func methodReturnValue(_ method: MethodType) -> Any? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.returns != nil  }
        return matched?.returns
    }

    private func methodThrowValue(_ method: MethodType) -> Error? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.`throws` != nil  }
        return matched?.`throws`
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
        addInvocation(.isurname__for_name(.value(name)))
		let perform = methodPerformValue(.isurname__for_name(.value(name))) as? (String) -> Void
		perform?(name)
		let value = methodReturnValue(.isurname__for_name(.value(name))) as? String
		return value.orFail("stub return value not specified for surname(for name: String). Use given")
    }

    func storeUser(name: String, surname: String) {
        addInvocation(.istoreUser__name_namesurname_surname(.value(name), .value(surname)))
		let perform = methodPerformValue(.istoreUser__name_namesurname_surname(.value(name), .value(surname))) as? (String, String) -> Void
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

    private func methodReturnValue(_ method: MethodType) -> Any? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.returns != nil  }
        return matched?.returns
    }

    private func methodThrowValue(_ method: MethodType) -> Error? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.`throws` != nil  }
        return matched?.`throws`
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}

