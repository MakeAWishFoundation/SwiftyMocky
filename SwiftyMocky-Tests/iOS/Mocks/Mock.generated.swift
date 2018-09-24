// Generated using Sourcery 0.14.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


//swiftlint:disable force_cast
//swiftlint:disable function_body_length
//swiftlint:disable line_length
//swiftlint:disable vertical_whitespace

#if MockyCustom
import SwiftyMocky
@testable import Mocky_Example_iOS

    public final class MockyAssertion {
        public static var handler: ((Bool, String, StaticString, UInt) -> Void)?
    }

    func MockyAssert(_ expression: @autoclosure () -> Bool, _ message: @autoclosure () -> String = "Verification failed", file: StaticString = #file, line: UInt = #line) {
        guard let handler = MockyAssertion.handler else {
            assert(expression, message, file: file, line: line)
            return
        }

        handler(expression(), message(), file, line)
    }
#elseif Mocky
import SwiftyMocky
import XCTest
@testable import Mocky_Example_iOS

    func MockyAssert(_ expression: @autoclosure () -> Bool, _ message: @autoclosure () -> String = "Verification failed", file: StaticString = #file, line: UInt = #line) {
        XCTAssert(expression(), message(), file: file, line: line)
    }
#else
import Sourcery
import SourceryRuntime
#endif

// MARK: - AMassiveTestProtocol
class AMassiveTestProtocolMock: AMassiveTestProtocol, Mock, StaticMock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
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

    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyTestCase.onFatalFailure() // Prepare running test case that it should not continue
        XCTFail(message, file: file, line: line)
        #endif
    }

    static var matcher: Matcher = Matcher.default
    static var stubbingPolicy: StubbingPolicy = .wrap
    static var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    static private var invocations: [StaticMethodType] = []
    static private var methodReturnValues: [StaticGiven] = []
    static private var methodPerformValues: [StaticPerform] = []
    static func clear() {
        invocations = []
        methodReturnValues = []
        methodPerformValues = []
    }

    var nonOptionalClosure: () -> Void { 
		get {	invocations.append(.nonOptionalClosure_get)
				return __nonOptionalClosure.orFail("AMassiveTestProtocolMock - value for nonOptionalClosure was not defined") }
		set {	invocations.append(.nonOptionalClosure_set(.value(newValue)))
				__nonOptionalClosure = newValue }
	}
	private var __nonOptionalClosure: (() -> Void)?
    var optionalClosure: (() -> Int)? { 
		get {	invocations.append(.optionalClosure_get)
				return __optionalClosure }
		set {	invocations.append(.optionalClosure_set(.value(newValue)))
				__optionalClosure = newValue }
	}
	private var __optionalClosure: (() -> Int)?
    var implicitelyUnwrappedClosure: (() -> Void)! { 
		get {	invocations.append(.implicitelyUnwrappedClosure_get)
				return __implicitelyUnwrappedClosure.orFail("AMassiveTestProtocolMock - value for implicitelyUnwrappedClosure was not defined") }
		set {	invocations.append(.implicitelyUnwrappedClosure_set(.value(newValue)))
				__implicitelyUnwrappedClosure = newValue }
	}
	private var __implicitelyUnwrappedClosure: (() -> Void)?

    struct Property {
        fileprivate var method: MethodType
        static var nonOptionalClosure: Property { return Property(method: .nonOptionalClosure_get) }
		static func nonOptionalClosure(set newValue: Parameter<() -> Void>) -> Property { return Property(method: .nonOptionalClosure_set(newValue)) }
        static var optionalClosure: Property { return Property(method: .optionalClosure_get) }
		static func optionalClosure(set newValue: Parameter<(() -> Int)?>) -> Property { return Property(method: .optionalClosure_set(newValue)) }
        static var implicitelyUnwrappedClosure: Property { return Property(method: .implicitelyUnwrappedClosure_get) }
		static func implicitelyUnwrappedClosure(set newValue: Parameter<(() -> Void)?>) -> Property { return Property(method: .implicitelyUnwrappedClosure_set(newValue)) }
    }
    static var optionalClosure: (() -> Int)? { 
		get {	AMassiveTestProtocolMock.invocations.append(.optionalClosure_get)
				return AMassiveTestProtocolMock.__optionalClosure }
		set {	AMassiveTestProtocolMock.invocations.append(.optionalClosure_set(.value(newValue)))
				AMassiveTestProtocolMock.__optionalClosure = newValue }
	}
	private static var __optionalClosure: (() -> Int)?

    struct StaticProperty {
        fileprivate var method: StaticMethodType
        static var optionalClosure: StaticProperty { return StaticProperty(method: .optionalClosure_get) }
		static func optionalClosure(set newValue: Parameter<(() -> Int)?>) -> StaticProperty { return StaticProperty(method: .optionalClosure_set(newValue)) }
    }

    static func methodThatThrows() throws {
        addInvocation(.smethodThatThrows)
		let perform = methodPerformValue(.smethodThatThrows) as? () -> Void
		perform?()
		var __value: Void
		do {
		    __value = try methodReturnValue(.smethodThatThrows).casted()
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }

    static func methodThatReturnsAndThrows(param: String) throws -> Int {
        addInvocation(.smethodThatReturnsAndThrows__param_param(Parameter<String>.value(param)))
		let perform = methodPerformValue(.smethodThatReturnsAndThrows__param_param(Parameter<String>.value(param))) as? (String) -> Void
		perform?(param)
		var __value: Int
		do {
		    __value = try methodReturnValue(.smethodThatReturnsAndThrows__param_param(Parameter<String>.value(param))).casted()
		} catch MockError.notStubed {
			Failure("stub return value not specified for methodThatReturnsAndThrows(param: String). Use given")
		} catch {
		    throw error
		}
		return __value
    }

    static func methodThatRethrows(param: (String) throws -> Int) rethrows -> Int {
        addInvocation(.smethodThatRethrows__param_param(Parameter<(String) throws -> Int>.any))
		let perform = methodPerformValue(.smethodThatRethrows__param_param(Parameter<(String) throws -> Int>.any)) as? ((String) throws -> Int) -> Void
		perform?(param)
		var __value: Int
		do {
		    __value = try methodReturnValue(.smethodThatRethrows__param_param(Parameter<(String) throws -> Int>.any)).casted()
		} catch {
			Failure("stub return value not specified for methodThatRethrows(param: (String) throws -> Int). Use given")
		}
		return __value
    }

    required init() { }

    required init(_ sth: Int) { }

    func methodThatThrows() throws {
        addInvocation(.imethodThatThrows)
		let perform = methodPerformValue(.imethodThatThrows) as? () -> Void
		perform?()
		var __value: Void
		do {
		    __value = try methodReturnValue(.imethodThatThrows).casted()
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }

    func methodThatReturnsAndThrows(param: String) throws -> Int {
        addInvocation(.imethodThatReturnsAndThrows__param_param(Parameter<String>.value(param)))
		let perform = methodPerformValue(.imethodThatReturnsAndThrows__param_param(Parameter<String>.value(param))) as? (String) -> Void
		perform?(param)
		var __value: Int
		do {
		    __value = try methodReturnValue(.imethodThatReturnsAndThrows__param_param(Parameter<String>.value(param))).casted()
		} catch MockError.notStubed {
			onFatalFailure("stub return value not specified for methodThatReturnsAndThrows(param: String). Use given")
			Failure("stub return value not specified for methodThatReturnsAndThrows(param: String). Use given")
		} catch {
		    throw error
		}
		return __value
    }

    func methodThatRethrows(param: (String) throws -> Int) rethrows -> Int {
        addInvocation(.imethodThatRethrows__param_param(Parameter<(String) throws -> Int>.any))
		let perform = methodPerformValue(.imethodThatRethrows__param_param(Parameter<(String) throws -> Int>.any)) as? ((String) throws -> Int) -> Void
		perform?(param)
		var __value: Int
		do {
		    __value = try methodReturnValue(.imethodThatRethrows__param_param(Parameter<(String) throws -> Int>.any)).casted()
		} catch {
			onFatalFailure("stub return value not specified for methodThatRethrows(param: (String) throws -> Int). Use given")
			Failure("stub return value not specified for methodThatRethrows(param: (String) throws -> Int). Use given")
		}
		return __value
    }

    fileprivate enum StaticMethodType {
        case smethodThatThrows
        case smethodThatReturnsAndThrows__param_param(Parameter<String>)
        case smethodThatRethrows__param_param(Parameter<(String) throws -> Int>)

        case optionalClosure_get
		case optionalClosure_set(Parameter<(() -> Int)?>)

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
                case (.optionalClosure_get,.optionalClosure_get): return true
				case (.optionalClosure_set(let left),.optionalClosure_set(let right)): return Parameter<(() -> Int)?>.compare(lhs: left, rhs: right, with: matcher)
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case .smethodThatThrows: return 0
                case let .smethodThatReturnsAndThrows__param_param(p0): return p0.intValue
                case let .smethodThatRethrows__param_param(p0): return p0.intValue
                case .optionalClosure_get: return 0
				case .optionalClosure_set(let newValue): return newValue.intValue
            }
        }
    }

    class StaticGiven: StubbedMethod {
        fileprivate var method: StaticMethodType

        private init(method: StaticMethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

        static func methodThatReturnsAndThrows(param: Parameter<String>, willReturn: Int...) -> StaticGiven {
            return StaticGiven(method: .smethodThatReturnsAndThrows__param_param(param), products: willReturn.map({ Product.return($0) }))
        }
        static func methodThatRethrows(param: Parameter<(String) throws -> Int>, willReturn: Int...) -> StaticGiven {
            return StaticGiven(method: .smethodThatRethrows__param_param(param), products: willReturn.map({ Product.return($0) }))
        }
        static func methodThatThrows(willThrow: Error...) -> StaticGiven {
            return StaticGiven(method: .smethodThatThrows, products: willThrow.map({ Product.throw($0) }))
        }
        static func methodThatThrows(willProduce: (StubberThrows<Void>) -> Void) -> StaticGiven {
            let willThrow: [Error] = []
			let given: StaticGiven = { return StaticGiven(method: .smethodThatThrows, products: willThrow.map({ Product.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
        static func methodThatReturnsAndThrows(param: Parameter<String>, willThrow: Error...) -> StaticGiven {
            return StaticGiven(method: .smethodThatReturnsAndThrows__param_param(param), products: willThrow.map({ Product.throw($0) }))
        }
        static func methodThatReturnsAndThrows(param: Parameter<String>, willProduce: (StubberThrows<Int>) -> Void) -> StaticGiven {
            let willThrow: [Error] = []
			let given: StaticGiven = { return StaticGiven(method: .smethodThatReturnsAndThrows__param_param(param), products: willThrow.map({ Product.throw($0) })) }()
			let stubber = given.stubThrows(for: (Int).self)
			willProduce(stubber)
			return given
        }
        static func methodThatRethrows(param: Parameter<(String) throws -> Int>, willThrow: Error...) -> StaticGiven {
            return StaticGiven(method: .smethodThatRethrows__param_param(param), products: willThrow.map({ Product.throw($0) }))
        }
        static func methodThatRethrows(param: Parameter<(String) throws -> Int>, willProduce: (StubberThrows<Int>) -> Void) -> StaticGiven {
            let willThrow: [Error] = []
			let given: StaticGiven = { return StaticGiven(method: .smethodThatRethrows__param_param(param), products: willThrow.map({ Product.throw($0) })) }()
			let stubber = given.stubThrows(for: (Int).self)
			willProduce(stubber)
			return given
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

        static func methodThatThrows(perform: @escaping () -> Void) -> StaticPerform {
            return StaticPerform(method: .smethodThatThrows, performs: perform)
        }
        static func methodThatReturnsAndThrows(param: Parameter<String>, perform: @escaping (String) -> Void) -> StaticPerform {
            return StaticPerform(method: .smethodThatReturnsAndThrows__param_param(param), performs: perform)
        }
        static func methodThatRethrows(param: Parameter<(String) throws -> Int>, perform: @escaping ((String) throws -> Int) -> Void) -> StaticPerform {
            return StaticPerform(method: .smethodThatRethrows__param_param(param), performs: perform)
        }
    }

        fileprivate enum MethodType {
        case imethodThatThrows
        case imethodThatReturnsAndThrows__param_param(Parameter<String>)
        case imethodThatRethrows__param_param(Parameter<(String) throws -> Int>)
        case nonOptionalClosure_get
		case nonOptionalClosure_set(Parameter<() -> Void>)
        case optionalClosure_get
		case optionalClosure_set(Parameter<(() -> Int)?>)
        case implicitelyUnwrappedClosure_get
		case implicitelyUnwrappedClosure_set(Parameter<(() -> Void)?>)

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
                case (.nonOptionalClosure_get,.nonOptionalClosure_get): return true
				case (.nonOptionalClosure_set(let left),.nonOptionalClosure_set(let right)): return Parameter<() -> Void>.compare(lhs: left, rhs: right, with: matcher)
                case (.optionalClosure_get,.optionalClosure_get): return true
				case (.optionalClosure_set(let left),.optionalClosure_set(let right)): return Parameter<(() -> Int)?>.compare(lhs: left, rhs: right, with: matcher)
                case (.implicitelyUnwrappedClosure_get,.implicitelyUnwrappedClosure_get): return true
				case (.implicitelyUnwrappedClosure_set(let left),.implicitelyUnwrappedClosure_set(let right)): return Parameter<(() -> Void)?>.compare(lhs: left, rhs: right, with: matcher)
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case .imethodThatThrows: return 0
                case let .imethodThatReturnsAndThrows__param_param(p0): return p0.intValue
                case let .imethodThatRethrows__param_param(p0): return p0.intValue
                case .nonOptionalClosure_get: return 0
				case .nonOptionalClosure_set(let newValue): return newValue.intValue
                case .optionalClosure_get: return 0
				case .optionalClosure_set(let newValue): return newValue.intValue
                case .implicitelyUnwrappedClosure_get: return 0
				case .implicitelyUnwrappedClosure_set(let newValue): return newValue.intValue
            }
        }
    }

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

        static func methodThatReturnsAndThrows(param: Parameter<String>, willReturn: Int...) -> Given {
            return Given(method: .imethodThatReturnsAndThrows__param_param(param), products: willReturn.map({ Product.return($0) }))
        }
        static func methodThatRethrows(param: Parameter<(String) throws -> Int>, willReturn: Int...) -> Given {
            return Given(method: .imethodThatRethrows__param_param(param), products: willReturn.map({ Product.return($0) }))
        }
        static func methodThatThrows(willThrow: Error...) -> Given {
            return Given(method: .imethodThatThrows, products: willThrow.map({ Product.throw($0) }))
        }
        static func methodThatThrows(willProduce: (StubberThrows<Void>) -> Void) -> Given {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .imethodThatThrows, products: willThrow.map({ Product.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
        static func methodThatReturnsAndThrows(param: Parameter<String>, willThrow: Error...) -> Given {
            return Given(method: .imethodThatReturnsAndThrows__param_param(param), products: willThrow.map({ Product.throw($0) }))
        }
        static func methodThatReturnsAndThrows(param: Parameter<String>, willProduce: (StubberThrows<Int>) -> Void) -> Given {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .imethodThatReturnsAndThrows__param_param(param), products: willThrow.map({ Product.throw($0) })) }()
			let stubber = given.stubThrows(for: (Int).self)
			willProduce(stubber)
			return given
        }
        static func methodThatRethrows(param: Parameter<(String) throws -> Int>, willThrow: Error...) -> Given {
            return Given(method: .imethodThatRethrows__param_param(param), products: willThrow.map({ Product.throw($0) }))
        }
        static func methodThatRethrows(param: Parameter<(String) throws -> Int>, willProduce: (StubberThrows<Int>) -> Void) -> Given {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .imethodThatRethrows__param_param(param), products: willThrow.map({ Product.throw($0) })) }()
			let stubber = given.stubThrows(for: (Int).self)
			willProduce(stubber)
			return given
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

        static func methodThatThrows(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .imethodThatThrows, performs: perform)
        }
        static func methodThatReturnsAndThrows(param: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .imethodThatReturnsAndThrows__param_param(param), performs: perform)
        }
        static func methodThatRethrows(param: Parameter<(String) throws -> Int>, perform: @escaping ((String) throws -> Int) -> Void) -> Perform {
            return Perform(method: .imethodThatRethrows__param_param(param), performs: perform)
        }
    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
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
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(property.method)
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(property.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> Product {
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

    static private func matchingCalls(_ method: StaticVerify) -> Int {
        return matchingCalls(method.method).count
    }

    static public func given(_ method: StaticGiven) {
        methodReturnValues.append(method)
    }

    static public func perform(_ method: StaticPerform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    static public func verify(_ method: StaticVerify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    static public func verify(property: StaticProperty, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(property.method)
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(property.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    static private func addInvocation(_ call: StaticMethodType) {
        invocations.append(call)
    }

    static private func methodReturnValue(_ method: StaticMethodType) throws -> Product {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && StaticMethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
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
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }


	typealias T1 = TypeT1
	typealias T2 = TypeT2

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyTestCase.onFatalFailure() // Prepare running test case that it should not continue
        XCTFail(message, file: file, line: line)
        #endif
    }



    typealias Property = Swift.Never


    func fetch(for value: T2) -> T1 {
        addInvocation(.ifetch__for_value(Parameter<T2>.value(value)))
		let perform = methodPerformValue(.ifetch__for_value(Parameter<T2>.value(value))) as? (T2) -> Void
		perform?(value)
		var __value: T1
		do {
		    __value = try methodReturnValue(.ifetch__for_value(Parameter<T2>.value(value))).casted()
		} catch {
			onFatalFailure("stub return value not specified for fetch(for value: T2). Use given")
			Failure("stub return value not specified for fetch(for value: T2). Use given")
		}
		return __value
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

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

        static func fetch(for value: Parameter<T2>, willReturn: T1...) -> Given {
            return Given(method: .ifetch__for_value(value), products: willReturn.map({ Product.return($0) }))
        }
        static func fetch(for value: Parameter<T2>, willProduce: (Stubber<T1>) -> Void) -> Given {
            let willReturn: [T1] = []
			let given: Given = { return Given(method: .ifetch__for_value(value), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (T1).self)
			willProduce(stubber)
			return given
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

        static func fetch(for value: Parameter<T2>, perform: @escaping (T2) -> Void) -> Perform {
            return Perform(method: .ifetch__for_value(value), performs: perform)
        }
    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
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
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }
    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) { }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> Product {
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
}

// MARK: - AVeryGenericProtocol
class AVeryGenericProtocolMock: AVeryGenericProtocol, Mock, StaticMock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
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

    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyTestCase.onFatalFailure() // Prepare running test case that it should not continue
        XCTFail(message, file: file, line: line)
        #endif
    }

    static var matcher: Matcher = Matcher.default
    static var stubbingPolicy: StubbingPolicy = .wrap
    static var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    static private var invocations: [StaticMethodType] = []
    static private var methodReturnValues: [StaticGiven] = []
    static private var methodPerformValues: [StaticPerform] = []
    static func clear() {
        invocations = []
        methodReturnValues = []
        methodPerformValues = []
    }


    typealias Property = Swift.Never

    typealias StaticProperty = Swift.Never

    static func generic<Q>(lhs: Q, rhs: Q) -> Bool where Q: Equatable {
        addInvocation(.sgeneric__lhs_lhsrhs_rhs(Parameter<Q>.value(lhs).wrapAsGeneric(), Parameter<Q>.value(rhs).wrapAsGeneric()))
		let perform = methodPerformValue(.sgeneric__lhs_lhsrhs_rhs(Parameter<Q>.value(lhs).wrapAsGeneric(), Parameter<Q>.value(rhs).wrapAsGeneric())) as? (Q, Q) -> Void
		perform?(lhs, rhs)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.sgeneric__lhs_lhsrhs_rhs(Parameter<Q>.value(lhs).wrapAsGeneric(), Parameter<Q>.value(rhs).wrapAsGeneric())).casted()
		} catch {
			Failure("stub return value not specified for generic<Q>(lhs: Q, rhs: Q). Use given")
		}
		return __value
    }

    static func veryConstrained<Q: Sequence>(lhs: Q, rhs: Q) -> Bool where Q: Equatable {
        addInvocation(.sveryConstrained__lhs_lhsrhs_rhs(Parameter<Q>.value(lhs).wrapAsGeneric(), Parameter<Q>.value(rhs).wrapAsGeneric()))
		let perform = methodPerformValue(.sveryConstrained__lhs_lhsrhs_rhs(Parameter<Q>.value(lhs).wrapAsGeneric(), Parameter<Q>.value(rhs).wrapAsGeneric())) as? (Q, Q) -> Void
		perform?(lhs, rhs)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.sveryConstrained__lhs_lhsrhs_rhs(Parameter<Q>.value(lhs).wrapAsGeneric(), Parameter<Q>.value(rhs).wrapAsGeneric())).casted()
		} catch {
			Failure("stub return value not specified for veryConstrained<Q: Sequence>(lhs: Q, rhs: Q). Use given")
		}
		return __value
    }

    required init<V>(value: V) { }

    func methodConstrained<A,B,C>(param: A) -> (B,C) {
        addInvocation(.imethodConstrained__param_param(Parameter<A>.value(param).wrapAsGeneric()))
		let perform = methodPerformValue(.imethodConstrained__param_param(Parameter<A>.value(param).wrapAsGeneric())) as? (A) -> Void
		perform?(param)
		var __value: (B,C)
		do {
		    __value = try methodReturnValue(.imethodConstrained__param_param(Parameter<A>.value(param).wrapAsGeneric())).casted()
		} catch {
			onFatalFailure("stub return value not specified for methodConstrained<A,B,C>(param: A). Use given")
			Failure("stub return value not specified for methodConstrained<A,B,C>(param: A). Use given")
		}
		return __value
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

    class StaticGiven: StubbedMethod {
        fileprivate var method: StaticMethodType

        private init(method: StaticMethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

        static func generic<Q>(lhs: Parameter<Q>, rhs: Parameter<Q>, willReturn: Bool...) -> StaticGiven {
            return StaticGiven(method: .sgeneric__lhs_lhsrhs_rhs(lhs.wrapAsGeneric(), rhs.wrapAsGeneric()), products: willReturn.map({ Product.return($0) }))
        }
        static func veryConstrained<Q: Sequence>(lhs: Parameter<Q>, rhs: Parameter<Q>, willReturn: Bool...) -> StaticGiven {
            return StaticGiven(method: .sveryConstrained__lhs_lhsrhs_rhs(lhs.wrapAsGeneric(), rhs.wrapAsGeneric()), products: willReturn.map({ Product.return($0) }))
        }
        static func generic<Q>(lhs: Parameter<Q>, rhs: Parameter<Q>, willProduce: (Stubber<Bool>) -> Void) -> StaticGiven {
            let willReturn: [Bool] = []
			let given: StaticGiven = { return StaticGiven(method: .sgeneric__lhs_lhsrhs_rhs(lhs.wrapAsGeneric(), rhs.wrapAsGeneric()), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
        }
        static func veryConstrained<Q: Sequence>(lhs: Parameter<Q>, rhs: Parameter<Q>, willProduce: (Stubber<Bool>) -> Void) -> StaticGiven {
            let willReturn: [Bool] = []
			let given: StaticGiven = { return StaticGiven(method: .sveryConstrained__lhs_lhsrhs_rhs(lhs.wrapAsGeneric(), rhs.wrapAsGeneric()), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
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

        static func generic<Q>(lhs: Parameter<Q>, rhs: Parameter<Q>, perform: @escaping (Q, Q) -> Void) -> StaticPerform {
            return StaticPerform(method: .sgeneric__lhs_lhsrhs_rhs(lhs.wrapAsGeneric(), rhs.wrapAsGeneric()), performs: perform)
        }
        static func veryConstrained<Q>(lhs: Parameter<Q>, rhs: Parameter<Q>, perform: @escaping (Q, Q) -> Void) -> StaticPerform {
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

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

        static func methodConstrained<A,B,C>(param: Parameter<A>, willReturn: (B,C)...) -> Given {
            return Given(method: .imethodConstrained__param_param(param.wrapAsGeneric()), products: willReturn.map({ Product.return($0) }))
        }
        static func methodConstrained<A,B,C>(param: Parameter<A>, willProduce: (Stubber<(B,C)>) -> Void) -> Given {
            let willReturn: [(B,C)] = []
			let given: Given = { return Given(method: .imethodConstrained__param_param(param.wrapAsGeneric()), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: ((B,C)).self)
			willProduce(stubber)
			return given
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

        static func methodConstrained<A>(param: Parameter<A>, perform: @escaping (A) -> Void) -> Perform {
            return Perform(method: .imethodConstrained__param_param(param.wrapAsGeneric()), performs: perform)
        }
    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
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
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }
    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) { }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> Product {
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

    static private func matchingCalls(_ method: StaticVerify) -> Int {
        return matchingCalls(method.method).count
    }

    static public func given(_ method: StaticGiven) {
        methodReturnValues.append(method)
    }

    static public func perform(_ method: StaticPerform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    static public func verify(_ method: StaticVerify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }
    static public func verify(property: StaticProperty, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) { }

    static private func addInvocation(_ call: StaticMethodType) {
        invocations.append(call)
    }

    static private func methodReturnValue(_ method: StaticMethodType) throws -> Product {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && StaticMethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }

    static private func methodPerformValue(_ method: StaticMethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { StaticMethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    static private func matchingCalls(_ method: StaticMethodType) -> [StaticMethodType] {
        return invocations.filter { StaticMethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}

// MARK: - AllLiteralsContainer
class AllLiteralsContainerMock: AllLiteralsContainer, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
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

    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyTestCase.onFatalFailure() // Prepare running test case that it should not continue
        XCTFail(message, file: file, line: line)
        #endif
    }



    typealias Property = Swift.Never


    func methodWithStringParameter(p: String) -> Int {
        addInvocation(.imethodWithStringParameter__p_p(Parameter<String>.value(p)))
		let perform = methodPerformValue(.imethodWithStringParameter__p_p(Parameter<String>.value(p))) as? (String) -> Void
		perform?(p)
		var __value: Int
		do {
		    __value = try methodReturnValue(.imethodWithStringParameter__p_p(Parameter<String>.value(p))).casted()
		} catch {
			onFatalFailure("stub return value not specified for methodWithStringParameter(p: String). Use given")
			Failure("stub return value not specified for methodWithStringParameter(p: String). Use given")
		}
		return __value
    }

    func methodWithOtionalStringParameter(p: String?) -> Int {
        addInvocation(.imethodWithOtionalStringParameter__p_p(Parameter<String?>.value(p)))
		let perform = methodPerformValue(.imethodWithOtionalStringParameter__p_p(Parameter<String?>.value(p))) as? (String?) -> Void
		perform?(p)
		var __value: Int
		do {
		    __value = try methodReturnValue(.imethodWithOtionalStringParameter__p_p(Parameter<String?>.value(p))).casted()
		} catch {
			onFatalFailure("stub return value not specified for methodWithOtionalStringParameter(p: String?). Use given")
			Failure("stub return value not specified for methodWithOtionalStringParameter(p: String?). Use given")
		}
		return __value
    }

    func methodWithCustomStringParameter(p: CustomString) -> Int {
        addInvocation(.imethodWithCustomStringParameter__p_p(Parameter<CustomString>.value(p)))
		let perform = methodPerformValue(.imethodWithCustomStringParameter__p_p(Parameter<CustomString>.value(p))) as? (CustomString) -> Void
		perform?(p)
		var __value: Int
		do {
		    __value = try methodReturnValue(.imethodWithCustomStringParameter__p_p(Parameter<CustomString>.value(p))).casted()
		} catch {
			onFatalFailure("stub return value not specified for methodWithCustomStringParameter(p: CustomString). Use given")
			Failure("stub return value not specified for methodWithCustomStringParameter(p: CustomString). Use given")
		}
		return __value
    }

    func methodWithCustomOptionalStringParameter(p: CustomString?) -> Int {
        addInvocation(.imethodWithCustomOptionalStringParameter__p_p(Parameter<CustomString?>.value(p)))
		let perform = methodPerformValue(.imethodWithCustomOptionalStringParameter__p_p(Parameter<CustomString?>.value(p))) as? (CustomString?) -> Void
		perform?(p)
		var __value: Int
		do {
		    __value = try methodReturnValue(.imethodWithCustomOptionalStringParameter__p_p(Parameter<CustomString?>.value(p))).casted()
		} catch {
			onFatalFailure("stub return value not specified for methodWithCustomOptionalStringParameter(p: CustomString?). Use given")
			Failure("stub return value not specified for methodWithCustomOptionalStringParameter(p: CustomString?). Use given")
		}
		return __value
    }

    func methodWithIntParameter(p: Int) -> Int {
        addInvocation(.imethodWithIntParameter__p_p(Parameter<Int>.value(p)))
		let perform = methodPerformValue(.imethodWithIntParameter__p_p(Parameter<Int>.value(p))) as? (Int) -> Void
		perform?(p)
		var __value: Int
		do {
		    __value = try methodReturnValue(.imethodWithIntParameter__p_p(Parameter<Int>.value(p))).casted()
		} catch {
			onFatalFailure("stub return value not specified for methodWithIntParameter(p: Int). Use given")
			Failure("stub return value not specified for methodWithIntParameter(p: Int). Use given")
		}
		return __value
    }

    func methodWithCustomOptionalIntParameter(p: CustomInt?) -> Int {
        addInvocation(.imethodWithCustomOptionalIntParameter__p_p(Parameter<CustomInt?>.value(p)))
		let perform = methodPerformValue(.imethodWithCustomOptionalIntParameter__p_p(Parameter<CustomInt?>.value(p))) as? (CustomInt?) -> Void
		perform?(p)
		var __value: Int
		do {
		    __value = try methodReturnValue(.imethodWithCustomOptionalIntParameter__p_p(Parameter<CustomInt?>.value(p))).casted()
		} catch {
			onFatalFailure("stub return value not specified for methodWithCustomOptionalIntParameter(p: CustomInt?). Use given")
			Failure("stub return value not specified for methodWithCustomOptionalIntParameter(p: CustomInt?). Use given")
		}
		return __value
    }

    func methodWithBool(p: Bool?) -> Int {
        addInvocation(.imethodWithBool__p_p(Parameter<Bool?>.value(p)))
		let perform = methodPerformValue(.imethodWithBool__p_p(Parameter<Bool?>.value(p))) as? (Bool?) -> Void
		perform?(p)
		var __value: Int
		do {
		    __value = try methodReturnValue(.imethodWithBool__p_p(Parameter<Bool?>.value(p))).casted()
		} catch {
			onFatalFailure("stub return value not specified for methodWithBool(p: Bool?). Use given")
			Failure("stub return value not specified for methodWithBool(p: Bool?). Use given")
		}
		return __value
    }

    func methodWithFloat(p: Float?) -> Int {
        addInvocation(.imethodWithFloat__p_p(Parameter<Float?>.value(p)))
		let perform = methodPerformValue(.imethodWithFloat__p_p(Parameter<Float?>.value(p))) as? (Float?) -> Void
		perform?(p)
		var __value: Int
		do {
		    __value = try methodReturnValue(.imethodWithFloat__p_p(Parameter<Float?>.value(p))).casted()
		} catch {
			onFatalFailure("stub return value not specified for methodWithFloat(p: Float?). Use given")
			Failure("stub return value not specified for methodWithFloat(p: Float?). Use given")
		}
		return __value
    }

    func methodWithDouble(p: Double?) -> Int {
        addInvocation(.imethodWithDouble__p_p(Parameter<Double?>.value(p)))
		let perform = methodPerformValue(.imethodWithDouble__p_p(Parameter<Double?>.value(p))) as? (Double?) -> Void
		perform?(p)
		var __value: Int
		do {
		    __value = try methodReturnValue(.imethodWithDouble__p_p(Parameter<Double?>.value(p))).casted()
		} catch {
			onFatalFailure("stub return value not specified for methodWithDouble(p: Double?). Use given")
			Failure("stub return value not specified for methodWithDouble(p: Double?). Use given")
		}
		return __value
    }

    func methodWithArrayOfInt(p: [Int]) -> Int {
        addInvocation(.imethodWithArrayOfInt__p_p(Parameter<[Int]>.value(p)))
		let perform = methodPerformValue(.imethodWithArrayOfInt__p_p(Parameter<[Int]>.value(p))) as? ([Int]) -> Void
		perform?(p)
		var __value: Int
		do {
		    __value = try methodReturnValue(.imethodWithArrayOfInt__p_p(Parameter<[Int]>.value(p))).casted()
		} catch {
			onFatalFailure("stub return value not specified for methodWithArrayOfInt(p: [Int]). Use given")
			Failure("stub return value not specified for methodWithArrayOfInt(p: [Int]). Use given")
		}
		return __value
    }

    func methodWithArrayOfOther(p: [SomeClass]) -> Int {
        addInvocation(.imethodWithArrayOfOther__p_p(Parameter<[SomeClass]>.value(p)))
		let perform = methodPerformValue(.imethodWithArrayOfOther__p_p(Parameter<[SomeClass]>.value(p))) as? ([SomeClass]) -> Void
		perform?(p)
		var __value: Int
		do {
		    __value = try methodReturnValue(.imethodWithArrayOfOther__p_p(Parameter<[SomeClass]>.value(p))).casted()
		} catch {
			onFatalFailure("stub return value not specified for methodWithArrayOfOther(p: [SomeClass]). Use given")
			Failure("stub return value not specified for methodWithArrayOfOther(p: [SomeClass]). Use given")
		}
		return __value
    }

    func methodWithDict(p: [String: SomeClass]) -> Int {
        addInvocation(.imethodWithDict__p_p(Parameter<[String: SomeClass]>.value(p)))
		let perform = methodPerformValue(.imethodWithDict__p_p(Parameter<[String: SomeClass]>.value(p))) as? ([String: SomeClass]) -> Void
		perform?(p)
		var __value: Int
		do {
		    __value = try methodReturnValue(.imethodWithDict__p_p(Parameter<[String: SomeClass]>.value(p))).casted()
		} catch {
			onFatalFailure("stub return value not specified for methodWithDict(p: [String: SomeClass]). Use given")
			Failure("stub return value not specified for methodWithDict(p: [String: SomeClass]). Use given")
		}
		return __value
    }

    fileprivate enum MethodType {
        case imethodWithStringParameter__p_p(Parameter<String>)
        case imethodWithOtionalStringParameter__p_p(Parameter<String?>)
        case imethodWithCustomStringParameter__p_p(Parameter<CustomString>)
        case imethodWithCustomOptionalStringParameter__p_p(Parameter<CustomString?>)
        case imethodWithIntParameter__p_p(Parameter<Int>)
        case imethodWithCustomOptionalIntParameter__p_p(Parameter<CustomInt?>)
        case imethodWithBool__p_p(Parameter<Bool?>)
        case imethodWithFloat__p_p(Parameter<Float?>)
        case imethodWithDouble__p_p(Parameter<Double?>)
        case imethodWithArrayOfInt__p_p(Parameter<[Int]>)
        case imethodWithArrayOfOther__p_p(Parameter<[SomeClass]>)
        case imethodWithDict__p_p(Parameter<[String: SomeClass]>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.imethodWithStringParameter__p_p(let lhsP), .imethodWithStringParameter__p_p(let rhsP)):
                    guard Parameter.compare(lhs: lhsP, rhs: rhsP, with: matcher) else { return false } 
                    return true 
                case (.imethodWithOtionalStringParameter__p_p(let lhsP), .imethodWithOtionalStringParameter__p_p(let rhsP)):
                    guard Parameter.compare(lhs: lhsP, rhs: rhsP, with: matcher) else { return false } 
                    return true 
                case (.imethodWithCustomStringParameter__p_p(let lhsP), .imethodWithCustomStringParameter__p_p(let rhsP)):
                    guard Parameter.compare(lhs: lhsP, rhs: rhsP, with: matcher) else { return false } 
                    return true 
                case (.imethodWithCustomOptionalStringParameter__p_p(let lhsP), .imethodWithCustomOptionalStringParameter__p_p(let rhsP)):
                    guard Parameter.compare(lhs: lhsP, rhs: rhsP, with: matcher) else { return false } 
                    return true 
                case (.imethodWithIntParameter__p_p(let lhsP), .imethodWithIntParameter__p_p(let rhsP)):
                    guard Parameter.compare(lhs: lhsP, rhs: rhsP, with: matcher) else { return false } 
                    return true 
                case (.imethodWithCustomOptionalIntParameter__p_p(let lhsP), .imethodWithCustomOptionalIntParameter__p_p(let rhsP)):
                    guard Parameter.compare(lhs: lhsP, rhs: rhsP, with: matcher) else { return false } 
                    return true 
                case (.imethodWithBool__p_p(let lhsP), .imethodWithBool__p_p(let rhsP)):
                    guard Parameter.compare(lhs: lhsP, rhs: rhsP, with: matcher) else { return false } 
                    return true 
                case (.imethodWithFloat__p_p(let lhsP), .imethodWithFloat__p_p(let rhsP)):
                    guard Parameter.compare(lhs: lhsP, rhs: rhsP, with: matcher) else { return false } 
                    return true 
                case (.imethodWithDouble__p_p(let lhsP), .imethodWithDouble__p_p(let rhsP)):
                    guard Parameter.compare(lhs: lhsP, rhs: rhsP, with: matcher) else { return false } 
                    return true 
                case (.imethodWithArrayOfInt__p_p(let lhsP), .imethodWithArrayOfInt__p_p(let rhsP)):
                    guard Parameter.compare(lhs: lhsP, rhs: rhsP, with: matcher) else { return false } 
                    return true 
                case (.imethodWithArrayOfOther__p_p(let lhsP), .imethodWithArrayOfOther__p_p(let rhsP)):
                    guard Parameter.compare(lhs: lhsP, rhs: rhsP, with: matcher) else { return false } 
                    return true 
                case (.imethodWithDict__p_p(let lhsP), .imethodWithDict__p_p(let rhsP)):
                    guard Parameter.compare(lhs: lhsP, rhs: rhsP, with: matcher) else { return false } 
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case let .imethodWithStringParameter__p_p(p0): return p0.intValue
                case let .imethodWithOtionalStringParameter__p_p(p0): return p0.intValue
                case let .imethodWithCustomStringParameter__p_p(p0): return p0.intValue
                case let .imethodWithCustomOptionalStringParameter__p_p(p0): return p0.intValue
                case let .imethodWithIntParameter__p_p(p0): return p0.intValue
                case let .imethodWithCustomOptionalIntParameter__p_p(p0): return p0.intValue
                case let .imethodWithBool__p_p(p0): return p0.intValue
                case let .imethodWithFloat__p_p(p0): return p0.intValue
                case let .imethodWithDouble__p_p(p0): return p0.intValue
                case let .imethodWithArrayOfInt__p_p(p0): return p0.intValue
                case let .imethodWithArrayOfOther__p_p(p0): return p0.intValue
                case let .imethodWithDict__p_p(p0): return p0.intValue
            }
        }
    }

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

        static func methodWithStringParameter(p: Parameter<String>, willReturn: Int...) -> Given {
            return Given(method: .imethodWithStringParameter__p_p(p), products: willReturn.map({ Product.return($0) }))
        }
        static func methodWithOtionalStringParameter(p: Parameter<String?>, willReturn: Int...) -> Given {
            return Given(method: .imethodWithOtionalStringParameter__p_p(p), products: willReturn.map({ Product.return($0) }))
        }
        static func methodWithCustomStringParameter(p: Parameter<CustomString>, willReturn: Int...) -> Given {
            return Given(method: .imethodWithCustomStringParameter__p_p(p), products: willReturn.map({ Product.return($0) }))
        }
        static func methodWithCustomOptionalStringParameter(p: Parameter<CustomString?>, willReturn: Int...) -> Given {
            return Given(method: .imethodWithCustomOptionalStringParameter__p_p(p), products: willReturn.map({ Product.return($0) }))
        }
        static func methodWithIntParameter(p: Parameter<Int>, willReturn: Int...) -> Given {
            return Given(method: .imethodWithIntParameter__p_p(p), products: willReturn.map({ Product.return($0) }))
        }
        static func methodWithCustomOptionalIntParameter(p: Parameter<CustomInt?>, willReturn: Int...) -> Given {
            return Given(method: .imethodWithCustomOptionalIntParameter__p_p(p), products: willReturn.map({ Product.return($0) }))
        }
        static func methodWithBool(p: Parameter<Bool?>, willReturn: Int...) -> Given {
            return Given(method: .imethodWithBool__p_p(p), products: willReturn.map({ Product.return($0) }))
        }
        static func methodWithFloat(p: Parameter<Float?>, willReturn: Int...) -> Given {
            return Given(method: .imethodWithFloat__p_p(p), products: willReturn.map({ Product.return($0) }))
        }
        static func methodWithDouble(p: Parameter<Double?>, willReturn: Int...) -> Given {
            return Given(method: .imethodWithDouble__p_p(p), products: willReturn.map({ Product.return($0) }))
        }
        static func methodWithArrayOfInt(p: Parameter<[Int]>, willReturn: Int...) -> Given {
            return Given(method: .imethodWithArrayOfInt__p_p(p), products: willReturn.map({ Product.return($0) }))
        }
        static func methodWithArrayOfOther(p: Parameter<[SomeClass]>, willReturn: Int...) -> Given {
            return Given(method: .imethodWithArrayOfOther__p_p(p), products: willReturn.map({ Product.return($0) }))
        }
        static func methodWithDict(p: Parameter<[String: SomeClass]>, willReturn: Int...) -> Given {
            return Given(method: .imethodWithDict__p_p(p), products: willReturn.map({ Product.return($0) }))
        }
        static func methodWithStringParameter(p: Parameter<String>, willProduce: (Stubber<Int>) -> Void) -> Given {
            let willReturn: [Int] = []
			let given: Given = { return Given(method: .imethodWithStringParameter__p_p(p), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Int).self)
			willProduce(stubber)
			return given
        }
        static func methodWithOtionalStringParameter(p: Parameter<String?>, willProduce: (Stubber<Int>) -> Void) -> Given {
            let willReturn: [Int] = []
			let given: Given = { return Given(method: .imethodWithOtionalStringParameter__p_p(p), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Int).self)
			willProduce(stubber)
			return given
        }
        static func methodWithCustomStringParameter(p: Parameter<CustomString>, willProduce: (Stubber<Int>) -> Void) -> Given {
            let willReturn: [Int] = []
			let given: Given = { return Given(method: .imethodWithCustomStringParameter__p_p(p), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Int).self)
			willProduce(stubber)
			return given
        }
        static func methodWithCustomOptionalStringParameter(p: Parameter<CustomString?>, willProduce: (Stubber<Int>) -> Void) -> Given {
            let willReturn: [Int] = []
			let given: Given = { return Given(method: .imethodWithCustomOptionalStringParameter__p_p(p), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Int).self)
			willProduce(stubber)
			return given
        }
        static func methodWithIntParameter(p: Parameter<Int>, willProduce: (Stubber<Int>) -> Void) -> Given {
            let willReturn: [Int] = []
			let given: Given = { return Given(method: .imethodWithIntParameter__p_p(p), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Int).self)
			willProduce(stubber)
			return given
        }
        static func methodWithCustomOptionalIntParameter(p: Parameter<CustomInt?>, willProduce: (Stubber<Int>) -> Void) -> Given {
            let willReturn: [Int] = []
			let given: Given = { return Given(method: .imethodWithCustomOptionalIntParameter__p_p(p), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Int).self)
			willProduce(stubber)
			return given
        }
        static func methodWithBool(p: Parameter<Bool?>, willProduce: (Stubber<Int>) -> Void) -> Given {
            let willReturn: [Int] = []
			let given: Given = { return Given(method: .imethodWithBool__p_p(p), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Int).self)
			willProduce(stubber)
			return given
        }
        static func methodWithFloat(p: Parameter<Float?>, willProduce: (Stubber<Int>) -> Void) -> Given {
            let willReturn: [Int] = []
			let given: Given = { return Given(method: .imethodWithFloat__p_p(p), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Int).self)
			willProduce(stubber)
			return given
        }
        static func methodWithDouble(p: Parameter<Double?>, willProduce: (Stubber<Int>) -> Void) -> Given {
            let willReturn: [Int] = []
			let given: Given = { return Given(method: .imethodWithDouble__p_p(p), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Int).self)
			willProduce(stubber)
			return given
        }
        static func methodWithArrayOfInt(p: Parameter<[Int]>, willProduce: (Stubber<Int>) -> Void) -> Given {
            let willReturn: [Int] = []
			let given: Given = { return Given(method: .imethodWithArrayOfInt__p_p(p), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Int).self)
			willProduce(stubber)
			return given
        }
        static func methodWithArrayOfOther(p: Parameter<[SomeClass]>, willProduce: (Stubber<Int>) -> Void) -> Given {
            let willReturn: [Int] = []
			let given: Given = { return Given(method: .imethodWithArrayOfOther__p_p(p), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Int).self)
			willProduce(stubber)
			return given
        }
        static func methodWithDict(p: Parameter<[String: SomeClass]>, willProduce: (Stubber<Int>) -> Void) -> Given {
            let willReturn: [Int] = []
			let given: Given = { return Given(method: .imethodWithDict__p_p(p), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Int).self)
			willProduce(stubber)
			return given
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func methodWithStringParameter(p: Parameter<String>) -> Verify {
            return Verify(method: .imethodWithStringParameter__p_p(p))
        }
        static func methodWithOtionalStringParameter(p: Parameter<String?>) -> Verify {
            return Verify(method: .imethodWithOtionalStringParameter__p_p(p))
        }
        static func methodWithCustomStringParameter(p: Parameter<CustomString>) -> Verify {
            return Verify(method: .imethodWithCustomStringParameter__p_p(p))
        }
        static func methodWithCustomOptionalStringParameter(p: Parameter<CustomString?>) -> Verify {
            return Verify(method: .imethodWithCustomOptionalStringParameter__p_p(p))
        }
        static func methodWithIntParameter(p: Parameter<Int>) -> Verify {
            return Verify(method: .imethodWithIntParameter__p_p(p))
        }
        static func methodWithCustomOptionalIntParameter(p: Parameter<CustomInt?>) -> Verify {
            return Verify(method: .imethodWithCustomOptionalIntParameter__p_p(p))
        }
        static func methodWithBool(p: Parameter<Bool?>) -> Verify {
            return Verify(method: .imethodWithBool__p_p(p))
        }
        static func methodWithFloat(p: Parameter<Float?>) -> Verify {
            return Verify(method: .imethodWithFloat__p_p(p))
        }
        static func methodWithDouble(p: Parameter<Double?>) -> Verify {
            return Verify(method: .imethodWithDouble__p_p(p))
        }
        static func methodWithArrayOfInt(p: Parameter<[Int]>) -> Verify {
            return Verify(method: .imethodWithArrayOfInt__p_p(p))
        }
        static func methodWithArrayOfOther(p: Parameter<[SomeClass]>) -> Verify {
            return Verify(method: .imethodWithArrayOfOther__p_p(p))
        }
        static func methodWithDict(p: Parameter<[String: SomeClass]>) -> Verify {
            return Verify(method: .imethodWithDict__p_p(p))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func methodWithStringParameter(p: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .imethodWithStringParameter__p_p(p), performs: perform)
        }
        static func methodWithOtionalStringParameter(p: Parameter<String?>, perform: @escaping (String?) -> Void) -> Perform {
            return Perform(method: .imethodWithOtionalStringParameter__p_p(p), performs: perform)
        }
        static func methodWithCustomStringParameter(p: Parameter<CustomString>, perform: @escaping (CustomString) -> Void) -> Perform {
            return Perform(method: .imethodWithCustomStringParameter__p_p(p), performs: perform)
        }
        static func methodWithCustomOptionalStringParameter(p: Parameter<CustomString?>, perform: @escaping (CustomString?) -> Void) -> Perform {
            return Perform(method: .imethodWithCustomOptionalStringParameter__p_p(p), performs: perform)
        }
        static func methodWithIntParameter(p: Parameter<Int>, perform: @escaping (Int) -> Void) -> Perform {
            return Perform(method: .imethodWithIntParameter__p_p(p), performs: perform)
        }
        static func methodWithCustomOptionalIntParameter(p: Parameter<CustomInt?>, perform: @escaping (CustomInt?) -> Void) -> Perform {
            return Perform(method: .imethodWithCustomOptionalIntParameter__p_p(p), performs: perform)
        }
        static func methodWithBool(p: Parameter<Bool?>, perform: @escaping (Bool?) -> Void) -> Perform {
            return Perform(method: .imethodWithBool__p_p(p), performs: perform)
        }
        static func methodWithFloat(p: Parameter<Float?>, perform: @escaping (Float?) -> Void) -> Perform {
            return Perform(method: .imethodWithFloat__p_p(p), performs: perform)
        }
        static func methodWithDouble(p: Parameter<Double?>, perform: @escaping (Double?) -> Void) -> Perform {
            return Perform(method: .imethodWithDouble__p_p(p), performs: perform)
        }
        static func methodWithArrayOfInt(p: Parameter<[Int]>, perform: @escaping ([Int]) -> Void) -> Perform {
            return Perform(method: .imethodWithArrayOfInt__p_p(p), performs: perform)
        }
        static func methodWithArrayOfOther(p: Parameter<[SomeClass]>, perform: @escaping ([SomeClass]) -> Void) -> Perform {
            return Perform(method: .imethodWithArrayOfOther__p_p(p), performs: perform)
        }
        static func methodWithDict(p: Parameter<[String: SomeClass]>, perform: @escaping ([String: SomeClass]) -> Void) -> Perform {
            return Perform(method: .imethodWithDict__p_p(p), performs: perform)
        }
    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
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
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }
    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) { }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> Product {
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
}

// MARK: - ComplicatedServiceType
class ComplicatedServiceTypeMock: ComplicatedServiceType, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
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

    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyTestCase.onFatalFailure() // Prepare running test case that it should not continue
        XCTFail(message, file: file, line: line)
        #endif
    }


    var youCouldOnlyGetThis: String { 
		get {	invocations.append(.youCouldOnlyGetThis_get)
				return __youCouldOnlyGetThis.orFail("ComplicatedServiceTypeMock - value for youCouldOnlyGetThis was not defined") }
		set {	invocations.append(.youCouldOnlyGetThis_set(.value(newValue)))
				__youCouldOnlyGetThis = newValue }
	}
	private var __youCouldOnlyGetThis: (String)?

    struct Property {
        fileprivate var method: MethodType
        static var youCouldOnlyGetThis: Property { return Property(method: .youCouldOnlyGetThis_get) }
		static func youCouldOnlyGetThis(set newValue: Parameter<String>) -> Property { return Property(method: .youCouldOnlyGetThis_set(newValue)) }
    }


    func serviceName() -> String {
        addInvocation(.iserviceName)
		let perform = methodPerformValue(.iserviceName) as? () -> Void
		perform?()
		var __value: String
		do {
		    __value = try methodReturnValue(.iserviceName).casted()
		} catch {
			onFatalFailure("stub return value not specified for serviceName(). Use given")
			Failure("stub return value not specified for serviceName(). Use given")
		}
		return __value
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
		var __value: Point
		do {
		    __value = try methodReturnValue(.igetPoint__from_point(Parameter<Point>.value(point))).casted()
		} catch {
			onFatalFailure("stub return value not specified for getPoint(from point: Point). Use given")
			Failure("stub return value not specified for getPoint(from point: Point). Use given")
		}
		return __value
    }

    func getPoint(from tuple: (Float,Float)) -> Point {
        addInvocation(.igetPoint__from_tuple(Parameter<(Float,Float)>.value(tuple)))
		let perform = methodPerformValue(.igetPoint__from_tuple(Parameter<(Float,Float)>.value(tuple))) as? ((Float,Float)) -> Void
		perform?(tuple)
		var __value: Point
		do {
		    __value = try methodReturnValue(.igetPoint__from_tuple(Parameter<(Float,Float)>.value(tuple))).casted()
		} catch {
			onFatalFailure("stub return value not specified for getPoint(from tuple: (Float,Float)). Use given")
			Failure("stub return value not specified for getPoint(from tuple: (Float,Float)). Use given")
		}
		return __value
    }

    func similarMethodThatDiffersOnType(_ value: Float) -> Bool {
        addInvocation(.isimilarMethodThatDiffersOnType__value_1(Parameter<Float>.value(value)))
		let perform = methodPerformValue(.isimilarMethodThatDiffersOnType__value_1(Parameter<Float>.value(value))) as? (Float) -> Void
		perform?(value)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.isimilarMethodThatDiffersOnType__value_1(Parameter<Float>.value(value))).casted()
		} catch {
			onFatalFailure("stub return value not specified for similarMethodThatDiffersOnType(_ value: Float). Use given")
			Failure("stub return value not specified for similarMethodThatDiffersOnType(_ value: Float). Use given")
		}
		return __value
    }

    func similarMethodThatDiffersOnType(_ value: Point) -> Bool {
        addInvocation(.isimilarMethodThatDiffersOnType__value_2(Parameter<Point>.value(value)))
		let perform = methodPerformValue(.isimilarMethodThatDiffersOnType__value_2(Parameter<Point>.value(value))) as? (Point) -> Void
		perform?(value)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.isimilarMethodThatDiffersOnType__value_2(Parameter<Point>.value(value))).casted()
		} catch {
			onFatalFailure("stub return value not specified for similarMethodThatDiffersOnType(_ value: Point). Use given")
			Failure("stub return value not specified for similarMethodThatDiffersOnType(_ value: Point). Use given")
		}
		return __value
    }

    func methodWithTypedef(_ scalar: Scalar) {
        addInvocation(.imethodWithTypedef__scalar(Parameter<Scalar>.value(scalar)))
		let perform = methodPerformValue(.imethodWithTypedef__scalar(Parameter<Scalar>.value(scalar))) as? (Scalar) -> Void
		perform?(scalar)
    }

    func methodWithClosures(success function: LinearFunction) -> ClosureFabric {
        addInvocation(.imethodWithClosures__success_function_1(Parameter<LinearFunction>.value(function)))
		let perform = methodPerformValue(.imethodWithClosures__success_function_1(Parameter<LinearFunction>.value(function))) as? (LinearFunction) -> Void
		perform?(function)
		var __value: ClosureFabric
		do {
		    __value = try methodReturnValue(.imethodWithClosures__success_function_1(Parameter<LinearFunction>.value(function))).casted()
		} catch {
			onFatalFailure("stub return value not specified for methodWithClosures(success function: LinearFunction). Use given")
			Failure("stub return value not specified for methodWithClosures(success function: LinearFunction). Use given")
		}
		return __value
    }

    func methodWithClosures(success function: ((Scalar,Scalar) -> Scalar)?) -> ((Int) -> Void) {
        addInvocation(.imethodWithClosures__success_function_2(Parameter<((Scalar,Scalar) -> Scalar)?>.value(function)))
		let perform = methodPerformValue(.imethodWithClosures__success_function_2(Parameter<((Scalar,Scalar) -> Scalar)?>.value(function))) as? (((Scalar,Scalar) -> Scalar)?) -> Void
		perform?(function)
		var __value: (Int) -> Void
		do {
		    __value = try methodReturnValue(.imethodWithClosures__success_function_2(Parameter<((Scalar,Scalar) -> Scalar)?>.value(function))).casted()
		} catch {
			onFatalFailure("stub return value not specified for methodWithClosures(success function: ((Scalar,Scalar) -> Scalar)?). Use given")
			Failure("stub return value not specified for methodWithClosures(success function: ((Scalar,Scalar) -> Scalar)?). Use given")
		}
		return __value
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
        case youCouldOnlyGetThis_get
		case youCouldOnlyGetThis_set(Parameter<String>)

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
                case (.youCouldOnlyGetThis_get,.youCouldOnlyGetThis_get): return true
				case (.youCouldOnlyGetThis_set(let left),.youCouldOnlyGetThis_set(let right)): return Parameter<String>.compare(lhs: left, rhs: right, with: matcher)
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
                case .youCouldOnlyGetThis_get: return 0
				case .youCouldOnlyGetThis_set(let newValue): return newValue.intValue
            }
        }
    }

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

        static func serviceName(willReturn: String...) -> Given {
            return Given(method: .iserviceName, products: willReturn.map({ Product.return($0) }))
        }
        static func getPoint(from point: Parameter<Point>, willReturn: Point...) -> Given {
            return Given(method: .igetPoint__from_point(point), products: willReturn.map({ Product.return($0) }))
        }
        static func getPoint(from tuple: Parameter<(Float,Float)>, willReturn: Point...) -> Given {
            return Given(method: .igetPoint__from_tuple(tuple), products: willReturn.map({ Product.return($0) }))
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Float>, willReturn: Bool...) -> Given {
            return Given(method: .isimilarMethodThatDiffersOnType__value_1(value), products: willReturn.map({ Product.return($0) }))
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Point>, willReturn: Bool...) -> Given {
            return Given(method: .isimilarMethodThatDiffersOnType__value_2(value), products: willReturn.map({ Product.return($0) }))
        }
        static func methodWithClosures(success function: Parameter<LinearFunction>, willReturn: ClosureFabric...) -> Given {
            return Given(method: .imethodWithClosures__success_function_1(function), products: willReturn.map({ Product.return($0) }))
        }
        static func methodWithClosures(success function: Parameter<((Scalar,Scalar) -> Scalar)?>, willReturn: (Int) -> Void...) -> Given {
            return Given(method: .imethodWithClosures__success_function_2(function), products: willReturn.map({ Product.return($0) }))
        }
        static func serviceName(willProduce: (Stubber<String>) -> Void) -> Given {
            let willReturn: [String] = []
			let given: Given = { return Given(method: .iserviceName, products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (String).self)
			willProduce(stubber)
			return given
        }
        static func getPoint(from point: Parameter<Point>, willProduce: (Stubber<Point>) -> Void) -> Given {
            let willReturn: [Point] = []
			let given: Given = { return Given(method: .igetPoint__from_point(point), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Point).self)
			willProduce(stubber)
			return given
        }
        static func getPoint(from tuple: Parameter<(Float,Float)>, willProduce: (Stubber<Point>) -> Void) -> Given {
            let willReturn: [Point] = []
			let given: Given = { return Given(method: .igetPoint__from_tuple(tuple), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Point).self)
			willProduce(stubber)
			return given
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Float>, willProduce: (Stubber<Bool>) -> Void) -> Given {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .isimilarMethodThatDiffersOnType__value_1(value), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Point>, willProduce: (Stubber<Bool>) -> Void) -> Given {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .isimilarMethodThatDiffersOnType__value_2(value), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
        }
        static func methodWithClosures(success function: Parameter<LinearFunction>, willProduce: (Stubber<ClosureFabric>) -> Void) -> Given {
            let willReturn: [ClosureFabric] = []
			let given: Given = { return Given(method: .imethodWithClosures__success_function_1(function), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (ClosureFabric).self)
			willProduce(stubber)
			return given
        }
        static func methodWithClosures(success function: Parameter<((Scalar,Scalar) -> Scalar)?>, willProduce: (Stubber<(Int) -> Void>) -> Void) -> Given {
            let willReturn: [(Int) -> Void] = []
			let given: Given = { return Given(method: .imethodWithClosures__success_function_2(function), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: ((Int) -> Void).self)
			willProduce(stubber)
			return given
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

        static func serviceName(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .iserviceName, performs: perform)
        }
        static func aNewWayToSayHooray(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .iaNewWayToSayHooray, performs: perform)
        }
        static func getPoint(from point: Parameter<Point>, perform: @escaping (Point) -> Void) -> Perform {
            return Perform(method: .igetPoint__from_point(point), performs: perform)
        }
        static func getPoint(from tuple: Parameter<(Float,Float)>, perform: @escaping ((Float,Float)) -> Void) -> Perform {
            return Perform(method: .igetPoint__from_tuple(tuple), performs: perform)
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Float>, perform: @escaping (Float) -> Void) -> Perform {
            return Perform(method: .isimilarMethodThatDiffersOnType__value_1(value), performs: perform)
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Point>, perform: @escaping (Point) -> Void) -> Perform {
            return Perform(method: .isimilarMethodThatDiffersOnType__value_2(value), performs: perform)
        }
        static func methodWithTypedef(scalar: Parameter<Scalar>, perform: @escaping (Scalar) -> Void) -> Perform {
            return Perform(method: .imethodWithTypedef__scalar(scalar), performs: perform)
        }
        static func methodWithClosures(success function: Parameter<LinearFunction>, perform: @escaping (LinearFunction) -> Void) -> Perform {
            return Perform(method: .imethodWithClosures__success_function_1(function), performs: perform)
        }
        static func methodWithClosures(success function: Parameter<((Scalar,Scalar) -> Scalar)?>, perform: @escaping (((Scalar,Scalar) -> Scalar)?) -> Void) -> Perform {
            return Perform(method: .imethodWithClosures__success_function_2(function), performs: perform)
        }
    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
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
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(property.method)
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(property.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> Product {
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
}

// MARK: - DateSortable
class DateSortableMock: DateSortable, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
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

    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyTestCase.onFatalFailure() // Prepare running test case that it should not continue
        XCTFail(message, file: file, line: line)
        #endif
    }


    var date: Date { 
		get {	invocations.append(.date_get)
				return __date.orFail("DateSortableMock - value for date was not defined") }
		set {	invocations.append(.date_set(.value(newValue)))
				__date = newValue }
	}
	private var __date: (Date)?

    struct Property {
        fileprivate var method: MethodType
        static var date: Property { return Property(method: .date_get) }
		static func date(set newValue: Parameter<Date>) -> Property { return Property(method: .date_set(newValue)) }
    }


    fileprivate enum MethodType {
        case date_get
		case date_set(Parameter<Date>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.date_get,.date_get): return true
				case (.date_set(let left),.date_set(let right)): return Parameter<Date>.compare(lhs: left, rhs: right, with: matcher)
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case .date_get: return 0
				case .date_set(let newValue): return newValue.intValue
            }
        }
    }

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

    }

    struct Verify {
        fileprivate var method: MethodType

    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
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
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(property.method)
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(property.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> Product {
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
}

// MARK: - EmptyProtocol
class EmptyProtocolMock: EmptyProtocol, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
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

    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyTestCase.onFatalFailure() // Prepare running test case that it should not continue
        XCTFail(message, file: file, line: line)
        #endif
    }



    typealias Property = Swift.Never



    fileprivate struct MethodType {
        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool { return true }
        func intValue() -> Int { return 0 }
    }

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

    }

    struct Verify {
        fileprivate var method: MethodType

    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
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
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }
    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) { }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> Product {
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
}

// MARK: - GenericProtocolWithTypeConstraint
class GenericProtocolWithTypeConstraintMock: GenericProtocolWithTypeConstraint, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
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

    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyTestCase.onFatalFailure() // Prepare running test case that it should not continue
        XCTFail(message, file: file, line: line)
        #endif
    }



    typealias Property = Swift.Never


    func decode<T: Decodable>(_ type: T.Type, from data: Data) -> T {
        addInvocation(.idecode__typefrom_data(Parameter<T.Type>.value(type).wrapAsGeneric(), Parameter<Data>.value(data)))
		let perform = methodPerformValue(.idecode__typefrom_data(Parameter<T.Type>.value(type).wrapAsGeneric(), Parameter<Data>.value(data))) as? (T.Type, Data) -> Void
		perform?(type, data)
		var __value: T
		do {
		    __value = try methodReturnValue(.idecode__typefrom_data(Parameter<T.Type>.value(type).wrapAsGeneric(), Parameter<Data>.value(data))).casted()
		} catch {
			onFatalFailure("stub return value not specified for decode<T: Decodable>(_ type: T.Type, from data: Data). Use given")
			Failure("stub return value not specified for decode<T: Decodable>(_ type: T.Type, from data: Data). Use given")
		}
		return __value
    }

    func test<FOO>(_ type: FOO.Type) -> Int {
        addInvocation(.itest__type(Parameter<FOO.Type>.value(type).wrapAsGeneric()))
		let perform = methodPerformValue(.itest__type(Parameter<FOO.Type>.value(type).wrapAsGeneric())) as? (FOO.Type) -> Void
		perform?(type)
		var __value: Int
		do {
		    __value = try methodReturnValue(.itest__type(Parameter<FOO.Type>.value(type).wrapAsGeneric())).casted()
		} catch {
			onFatalFailure("stub return value not specified for test<FOO>(_ type: FOO.Type). Use given")
			Failure("stub return value not specified for test<FOO>(_ type: FOO.Type). Use given")
		}
		return __value
    }

    fileprivate enum MethodType {
        case idecode__typefrom_data(Parameter<GenericAttribute>, Parameter<Data>)
        case itest__type(Parameter<GenericAttribute>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.idecode__typefrom_data(let lhsType, let lhsData), .idecode__typefrom_data(let rhsType, let rhsData)):
                    guard Parameter.compare(lhs: lhsType, rhs: rhsType, with: matcher) else { return false } 
                    guard Parameter.compare(lhs: lhsData, rhs: rhsData, with: matcher) else { return false } 
                    return true 
                case (.itest__type(let lhsType), .itest__type(let rhsType)):
                    guard Parameter.compare(lhs: lhsType, rhs: rhsType, with: matcher) else { return false } 
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case let .idecode__typefrom_data(p0, p1): return p0.intValue + p1.intValue
                case let .itest__type(p0): return p0.intValue
            }
        }
    }

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

        static func decode<T: Decodable>(type: Parameter<T.Type>, from data: Parameter<Data>, willReturn: T...) -> Given {
            return Given(method: .idecode__typefrom_data(type.wrapAsGeneric(), data), products: willReturn.map({ Product.return($0) }))
        }
        static func test<FOO>(type: Parameter<FOO.Type>, willReturn: Int...) -> Given {
            return Given(method: .itest__type(type.wrapAsGeneric()), products: willReturn.map({ Product.return($0) }))
        }
        static func decode<T: Decodable>(type: Parameter<T.Type>, from data: Parameter<Data>, willProduce: (Stubber<T>) -> Void) -> Given {
            let willReturn: [T] = []
			let given: Given = { return Given(method: .idecode__typefrom_data(type.wrapAsGeneric(), data), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (T).self)
			willProduce(stubber)
			return given
        }
        static func test<FOO>(type: Parameter<FOO.Type>, willProduce: (Stubber<Int>) -> Void) -> Given {
            let willReturn: [Int] = []
			let given: Given = { return Given(method: .itest__type(type.wrapAsGeneric()), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Int).self)
			willProduce(stubber)
			return given
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func decode<T>(type: Parameter<T.Type>, from data: Parameter<Data>) -> Verify {
            return Verify(method: .idecode__typefrom_data(type.wrapAsGeneric(), data))
        }
        static func test<FOO>(type: Parameter<FOO.Type>) -> Verify {
            return Verify(method: .itest__type(type.wrapAsGeneric()))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func decode<T>(type: Parameter<T.Type>, from data: Parameter<Data>, perform: @escaping (T.Type, Data) -> Void) -> Perform {
            return Perform(method: .idecode__typefrom_data(type.wrapAsGeneric(), data), performs: perform)
        }
        static func test<FOO>(type: Parameter<FOO.Type>, perform: @escaping (FOO.Type) -> Void) -> Perform {
            return Perform(method: .itest__type(type.wrapAsGeneric()), performs: perform)
        }
    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
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
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }
    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) { }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> Product {
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
}

// MARK: - HistorySectionMapperType
class HistorySectionMapperTypeMock: HistorySectionMapperType, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
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

    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyTestCase.onFatalFailure() // Prepare running test case that it should not continue
        XCTFail(message, file: file, line: line)
        #endif
    }



    typealias Property = Swift.Never


    func map<T: DateSortable>(_ items: [T]) -> [(key: String, items: [T])] {
        addInvocation(.imap__items(Parameter<[T]>.value(items).wrapAsGeneric()))
		let perform = methodPerformValue(.imap__items(Parameter<[T]>.value(items).wrapAsGeneric())) as? ([T]) -> Void
		perform?(items)
		var __value: [(key: String, items: [T])]
		do {
		    __value = try methodReturnValue(.imap__items(Parameter<[T]>.value(items).wrapAsGeneric())).casted()
		} catch {
			onFatalFailure("stub return value not specified for map<T: DateSortable>(_ items: [T]). Use given")
			Failure("stub return value not specified for map<T: DateSortable>(_ items: [T]). Use given")
		}
		return __value
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

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

        static func map<T: DateSortable>(items: Parameter<[T]>, willReturn: [(key: String, items: [T])]...) -> Given {
            return Given(method: .imap__items(items.wrapAsGeneric()), products: willReturn.map({ Product.return($0) }))
        }
        static func map<T: DateSortable>(items: Parameter<[T]>, willProduce: (Stubber<[(key: String, items: [T])]>) -> Void) -> Given {
            let willReturn: [[(key: String, items: [T])]] = []
			let given: Given = { return Given(method: .imap__items(items.wrapAsGeneric()), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: ([(key: String, items: [T])]).self)
			willProduce(stubber)
			return given
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

        static func map<T>(items: Parameter<[T]>, perform: @escaping ([T]) -> Void) -> Perform {
            return Perform(method: .imap__items(items.wrapAsGeneric()), performs: perform)
        }
    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
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
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }
    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) { }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> Product {
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
}

// MARK: - NonSwiftProtocol
class NonSwiftProtocolMock: NSObject, NonSwiftProtocol, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
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

    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyTestCase.onFatalFailure() // Prepare running test case that it should not continue
        XCTFail(message, file: file, line: line)
        #endif
    }



    typealias Property = Swift.Never


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

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
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

        static func returnNoting(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .ireturnNoting, performs: perform)
        }
        static func someMethod(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .isomeMethod, performs: perform)
        }
    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
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
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }
    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) { }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> Product {
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
}

// MARK: - ProtocolMethodsGenericThatDifferOnlyInReturnType
class ProtocolMethodsGenericThatDifferOnlyInReturnTypeMock: ProtocolMethodsGenericThatDifferOnlyInReturnType, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
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

    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyTestCase.onFatalFailure() // Prepare running test case that it should not continue
        XCTFail(message, file: file, line: line)
        #endif
    }



    typealias Property = Swift.Never


    func foo<T>(bar: T) -> String {
        addInvocation(.ifoo__bar_bar_1(Parameter<T>.value(bar).wrapAsGeneric()))
		let perform = methodPerformValue(.ifoo__bar_bar_1(Parameter<T>.value(bar).wrapAsGeneric())) as? (T) -> Void
		perform?(bar)
		var __value: String
		do {
		    __value = try methodReturnValue(.ifoo__bar_bar_1(Parameter<T>.value(bar).wrapAsGeneric())).casted()
		} catch {
			onFatalFailure("stub return value not specified for foo<T>(bar: T). Use given")
			Failure("stub return value not specified for foo<T>(bar: T). Use given")
		}
		return __value
    }

    func foo<T>(bar: T) -> Int {
        addInvocation(.ifoo__bar_bar_2(Parameter<T>.value(bar).wrapAsGeneric()))
		let perform = methodPerformValue(.ifoo__bar_bar_2(Parameter<T>.value(bar).wrapAsGeneric())) as? (T) -> Void
		perform?(bar)
		var __value: Int
		do {
		    __value = try methodReturnValue(.ifoo__bar_bar_2(Parameter<T>.value(bar).wrapAsGeneric())).casted()
		} catch {
			onFatalFailure("stub return value not specified for foo<T>(bar: T). Use given")
			Failure("stub return value not specified for foo<T>(bar: T). Use given")
		}
		return __value
    }

    func foo<T>(bar: T) -> Float where T: A {
        addInvocation(.ifoo__bar_bar_4(Parameter<T>.value(bar).wrapAsGeneric()))
		let perform = methodPerformValue(.ifoo__bar_bar_4(Parameter<T>.value(bar).wrapAsGeneric())) as? (T) -> Void
		perform?(bar)
		var __value: Float
		do {
		    __value = try methodReturnValue(.ifoo__bar_bar_4(Parameter<T>.value(bar).wrapAsGeneric())).casted()
		} catch {
			onFatalFailure("stub return value not specified for foo<T>(bar: T). Use given")
			Failure("stub return value not specified for foo<T>(bar: T). Use given")
		}
		return __value
    }

    func foo<T>(bar: T) -> Float where T: B {
        addInvocation(.ifoo__bar_bar_4(Parameter<T>.value(bar).wrapAsGeneric()))
		let perform = methodPerformValue(.ifoo__bar_bar_4(Parameter<T>.value(bar).wrapAsGeneric())) as? (T) -> Void
		perform?(bar)
		var __value: Float
		do {
		    __value = try methodReturnValue(.ifoo__bar_bar_4(Parameter<T>.value(bar).wrapAsGeneric())).casted()
		} catch {
			onFatalFailure("stub return value not specified for foo<T>(bar: T). Use given")
			Failure("stub return value not specified for foo<T>(bar: T). Use given")
		}
		return __value
    }

    func foo<T>(bar: T) -> Double where T: B {
        addInvocation(.ifoo__bar_bar_5(Parameter<T>.value(bar).wrapAsGeneric()))
		let perform = methodPerformValue(.ifoo__bar_bar_5(Parameter<T>.value(bar).wrapAsGeneric())) as? (T) -> Void
		perform?(bar)
		var __value: Double
		do {
		    __value = try methodReturnValue(.ifoo__bar_bar_5(Parameter<T>.value(bar).wrapAsGeneric())).casted()
		} catch {
			onFatalFailure("stub return value not specified for foo<T>(bar: T). Use given")
			Failure("stub return value not specified for foo<T>(bar: T). Use given")
		}
		return __value
    }

    func foo<T>(bar: String) -> Array<T> {
        addInvocation(.ifoo__bar_bar_6(Parameter<String>.value(bar)))
		let perform = methodPerformValue(.ifoo__bar_bar_6(Parameter<String>.value(bar))) as? (String) -> Void
		perform?(bar)
		var __value: Array<T>
		do {
		    __value = try methodReturnValue(.ifoo__bar_bar_6(Parameter<String>.value(bar))).casted()
		} catch {
			onFatalFailure("stub return value not specified for foo<T>(bar: String). Use given")
			Failure("stub return value not specified for foo<T>(bar: String). Use given")
		}
		return __value
    }

    func foo<T>(bar: String) -> Set<T> {
        addInvocation(.ifoo__bar_bar_7(Parameter<String>.value(bar)))
		let perform = methodPerformValue(.ifoo__bar_bar_7(Parameter<String>.value(bar))) as? (String) -> Void
		perform?(bar)
		var __value: Set<T>
		do {
		    __value = try methodReturnValue(.ifoo__bar_bar_7(Parameter<String>.value(bar))).casted()
		} catch {
			onFatalFailure("stub return value not specified for foo<T>(bar: String). Use given")
			Failure("stub return value not specified for foo<T>(bar: String). Use given")
		}
		return __value
    }

    func foo<T>(bar: Bool) -> T where T: A {
        addInvocation(.ifoo__bar_bar_9(Parameter<Bool>.value(bar)))
		let perform = methodPerformValue(.ifoo__bar_bar_9(Parameter<Bool>.value(bar))) as? (Bool) -> Void
		perform?(bar)
		var __value: T
		do {
		    __value = try methodReturnValue(.ifoo__bar_bar_9(Parameter<Bool>.value(bar))).casted()
		} catch {
			onFatalFailure("stub return value not specified for foo<T>(bar: Bool). Use given")
			Failure("stub return value not specified for foo<T>(bar: Bool). Use given")
		}
		return __value
    }

    func foo<T>(bar: Bool) -> T where T: B {
        addInvocation(.ifoo__bar_bar_9(Parameter<Bool>.value(bar)))
		let perform = methodPerformValue(.ifoo__bar_bar_9(Parameter<Bool>.value(bar))) as? (Bool) -> Void
		perform?(bar)
		var __value: T
		do {
		    __value = try methodReturnValue(.ifoo__bar_bar_9(Parameter<Bool>.value(bar))).casted()
		} catch {
			onFatalFailure("stub return value not specified for foo<T>(bar: Bool). Use given")
			Failure("stub return value not specified for foo<T>(bar: Bool). Use given")
		}
		return __value
    }

    fileprivate enum MethodType {
        case ifoo__bar_bar_1(Parameter<GenericAttribute>)
        case ifoo__bar_bar_2(Parameter<GenericAttribute>)
        case ifoo__bar_bar_4(Parameter<GenericAttribute>)
        case ifoo__bar_bar_5(Parameter<GenericAttribute>)
        case ifoo__bar_bar_6(Parameter<String>)
        case ifoo__bar_bar_7(Parameter<String>)
        case ifoo__bar_bar_9(Parameter<Bool>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.ifoo__bar_bar_1(let lhsBar), .ifoo__bar_bar_1(let rhsBar)):
                    guard Parameter.compare(lhs: lhsBar, rhs: rhsBar, with: matcher) else { return false } 
                    return true 
                case (.ifoo__bar_bar_2(let lhsBar), .ifoo__bar_bar_2(let rhsBar)):
                    guard Parameter.compare(lhs: lhsBar, rhs: rhsBar, with: matcher) else { return false } 
                    return true 
                case (.ifoo__bar_bar_4(let lhsBar), .ifoo__bar_bar_4(let rhsBar)):
                    guard Parameter.compare(lhs: lhsBar, rhs: rhsBar, with: matcher) else { return false } 
                    return true 
                case (.ifoo__bar_bar_5(let lhsBar), .ifoo__bar_bar_5(let rhsBar)):
                    guard Parameter.compare(lhs: lhsBar, rhs: rhsBar, with: matcher) else { return false } 
                    return true 
                case (.ifoo__bar_bar_6(let lhsBar), .ifoo__bar_bar_6(let rhsBar)):
                    guard Parameter.compare(lhs: lhsBar, rhs: rhsBar, with: matcher) else { return false } 
                    return true 
                case (.ifoo__bar_bar_7(let lhsBar), .ifoo__bar_bar_7(let rhsBar)):
                    guard Parameter.compare(lhs: lhsBar, rhs: rhsBar, with: matcher) else { return false } 
                    return true 
                case (.ifoo__bar_bar_9(let lhsBar), .ifoo__bar_bar_9(let rhsBar)):
                    guard Parameter.compare(lhs: lhsBar, rhs: rhsBar, with: matcher) else { return false } 
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case let .ifoo__bar_bar_1(p0): return p0.intValue
                case let .ifoo__bar_bar_2(p0): return p0.intValue
                case let .ifoo__bar_bar_4(p0): return p0.intValue
                case let .ifoo__bar_bar_5(p0): return p0.intValue
                case let .ifoo__bar_bar_6(p0): return p0.intValue
                case let .ifoo__bar_bar_7(p0): return p0.intValue
                case let .ifoo__bar_bar_9(p0): return p0.intValue
            }
        }
    }

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

        static func foo<T>(bar: Parameter<T>, willReturn: String...) -> Given {
            return Given(method: .ifoo__bar_bar_1(bar.wrapAsGeneric()), products: willReturn.map({ Product.return($0) }))
        }
        static func foo<T>(bar: Parameter<T>, willReturn: Int...) -> Given {
            return Given(method: .ifoo__bar_bar_2(bar.wrapAsGeneric()), products: willReturn.map({ Product.return($0) }))
        }
        static func foo<T>(bar: Parameter<T>, willReturn: Float...) -> Given {
            return Given(method: .ifoo__bar_bar_4(bar.wrapAsGeneric()), products: willReturn.map({ Product.return($0) }))
        }
        static func foo<T>(bar: Parameter<T>, willReturn: Double...) -> Given {
            return Given(method: .ifoo__bar_bar_5(bar.wrapAsGeneric()), products: willReturn.map({ Product.return($0) }))
        }
        static func foo<T>(bar: Parameter<String>, willReturn: Array<T>...) -> Given {
            return Given(method: .ifoo__bar_bar_6(bar), products: willReturn.map({ Product.return($0) }))
        }
        static func foo<T>(bar: Parameter<String>, willReturn: Set<T>...) -> Given {
            return Given(method: .ifoo__bar_bar_7(bar), products: willReturn.map({ Product.return($0) }))
        }
        static func foo<T>(bar: Parameter<Bool>, willReturn: T...) -> Given {
            return Given(method: .ifoo__bar_bar_9(bar), products: willReturn.map({ Product.return($0) }))
        }
        static func foo<T>(bar: Parameter<T>, willProduce: (Stubber<String>) -> Void) -> Given {
            let willReturn: [String] = []
			let given: Given = { return Given(method: .ifoo__bar_bar_1(bar.wrapAsGeneric()), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (String).self)
			willProduce(stubber)
			return given
        }
        static func foo<T>(bar: Parameter<T>, willProduce: (Stubber<Int>) -> Void) -> Given {
            let willReturn: [Int] = []
			let given: Given = { return Given(method: .ifoo__bar_bar_2(bar.wrapAsGeneric()), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Int).self)
			willProduce(stubber)
			return given
        }
        static func foo<T>(bar: Parameter<T>, willProduce: (Stubber<Float>) -> Void) -> Given {
            let willReturn: [Float] = []
			let given: Given = { return Given(method: .ifoo__bar_bar_4(bar.wrapAsGeneric()), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Float).self)
			willProduce(stubber)
			return given
        }
        static func foo<T>(bar: Parameter<T>, willProduce: (Stubber<Double>) -> Void) -> Given {
            let willReturn: [Double] = []
			let given: Given = { return Given(method: .ifoo__bar_bar_5(bar.wrapAsGeneric()), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Double).self)
			willProduce(stubber)
			return given
        }
        static func foo<T>(bar: Parameter<String>, willProduce: (Stubber<Array<T>>) -> Void) -> Given {
            let willReturn: [Array<T>] = []
			let given: Given = { return Given(method: .ifoo__bar_bar_6(bar), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Array<T>).self)
			willProduce(stubber)
			return given
        }
        static func foo<T>(bar: Parameter<String>, willProduce: (Stubber<Set<T>>) -> Void) -> Given {
            let willReturn: [Set<T>] = []
			let given: Given = { return Given(method: .ifoo__bar_bar_7(bar), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Set<T>).self)
			willProduce(stubber)
			return given
        }
        static func foo<T>(bar: Parameter<Bool>, willProduce: (Stubber<T>) -> Void) -> Given {
            let willReturn: [T] = []
			let given: Given = { return Given(method: .ifoo__bar_bar_9(bar), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (T).self)
			willProduce(stubber)
			return given
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func foo<T>(bar: Parameter<T>, returning: String.Type) -> Verify {
            return Verify(method: .ifoo__bar_bar_1(bar.wrapAsGeneric()))
        }
        static func foo<T>(bar: Parameter<T>, returning: Int.Type) -> Verify {
            return Verify(method: .ifoo__bar_bar_2(bar.wrapAsGeneric()))
        }
        static func foo<T>(bar: Parameter<T>, returning: Float.Type) -> Verify {
            return Verify(method: .ifoo__bar_bar_4(bar.wrapAsGeneric()))
        }
        static func foo<T>(bar: Parameter<T>, returning: Double.Type) -> Verify {
            return Verify(method: .ifoo__bar_bar_5(bar.wrapAsGeneric()))
        }
        static func foo<T>(bar: Parameter<String>, returning: Array<T>.Type) -> Verify {
            return Verify(method: .ifoo__bar_bar_6(bar))
        }
        static func foo<T>(bar: Parameter<String>, returning: Set<T>.Type) -> Verify {
            return Verify(method: .ifoo__bar_bar_7(bar))
        }
        static func foo<T>(bar: Parameter<Bool>, returning: T.Type) -> Verify {
            return Verify(method: .ifoo__bar_bar_9(bar))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func foo<T>(bar: Parameter<T>, returning: String.Type, perform: @escaping (T) -> Void) -> Perform {
            return Perform(method: .ifoo__bar_bar_1(bar.wrapAsGeneric()), performs: perform)
        }
        static func foo<T>(bar: Parameter<T>, returning: Int.Type, perform: @escaping (T) -> Void) -> Perform {
            return Perform(method: .ifoo__bar_bar_2(bar.wrapAsGeneric()), performs: perform)
        }
        static func foo<T>(bar: Parameter<T>, returning: Float.Type, perform: @escaping (T) -> Void) -> Perform {
            return Perform(method: .ifoo__bar_bar_4(bar.wrapAsGeneric()), performs: perform)
        }
        static func foo<T>(bar: Parameter<T>, returning: Double.Type, perform: @escaping (T) -> Void) -> Perform {
            return Perform(method: .ifoo__bar_bar_5(bar.wrapAsGeneric()), performs: perform)
        }
        static func foo<T>(bar: Parameter<String>, returning: Array<T>.Type, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .ifoo__bar_bar_6(bar), performs: perform)
        }
        static func foo<T>(bar: Parameter<String>, returning: Set<T>.Type, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .ifoo__bar_bar_7(bar), performs: perform)
        }
        static func foo<T>(bar: Parameter<Bool>, returning: T.Type, perform: @escaping (Bool) -> Void) -> Perform {
            return Perform(method: .ifoo__bar_bar_9(bar), performs: perform)
        }
    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
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
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }
    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) { }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> Product {
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
}

// MARK: - ProtocolMethodsThatDifferOnlyInReturnType
class ProtocolMethodsThatDifferOnlyInReturnTypeMock: ProtocolMethodsThatDifferOnlyInReturnType, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
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

    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyTestCase.onFatalFailure() // Prepare running test case that it should not continue
        XCTFail(message, file: file, line: line)
        #endif
    }



    typealias Property = Swift.Never


    func foo(bar: String) -> String {
        addInvocation(.ifoo__bar_bar_1(Parameter<String>.value(bar)))
		let perform = methodPerformValue(.ifoo__bar_bar_1(Parameter<String>.value(bar))) as? (String) -> Void
		perform?(bar)
		var __value: String
		do {
		    __value = try methodReturnValue(.ifoo__bar_bar_1(Parameter<String>.value(bar))).casted()
		} catch {
			onFatalFailure("stub return value not specified for foo(bar: String). Use given")
			Failure("stub return value not specified for foo(bar: String). Use given")
		}
		return __value
    }

    func foo(bar: String) -> Int {
        addInvocation(.ifoo__bar_bar_2(Parameter<String>.value(bar)))
		let perform = methodPerformValue(.ifoo__bar_bar_2(Parameter<String>.value(bar))) as? (String) -> Void
		perform?(bar)
		var __value: Int
		do {
		    __value = try methodReturnValue(.ifoo__bar_bar_2(Parameter<String>.value(bar))).casted()
		} catch {
			onFatalFailure("stub return value not specified for foo(bar: String). Use given")
			Failure("stub return value not specified for foo(bar: String). Use given")
		}
		return __value
    }

    fileprivate enum MethodType {
        case ifoo__bar_bar_1(Parameter<String>)
        case ifoo__bar_bar_2(Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.ifoo__bar_bar_1(let lhsBar), .ifoo__bar_bar_1(let rhsBar)):
                    guard Parameter.compare(lhs: lhsBar, rhs: rhsBar, with: matcher) else { return false } 
                    return true 
                case (.ifoo__bar_bar_2(let lhsBar), .ifoo__bar_bar_2(let rhsBar)):
                    guard Parameter.compare(lhs: lhsBar, rhs: rhsBar, with: matcher) else { return false } 
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case let .ifoo__bar_bar_1(p0): return p0.intValue
                case let .ifoo__bar_bar_2(p0): return p0.intValue
            }
        }
    }

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

        static func foo(bar: Parameter<String>, willReturn: String...) -> Given {
            return Given(method: .ifoo__bar_bar_1(bar), products: willReturn.map({ Product.return($0) }))
        }
        static func foo(bar: Parameter<String>, willReturn: Int...) -> Given {
            return Given(method: .ifoo__bar_bar_2(bar), products: willReturn.map({ Product.return($0) }))
        }
        static func foo(bar: Parameter<String>, willProduce: (Stubber<String>) -> Void) -> Given {
            let willReturn: [String] = []
			let given: Given = { return Given(method: .ifoo__bar_bar_1(bar), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (String).self)
			willProduce(stubber)
			return given
        }
        static func foo(bar: Parameter<String>, willProduce: (Stubber<Int>) -> Void) -> Given {
            let willReturn: [Int] = []
			let given: Given = { return Given(method: .ifoo__bar_bar_2(bar), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Int).self)
			willProduce(stubber)
			return given
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func foo(bar: Parameter<String>, returning: String.Type) -> Verify {
            return Verify(method: .ifoo__bar_bar_1(bar))
        }
        static func foo(bar: Parameter<String>, returning: Int.Type) -> Verify {
            return Verify(method: .ifoo__bar_bar_2(bar))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func foo(bar: Parameter<String>, returning: String.Type, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .ifoo__bar_bar_1(bar), performs: perform)
        }
        static func foo(bar: Parameter<String>, returning: Int.Type, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .ifoo__bar_bar_2(bar), performs: perform)
        }
    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
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
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }
    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) { }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> Product {
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
}

// MARK: - ProtocolWithAssociatedType
class ProtocolWithAssociatedTypeMock<TypeT>: ProtocolWithAssociatedType, Mock where TypeT: Sequence {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }


	typealias T = TypeT

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyTestCase.onFatalFailure() // Prepare running test case that it should not continue
        XCTFail(message, file: file, line: line)
        #endif
    }


    var sequence: T { 
		get {	invocations.append(.sequence_get)
				return __sequence.orFail("ProtocolWithAssociatedTypeMock - value for sequence was not defined") }
		set {	invocations.append(.sequence_set(.value(newValue)))
				__sequence = newValue }
	}
	private var __sequence: (T)?

    struct Property {
        fileprivate var method: MethodType
        static var sequence: Property { return Property(method: .sequence_get) }
		static func sequence(set newValue: Parameter<T>) -> Property { return Property(method: .sequence_set(newValue)) }
    }


    func methodWithType(t: T) -> Bool {
        addInvocation(.imethodWithType__t_t(Parameter<T>.value(t)))
		let perform = methodPerformValue(.imethodWithType__t_t(Parameter<T>.value(t))) as? (T) -> Void
		perform?(t)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.imethodWithType__t_t(Parameter<T>.value(t))).casted()
		} catch {
			onFatalFailure("stub return value not specified for methodWithType(t: T). Use given")
			Failure("stub return value not specified for methodWithType(t: T). Use given")
		}
		return __value
    }

    fileprivate enum MethodType {
        case imethodWithType__t_t(Parameter<T>)
        case sequence_get
		case sequence_set(Parameter<T>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.imethodWithType__t_t(let lhsT), .imethodWithType__t_t(let rhsT)):
                    guard Parameter.compare(lhs: lhsT, rhs: rhsT, with: matcher) else { return false } 
                    return true 
                case (.sequence_get,.sequence_get): return true
				case (.sequence_set(let left),.sequence_set(let right)): return Parameter<T>.compare(lhs: left, rhs: right, with: matcher)
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case let .imethodWithType__t_t(p0): return p0.intValue
                case .sequence_get: return 0
				case .sequence_set(let newValue): return newValue.intValue
            }
        }
    }

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

        static func methodWithType(t: Parameter<T>, willReturn: Bool...) -> Given {
            return Given(method: .imethodWithType__t_t(t), products: willReturn.map({ Product.return($0) }))
        }
        static func methodWithType(t: Parameter<T>, willProduce: (Stubber<Bool>) -> Void) -> Given {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .imethodWithType__t_t(t), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
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

        static func methodWithType(t: Parameter<T>, perform: @escaping (T) -> Void) -> Perform {
            return Perform(method: .imethodWithType__t_t(t), performs: perform)
        }
    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
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
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(property.method)
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(property.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> Product {
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
}

// MARK: - ProtocolWithClosures
class ProtocolWithClosuresMock: ProtocolWithClosures, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
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

    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyTestCase.onFatalFailure() // Prepare running test case that it should not continue
        XCTFail(message, file: file, line: line)
        #endif
    }



    typealias Property = Swift.Never


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

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
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

        static func methodThatTakes(closure: Parameter<(Int) -> Int>, perform: @escaping ((Int) -> Int) -> Void) -> Perform {
            return Perform(method: .imethodThatTakes__closure_closure(closure), performs: perform)
        }
        static func methodThatTakesEscaping(closure: Parameter<(Int) -> Int>, perform: @escaping (@escaping (Int) -> Int) -> Void) -> Perform {
            return Perform(method: .imethodThatTakesEscaping__closure_closure(closure), performs: perform)
        }
        static func methodThatTakesCompletionBlock(completion: Parameter<(Bool,Error?) -> Void>, perform: @escaping ((Bool,Error?) -> Void) -> Void) -> Perform {
            return Perform(method: .imethodThatTakesCompletionBlock__completion_completion(completion), performs: perform)
        }
    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
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
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }
    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) { }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> Product {
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
}

// MARK: - ProtocolWithCustomAttributes
class ProtocolWithCustomAttributesMock: ProtocolWithCustomAttributes, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
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

    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyTestCase.onFatalFailure() // Prepare running test case that it should not continue
        XCTFail(message, file: file, line: line)
        #endif
    }



    typealias Property = Swift.Never


    func methodThatTakesUser(user: UserObject) throws {
        addInvocation(.imethodThatTakesUser__user_user(Parameter<UserObject>.value(user)))
		let perform = methodPerformValue(.imethodThatTakesUser__user_user(Parameter<UserObject>.value(user))) as? (UserObject) -> Void
		perform?(user)
		var __value: Void
		do {
		    __value = try methodReturnValue(.imethodThatTakesUser__user_user(Parameter<UserObject>.value(user))).casted()
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }

    func methodThatTakesArrayOfUsers(array: [UserObject]) -> Int {
        addInvocation(.imethodThatTakesArrayOfUsers__array_array(Parameter<[UserObject]>.value(array)))
		let perform = methodPerformValue(.imethodThatTakesArrayOfUsers__array_array(Parameter<[UserObject]>.value(array))) as? ([UserObject]) -> Void
		perform?(array)
		var __value: Int
		do {
		    __value = try methodReturnValue(.imethodThatTakesArrayOfUsers__array_array(Parameter<[UserObject]>.value(array))).casted()
		} catch {
			onFatalFailure("stub return value not specified for methodThatTakesArrayOfUsers(array: [UserObject]). Use given")
			Failure("stub return value not specified for methodThatTakesArrayOfUsers(array: [UserObject]). Use given")
		}
		return __value
    }

    fileprivate enum MethodType {
        case imethodThatTakesUser__user_user(Parameter<UserObject>)
        case imethodThatTakesArrayOfUsers__array_array(Parameter<[UserObject]>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
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
                case let .imethodThatTakesUser__user_user(p0): return p0.intValue
                case let .imethodThatTakesArrayOfUsers__array_array(p0): return p0.intValue
            }
        }
    }

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

        static func methodThatTakesArrayOfUsers(array: Parameter<[UserObject]>, willReturn: Int...) -> Given {
            return Given(method: .imethodThatTakesArrayOfUsers__array_array(array), products: willReturn.map({ Product.return($0) }))
        }
        static func methodThatTakesArrayOfUsers(array: Parameter<[UserObject]>, willProduce: (Stubber<Int>) -> Void) -> Given {
            let willReturn: [Int] = []
			let given: Given = { return Given(method: .imethodThatTakesArrayOfUsers__array_array(array), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Int).self)
			willProduce(stubber)
			return given
        }
        static func methodThatTakesUser(user: Parameter<UserObject>, willThrow: Error...) -> Given {
            return Given(method: .imethodThatTakesUser__user_user(user), products: willThrow.map({ Product.throw($0) }))
        }
        static func methodThatTakesUser(user: Parameter<UserObject>, willProduce: (StubberThrows<Void>) -> Void) -> Given {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .imethodThatTakesUser__user_user(user), products: willThrow.map({ Product.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
    }

    struct Verify {
        fileprivate var method: MethodType

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

        static func methodThatTakesUser(user: Parameter<UserObject>, perform: @escaping (UserObject) -> Void) -> Perform {
            return Perform(method: .imethodThatTakesUser__user_user(user), performs: perform)
        }
        static func methodThatTakesArrayOfUsers(array: Parameter<[UserObject]>, perform: @escaping ([UserObject]) -> Void) -> Perform {
            return Perform(method: .imethodThatTakesArrayOfUsers__array_array(array), performs: perform)
        }
    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
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
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }
    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) { }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> Product {
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
}

// MARK: - ProtocolWithGenericMethods
class ProtocolWithGenericMethodsMock: ProtocolWithGenericMethods, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
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

    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyTestCase.onFatalFailure() // Prepare running test case that it should not continue
        XCTFail(message, file: file, line: line)
        #endif
    }



    typealias Property = Swift.Never


    func methodWithGeneric<T>(lhs: T, rhs: T) -> Bool {
        addInvocation(.imethodWithGeneric__lhs_lhsrhs_rhs(Parameter<T>.value(lhs).wrapAsGeneric(), Parameter<T>.value(rhs).wrapAsGeneric()))
		let perform = methodPerformValue(.imethodWithGeneric__lhs_lhsrhs_rhs(Parameter<T>.value(lhs).wrapAsGeneric(), Parameter<T>.value(rhs).wrapAsGeneric())) as? (T, T) -> Void
		perform?(lhs, rhs)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.imethodWithGeneric__lhs_lhsrhs_rhs(Parameter<T>.value(lhs).wrapAsGeneric(), Parameter<T>.value(rhs).wrapAsGeneric())).casted()
		} catch {
			onFatalFailure("stub return value not specified for methodWithGeneric<T>(lhs: T, rhs: T). Use given")
			Failure("stub return value not specified for methodWithGeneric<T>(lhs: T, rhs: T). Use given")
		}
		return __value
    }

    func methodWithGenericConstraint<U>(param: [U]) -> U where U: Equatable {
        addInvocation(.imethodWithGenericConstraint__param_param(Parameter<[U]>.value(param).wrapAsGeneric()))
		let perform = methodPerformValue(.imethodWithGenericConstraint__param_param(Parameter<[U]>.value(param).wrapAsGeneric())) as? ([U]) -> Void
		perform?(param)
		var __value: U
		do {
		    __value = try methodReturnValue(.imethodWithGenericConstraint__param_param(Parameter<[U]>.value(param).wrapAsGeneric())).casted()
		} catch {
			onFatalFailure("stub return value not specified for methodWithGenericConstraint<U>(param: [U]). Use given")
			Failure("stub return value not specified for methodWithGenericConstraint<U>(param: [U]). Use given")
		}
		return __value
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

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

        static func methodWithGeneric<T>(lhs: Parameter<T>, rhs: Parameter<T>, willReturn: Bool...) -> Given {
            return Given(method: .imethodWithGeneric__lhs_lhsrhs_rhs(lhs.wrapAsGeneric(), rhs.wrapAsGeneric()), products: willReturn.map({ Product.return($0) }))
        }
        static func methodWithGenericConstraint<U>(param: Parameter<[U]>, willReturn: U...) -> Given {
            return Given(method: .imethodWithGenericConstraint__param_param(param.wrapAsGeneric()), products: willReturn.map({ Product.return($0) }))
        }
        static func methodWithGeneric<T>(lhs: Parameter<T>, rhs: Parameter<T>, willProduce: (Stubber<Bool>) -> Void) -> Given {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .imethodWithGeneric__lhs_lhsrhs_rhs(lhs.wrapAsGeneric(), rhs.wrapAsGeneric()), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
        }
        static func methodWithGenericConstraint<U>(param: Parameter<[U]>, willProduce: (Stubber<U>) -> Void) -> Given {
            let willReturn: [U] = []
			let given: Given = { return Given(method: .imethodWithGenericConstraint__param_param(param.wrapAsGeneric()), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (U).self)
			willProduce(stubber)
			return given
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

        static func methodWithGeneric<T>(lhs: Parameter<T>, rhs: Parameter<T>, perform: @escaping (T, T) -> Void) -> Perform {
            return Perform(method: .imethodWithGeneric__lhs_lhsrhs_rhs(lhs.wrapAsGeneric(), rhs.wrapAsGeneric()), performs: perform)
        }
        static func methodWithGenericConstraint<U>(param: Parameter<[U]>, perform: @escaping ([U]) -> Void) -> Perform {
            return Perform(method: .imethodWithGenericConstraint__param_param(param.wrapAsGeneric()), performs: perform)
        }
    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
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
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }
    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) { }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> Product {
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
}

// MARK: - ProtocolWithGenericMethodsNested
class ProtocolWithGenericMethodsNestedMock: ProtocolWithGenericMethodsNested, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
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

    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyTestCase.onFatalFailure() // Prepare running test case that it should not continue
        XCTFail(message, file: file, line: line)
        #endif
    }



    typealias Property = Swift.Never


    func methodWithGeneric<T>(resource: Resource<T>) -> Observable<Response<T>> {
        addInvocation(.imethodWithGeneric__resource_resource(Parameter<Resource<T>>.value(resource).wrapAsGeneric()))
		let perform = methodPerformValue(.imethodWithGeneric__resource_resource(Parameter<Resource<T>>.value(resource).wrapAsGeneric())) as? (Resource<T>) -> Void
		perform?(resource)
		var __value: Observable<Response<T>>
		do {
		    __value = try methodReturnValue(.imethodWithGeneric__resource_resource(Parameter<Resource<T>>.value(resource).wrapAsGeneric())).casted()
		} catch {
			onFatalFailure("stub return value not specified for methodWithGeneric<T>(resource: Resource<T>). Use given")
			Failure("stub return value not specified for methodWithGeneric<T>(resource: Resource<T>). Use given")
		}
		return __value
    }

    fileprivate enum MethodType {
        case imethodWithGeneric__resource_resource(Parameter<GenericAttribute>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.imethodWithGeneric__resource_resource(let lhsResource), .imethodWithGeneric__resource_resource(let rhsResource)):
                    guard Parameter.compare(lhs: lhsResource, rhs: rhsResource, with: matcher) else { return false } 
                    return true 
            }
        }

        func intValue() -> Int {
            switch self {
                case let .imethodWithGeneric__resource_resource(p0): return p0.intValue
            }
        }
    }

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

        static func methodWithGeneric<T>(resource: Parameter<Resource<T>>, willReturn: Observable<Response<T>>...) -> Given {
            return Given(method: .imethodWithGeneric__resource_resource(resource.wrapAsGeneric()), products: willReturn.map({ Product.return($0) }))
        }
        static func methodWithGeneric<T>(resource: Parameter<Resource<T>>, willProduce: (Stubber<Observable<Response<T>>>) -> Void) -> Given {
            let willReturn: [Observable<Response<T>>] = []
			let given: Given = { return Given(method: .imethodWithGeneric__resource_resource(resource.wrapAsGeneric()), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Observable<Response<T>>).self)
			willProduce(stubber)
			return given
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func methodWithGeneric<T>(resource: Parameter<Resource<T>>) -> Verify {
            return Verify(method: .imethodWithGeneric__resource_resource(resource.wrapAsGeneric()))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func methodWithGeneric<T>(resource: Parameter<Resource<T>>, perform: @escaping (Resource<T>) -> Void) -> Perform {
            return Perform(method: .imethodWithGeneric__resource_resource(resource.wrapAsGeneric()), performs: perform)
        }
    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
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
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }
    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) { }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> Product {
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
}

// MARK: - ProtocolWithInitializers
class ProtocolWithInitializersMock: ProtocolWithInitializers, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
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

    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyTestCase.onFatalFailure() // Prepare running test case that it should not continue
        XCTFail(message, file: file, line: line)
        #endif
    }


    var param: Int { 
		get {	invocations.append(.param_get)
				return __param.orFail("ProtocolWithInitializersMock - value for param was not defined") }
		set {	invocations.append(.param_set(.value(newValue)))
				__param = newValue }
	}
	private var __param: (Int)?
    var other: String { 
		get {	invocations.append(.other_get)
				return __other.orFail("ProtocolWithInitializersMock - value for other was not defined") }
		set {	invocations.append(.other_set(.value(newValue)))
				__other = newValue }
	}
	private var __other: (String)?

    struct Property {
        fileprivate var method: MethodType
        static var param: Property { return Property(method: .param_get) }
		static func param(set newValue: Parameter<Int>) -> Property { return Property(method: .param_set(newValue)) }
        static var other: Property { return Property(method: .other_get) }
		static func other(set newValue: Parameter<String>) -> Property { return Property(method: .other_set(newValue)) }
    }


    required init(param: Int, other: String) { }

    required init(param: Int) { }

    fileprivate enum MethodType {
        case param_get
		case param_set(Parameter<Int>)
        case other_get
		case other_set(Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.param_get,.param_get): return true
				case (.param_set(let left),.param_set(let right)): return Parameter<Int>.compare(lhs: left, rhs: right, with: matcher)
                case (.other_get,.other_get): return true
				case (.other_set(let left),.other_set(let right)): return Parameter<String>.compare(lhs: left, rhs: right, with: matcher)
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case .param_get: return 0
				case .param_set(let newValue): return newValue.intValue
                case .other_get: return 0
				case .other_set(let newValue): return newValue.intValue
            }
        }
    }

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

    }

    struct Verify {
        fileprivate var method: MethodType

    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
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
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(property.method)
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(property.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> Product {
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
}

// MARK: - ProtocolWithPropoerties
class ProtocolWithPropoertiesMock: ProtocolWithPropoerties, Mock, StaticMock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
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

    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyTestCase.onFatalFailure() // Prepare running test case that it should not continue
        XCTFail(message, file: file, line: line)
        #endif
    }

    static var matcher: Matcher = Matcher.default
    static var stubbingPolicy: StubbingPolicy = .wrap
    static var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    static private var invocations: [StaticMethodType] = []
    static private var methodReturnValues: [StaticGiven] = []
    static private var methodPerformValues: [StaticPerform] = []
    static func clear() {
        invocations = []
        methodReturnValues = []
        methodPerformValues = []
    }

    var name: String { 
		get {	invocations.append(.name_get)
				return __name.orFail("ProtocolWithPropoertiesMock - value for name was not defined") }
		set {	invocations.append(.name_set(.value(newValue)))
				__name = newValue }
	}
	private var __name: (String)?
    var email: String? { 
		get {	invocations.append(.email_get)
				return __email }
		set {	invocations.append(.email_set(.value(newValue)))
				__email = newValue }
	}
	private var __email: (String)?

    struct Property {
        fileprivate var method: MethodType
        static var name: Property { return Property(method: .name_get) }
		static func name(set newValue: Parameter<String>) -> Property { return Property(method: .name_set(newValue)) }
        static var email: Property { return Property(method: .email_get) }
		static func email(set newValue: Parameter<String?>) -> Property { return Property(method: .email_set(newValue)) }
    }
    static var name: String { 
		get {	ProtocolWithPropoertiesMock.invocations.append(.name_get)
				return ProtocolWithPropoertiesMock.__name.orFail("ProtocolWithPropoertiesMock - value for name was not defined") }
		set {	ProtocolWithPropoertiesMock.invocations.append(.name_set(.value(newValue)))
				ProtocolWithPropoertiesMock.__name = newValue }
	}
	private static var __name: (String)?
    static var defaultEmail: String? { 
		get {	ProtocolWithPropoertiesMock.invocations.append(.defaultEmail_get)
				return ProtocolWithPropoertiesMock.__defaultEmail }
		set {	ProtocolWithPropoertiesMock.invocations.append(.defaultEmail_set(.value(newValue)))
				ProtocolWithPropoertiesMock.__defaultEmail = newValue }
	}
	private static var __defaultEmail: (String)?

    struct StaticProperty {
        fileprivate var method: StaticMethodType
        static var name: StaticProperty { return StaticProperty(method: .name_get) }
		static func name(set newValue: Parameter<String>) -> StaticProperty { return StaticProperty(method: .name_set(newValue)) }
        static var defaultEmail: StaticProperty { return StaticProperty(method: .defaultEmail_get) }
		static func defaultEmail(set newValue: Parameter<String?>) -> StaticProperty { return StaticProperty(method: .defaultEmail_set(newValue)) }
    }

    static func defaultEmail(set newValue: String!) {
        addInvocation(.sdefaultEmail__set_newValue(Parameter<String?>.value(newValue)))
		let perform = methodPerformValue(.sdefaultEmail__set_newValue(Parameter<String?>.value(newValue))) as? (String!) -> Void
		perform?(newValue)
    }

    func name(set newValue: String) {
        addInvocation(.iname__set_newValue(Parameter<String>.value(newValue)))
		let perform = methodPerformValue(.iname__set_newValue(Parameter<String>.value(newValue))) as? (String) -> Void
		perform?(newValue)
    }

    func email(set: String!) {
        addInvocation(.iemail__set_set(Parameter<String?>.value(set)))
		let perform = methodPerformValue(.iemail__set_set(Parameter<String?>.value(set))) as? (String!) -> Void
		perform?(set)
    }

    fileprivate enum StaticMethodType {
        case sdefaultEmail__set_newValue(Parameter<String?>)

        case name_get
		case name_set(Parameter<String>)
        case defaultEmail_get
		case defaultEmail_set(Parameter<String?>)

        static func compareParameters(lhs: StaticMethodType, rhs: StaticMethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.sdefaultEmail__set_newValue(let lhsNewvalue), .sdefaultEmail__set_newValue(let rhsNewvalue)):
                    guard Parameter.compare(lhs: lhsNewvalue, rhs: rhsNewvalue, with: matcher) else { return false } 
                    return true 
                case (.name_get,.name_get): return true
				case (.name_set(let left),.name_set(let right)): return Parameter<String>.compare(lhs: left, rhs: right, with: matcher)
                case (.defaultEmail_get,.defaultEmail_get): return true
				case (.defaultEmail_set(let left),.defaultEmail_set(let right)): return Parameter<String?>.compare(lhs: left, rhs: right, with: matcher)
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case let .sdefaultEmail__set_newValue(p0): return p0.intValue
                case .name_get: return 0
				case .name_set(let newValue): return newValue.intValue
                case .defaultEmail_get: return 0
				case .defaultEmail_set(let newValue): return newValue.intValue
            }
        }
    }

    class StaticGiven: StubbedMethod {
        fileprivate var method: StaticMethodType

        private init(method: StaticMethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

    }

    struct StaticVerify {
        fileprivate var method: StaticMethodType

        static func defaultEmail(set newValue: Parameter<String?>) -> StaticVerify {
            return StaticVerify(method: .sdefaultEmail__set_newValue(newValue))
        }
    }

    struct StaticPerform {
        fileprivate var method: StaticMethodType
        var performs: Any

        static func defaultEmail(set newValue: Parameter<String?>, perform: @escaping (String!) -> Void) -> StaticPerform {
            return StaticPerform(method: .sdefaultEmail__set_newValue(newValue), performs: perform)
        }
    }

        fileprivate enum MethodType {
        case iname__set_newValue(Parameter<String>)
        case iemail__set_set(Parameter<String?>)
        case name_get
		case name_set(Parameter<String>)
        case email_get
		case email_set(Parameter<String?>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.iname__set_newValue(let lhsNewvalue), .iname__set_newValue(let rhsNewvalue)):
                    guard Parameter.compare(lhs: lhsNewvalue, rhs: rhsNewvalue, with: matcher) else { return false } 
                    return true 
                case (.iemail__set_set(let lhsSet), .iemail__set_set(let rhsSet)):
                    guard Parameter.compare(lhs: lhsSet, rhs: rhsSet, with: matcher) else { return false } 
                    return true 
                case (.name_get,.name_get): return true
				case (.name_set(let left),.name_set(let right)): return Parameter<String>.compare(lhs: left, rhs: right, with: matcher)
                case (.email_get,.email_get): return true
				case (.email_set(let left),.email_set(let right)): return Parameter<String?>.compare(lhs: left, rhs: right, with: matcher)
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case let .iname__set_newValue(p0): return p0.intValue
                case let .iemail__set_set(p0): return p0.intValue
                case .name_get: return 0
				case .name_set(let newValue): return newValue.intValue
                case .email_get: return 0
				case .email_set(let newValue): return newValue.intValue
            }
        }
    }

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

    }

    struct Verify {
        fileprivate var method: MethodType

        static func name(set newValue: Parameter<String>) -> Verify {
            return Verify(method: .iname__set_newValue(newValue))
        }
        static func email(set: Parameter<String?>) -> Verify {
            return Verify(method: .iemail__set_set(set))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func name(set newValue: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .iname__set_newValue(newValue), performs: perform)
        }
        static func email(set: Parameter<String?>, perform: @escaping (String!) -> Void) -> Perform {
            return Perform(method: .iemail__set_set(set), performs: perform)
        }
    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
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
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(property.method)
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(property.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> Product {
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

    static private func matchingCalls(_ method: StaticVerify) -> Int {
        return matchingCalls(method.method).count
    }

    static public func given(_ method: StaticGiven) {
        methodReturnValues.append(method)
    }

    static public func perform(_ method: StaticPerform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    static public func verify(_ method: StaticVerify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    static public func verify(property: StaticProperty, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(property.method)
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(property.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    static private func addInvocation(_ call: StaticMethodType) {
        invocations.append(call)
    }

    static private func methodReturnValue(_ method: StaticMethodType) throws -> Product {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && StaticMethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }

    static private func methodPerformValue(_ method: StaticMethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { StaticMethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    static private func matchingCalls(_ method: StaticMethodType) -> [StaticMethodType] {
        return invocations.filter { StaticMethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}

// MARK: - ProtocolWithStaticMembers
class ProtocolWithStaticMembersMock: ProtocolWithStaticMembers, Mock, StaticMock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
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

    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyTestCase.onFatalFailure() // Prepare running test case that it should not continue
        XCTFail(message, file: file, line: line)
        #endif
    }

    static var matcher: Matcher = Matcher.default
    static var stubbingPolicy: StubbingPolicy = .wrap
    static var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    static private var invocations: [StaticMethodType] = []
    static private var methodReturnValues: [StaticGiven] = []
    static private var methodPerformValues: [StaticPerform] = []
    static func clear() {
        invocations = []
        methodReturnValues = []
        methodPerformValues = []
    }


    typealias Property = Swift.Never
    static var staticProperty: String { 
		get {	ProtocolWithStaticMembersMock.invocations.append(.staticProperty_get)
				return ProtocolWithStaticMembersMock.__staticProperty.orFail("ProtocolWithStaticMembersMock - value for staticProperty was not defined") }
		set {	ProtocolWithStaticMembersMock.invocations.append(.staticProperty_set(.value(newValue)))
				ProtocolWithStaticMembersMock.__staticProperty = newValue }
	}
	private static var __staticProperty: (String)?

    struct StaticProperty {
        fileprivate var method: StaticMethodType
        static var staticProperty: StaticProperty { return StaticProperty(method: .staticProperty_get) }
		static func staticProperty(set newValue: Parameter<String>) -> StaticProperty { return StaticProperty(method: .staticProperty_set(newValue)) }
    }

    static func staticMethod(param: Int) throws -> Int {
        addInvocation(.sstaticMethod__param_param(Parameter<Int>.value(param)))
		let perform = methodPerformValue(.sstaticMethod__param_param(Parameter<Int>.value(param))) as? (Int) -> Void
		perform?(param)
		var __value: Int
		do {
		    __value = try methodReturnValue(.sstaticMethod__param_param(Parameter<Int>.value(param))).casted()
		} catch MockError.notStubed {
			Failure("stub return value not specified for staticMethod(param: Int). Use given")
		} catch {
		    throw error
		}
		return __value
    }

    fileprivate enum StaticMethodType {
        case sstaticMethod__param_param(Parameter<Int>)

        case staticProperty_get
		case staticProperty_set(Parameter<String>)

        static func compareParameters(lhs: StaticMethodType, rhs: StaticMethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.sstaticMethod__param_param(let lhsParam), .sstaticMethod__param_param(let rhsParam)):
                    guard Parameter.compare(lhs: lhsParam, rhs: rhsParam, with: matcher) else { return false } 
                    return true 
                case (.staticProperty_get,.staticProperty_get): return true
				case (.staticProperty_set(let left),.staticProperty_set(let right)): return Parameter<String>.compare(lhs: left, rhs: right, with: matcher)
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case let .sstaticMethod__param_param(p0): return p0.intValue
                case .staticProperty_get: return 0
				case .staticProperty_set(let newValue): return newValue.intValue
            }
        }
    }

    class StaticGiven: StubbedMethod {
        fileprivate var method: StaticMethodType

        private init(method: StaticMethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

        static func staticMethod(param: Parameter<Int>, willReturn: Int...) -> StaticGiven {
            return StaticGiven(method: .sstaticMethod__param_param(param), products: willReturn.map({ Product.return($0) }))
        }
        static func staticMethod(param: Parameter<Int>, willThrow: Error...) -> StaticGiven {
            return StaticGiven(method: .sstaticMethod__param_param(param), products: willThrow.map({ Product.throw($0) }))
        }
        static func staticMethod(param: Parameter<Int>, willProduce: (StubberThrows<Int>) -> Void) -> StaticGiven {
            let willThrow: [Error] = []
			let given: StaticGiven = { return StaticGiven(method: .sstaticMethod__param_param(param), products: willThrow.map({ Product.throw($0) })) }()
			let stubber = given.stubThrows(for: (Int).self)
			willProduce(stubber)
			return given
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

        static func staticMethod(param: Parameter<Int>, perform: @escaping (Int) -> Void) -> StaticPerform {
            return StaticPerform(method: .sstaticMethod__param_param(param), performs: perform)
        }
    }

    
    fileprivate struct MethodType {
        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool { return true }
        func intValue() -> Int { return 0 }
    }

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

    }

    struct Verify {
        fileprivate var method: MethodType

    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
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
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }
    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) { }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> Product {
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

    static private func matchingCalls(_ method: StaticVerify) -> Int {
        return matchingCalls(method.method).count
    }

    static public func given(_ method: StaticGiven) {
        methodReturnValues.append(method)
    }

    static public func perform(_ method: StaticPerform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    static public func verify(_ method: StaticVerify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    static public func verify(property: StaticProperty, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(property.method)
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(property.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    static private func addInvocation(_ call: StaticMethodType) {
        invocations.append(call)
    }

    static private func methodReturnValue(_ method: StaticMethodType) throws -> Product {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && StaticMethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
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
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
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

    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyTestCase.onFatalFailure() // Prepare running test case that it should not continue
        XCTFail(message, file: file, line: line)
        #endif
    }



    typealias Property = Swift.Never


    func methodThatThrows() throws {
        addInvocation(.imethodThatThrows)
		let perform = methodPerformValue(.imethodThatThrows) as? () -> Void
		perform?()
		var __value: Void
		do {
		    __value = try methodReturnValue(.imethodThatThrows).casted()
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }

    func methodThatReturnsAndThrows(param: Int) throws -> Bool {
        addInvocation(.imethodThatReturnsAndThrows__param_param(Parameter<Int>.value(param)))
		let perform = methodPerformValue(.imethodThatReturnsAndThrows__param_param(Parameter<Int>.value(param))) as? (Int) -> Void
		perform?(param)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.imethodThatReturnsAndThrows__param_param(Parameter<Int>.value(param))).casted()
		} catch MockError.notStubed {
			onFatalFailure("stub return value not specified for methodThatReturnsAndThrows(param: Int). Use given")
			Failure("stub return value not specified for methodThatReturnsAndThrows(param: Int). Use given")
		} catch {
		    throw error
		}
		return __value
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

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

        static func methodThatReturnsAndThrows(param: Parameter<Int>, willReturn: Bool...) -> Given {
            return Given(method: .imethodThatReturnsAndThrows__param_param(param), products: willReturn.map({ Product.return($0) }))
        }
        static func methodThatThrows(willThrow: Error...) -> Given {
            return Given(method: .imethodThatThrows, products: willThrow.map({ Product.throw($0) }))
        }
        static func methodThatThrows(willProduce: (StubberThrows<Void>) -> Void) -> Given {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .imethodThatThrows, products: willThrow.map({ Product.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
        static func methodThatReturnsAndThrows(param: Parameter<Int>, willThrow: Error...) -> Given {
            return Given(method: .imethodThatReturnsAndThrows__param_param(param), products: willThrow.map({ Product.throw($0) }))
        }
        static func methodThatReturnsAndThrows(param: Parameter<Int>, willProduce: (StubberThrows<Bool>) -> Void) -> Given {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .imethodThatReturnsAndThrows__param_param(param), products: willThrow.map({ Product.throw($0) })) }()
			let stubber = given.stubThrows(for: (Bool).self)
			willProduce(stubber)
			return given
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

        static func methodThatThrows(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .imethodThatThrows, performs: perform)
        }
        static func methodThatReturnsAndThrows(param: Parameter<Int>, perform: @escaping (Int) -> Void) -> Perform {
            return Perform(method: .imethodThatReturnsAndThrows__param_param(param), performs: perform)
        }
    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
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
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }
    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) { }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> Product {
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
}

// MARK: - ProtocolWithTuples
class ProtocolWithTuplesMock: ProtocolWithTuples, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
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

    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyTestCase.onFatalFailure() // Prepare running test case that it should not continue
        XCTFail(message, file: file, line: line)
        #endif
    }



    typealias Property = Swift.Never


    func methodThatTakesTuple(tuple: (String,Int)) -> Int {
        addInvocation(.imethodThatTakesTuple__tuple_tuple(Parameter<(String,Int)>.value(tuple)))
		let perform = methodPerformValue(.imethodThatTakesTuple__tuple_tuple(Parameter<(String,Int)>.value(tuple))) as? ((String,Int)) -> Void
		perform?(tuple)
		var __value: Int
		do {
		    __value = try methodReturnValue(.imethodThatTakesTuple__tuple_tuple(Parameter<(String,Int)>.value(tuple))).casted()
		} catch {
			onFatalFailure("stub return value not specified for methodThatTakesTuple(tuple: (String,Int)). Use given")
			Failure("stub return value not specified for methodThatTakesTuple(tuple: (String,Int)). Use given")
		}
		return __value
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

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

        static func methodThatTakesTuple(tuple: Parameter<(String,Int)>, willReturn: Int...) -> Given {
            return Given(method: .imethodThatTakesTuple__tuple_tuple(tuple), products: willReturn.map({ Product.return($0) }))
        }
        static func methodThatTakesTuple(tuple: Parameter<(String,Int)>, willProduce: (Stubber<Int>) -> Void) -> Given {
            let willReturn: [Int] = []
			let given: Given = { return Given(method: .imethodThatTakesTuple__tuple_tuple(tuple), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Int).self)
			willProduce(stubber)
			return given
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

        static func methodThatTakesTuple(tuple: Parameter<(String,Int)>, perform: @escaping ((String,Int)) -> Void) -> Perform {
            return Perform(method: .imethodThatTakesTuple__tuple_tuple(tuple), performs: perform)
        }
    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
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
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }
    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) { }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> Product {
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
}

// MARK: - SampleServiceType
class SampleServiceTypeMock: SampleServiceType, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
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

    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyTestCase.onFatalFailure() // Prepare running test case that it should not continue
        XCTFail(message, file: file, line: line)
        #endif
    }



    typealias Property = Swift.Never


    func serviceName() -> String {
        addInvocation(.iserviceName)
		let perform = methodPerformValue(.iserviceName) as? () -> Void
		perform?()
		var __value: String
		do {
		    __value = try methodReturnValue(.iserviceName).casted()
		} catch {
			onFatalFailure("stub return value not specified for serviceName(). Use given")
			Failure("stub return value not specified for serviceName(). Use given")
		}
		return __value
    }

    func getPoint(from point: Point) -> Point {
        addInvocation(.igetPoint__from_point(Parameter<Point>.value(point)))
		let perform = methodPerformValue(.igetPoint__from_point(Parameter<Point>.value(point))) as? (Point) -> Void
		perform?(point)
		var __value: Point
		do {
		    __value = try methodReturnValue(.igetPoint__from_point(Parameter<Point>.value(point))).casted()
		} catch {
			onFatalFailure("stub return value not specified for getPoint(from point: Point). Use given")
			Failure("stub return value not specified for getPoint(from point: Point). Use given")
		}
		return __value
    }

    func getPoint(from tuple: (Float,Float)) -> Point {
        addInvocation(.igetPoint__from_tuple(Parameter<(Float,Float)>.value(tuple)))
		let perform = methodPerformValue(.igetPoint__from_tuple(Parameter<(Float,Float)>.value(tuple))) as? ((Float,Float)) -> Void
		perform?(tuple)
		var __value: Point
		do {
		    __value = try methodReturnValue(.igetPoint__from_tuple(Parameter<(Float,Float)>.value(tuple))).casted()
		} catch {
			onFatalFailure("stub return value not specified for getPoint(from tuple: (Float,Float)). Use given")
			Failure("stub return value not specified for getPoint(from tuple: (Float,Float)). Use given")
		}
		return __value
    }

    func similarMethodThatDiffersOnType(_ value: Float) -> Bool {
        addInvocation(.isimilarMethodThatDiffersOnType__value_1(Parameter<Float>.value(value)))
		let perform = methodPerformValue(.isimilarMethodThatDiffersOnType__value_1(Parameter<Float>.value(value))) as? (Float) -> Void
		perform?(value)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.isimilarMethodThatDiffersOnType__value_1(Parameter<Float>.value(value))).casted()
		} catch {
			onFatalFailure("stub return value not specified for similarMethodThatDiffersOnType(_ value: Float). Use given")
			Failure("stub return value not specified for similarMethodThatDiffersOnType(_ value: Float). Use given")
		}
		return __value
    }

    func similarMethodThatDiffersOnType(_ value: Point) -> Bool {
        addInvocation(.isimilarMethodThatDiffersOnType__value_2(Parameter<Point>.value(value)))
		let perform = methodPerformValue(.isimilarMethodThatDiffersOnType__value_2(Parameter<Point>.value(value))) as? (Point) -> Void
		perform?(value)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.isimilarMethodThatDiffersOnType__value_2(Parameter<Point>.value(value))).casted()
		} catch {
			onFatalFailure("stub return value not specified for similarMethodThatDiffersOnType(_ value: Point). Use given")
			Failure("stub return value not specified for similarMethodThatDiffersOnType(_ value: Point). Use given")
		}
		return __value
    }

    func methodWithTypedef(_ scalar: Scalar) {
        addInvocation(.imethodWithTypedef__scalar(Parameter<Scalar>.value(scalar)))
		let perform = methodPerformValue(.imethodWithTypedef__scalar(Parameter<Scalar>.value(scalar))) as? (Scalar) -> Void
		perform?(scalar)
    }

    func methodWithClosures(success function: LinearFunction) -> ClosureFabric {
        addInvocation(.imethodWithClosures__success_function_1(Parameter<LinearFunction>.value(function)))
		let perform = methodPerformValue(.imethodWithClosures__success_function_1(Parameter<LinearFunction>.value(function))) as? (LinearFunction) -> Void
		perform?(function)
		var __value: ClosureFabric
		do {
		    __value = try methodReturnValue(.imethodWithClosures__success_function_1(Parameter<LinearFunction>.value(function))).casted()
		} catch {
			onFatalFailure("stub return value not specified for methodWithClosures(success function: LinearFunction). Use given")
			Failure("stub return value not specified for methodWithClosures(success function: LinearFunction). Use given")
		}
		return __value
    }

    func methodWithClosures(success function: ((Scalar,Scalar) -> Scalar)?) -> ((Int) -> Void) {
        addInvocation(.imethodWithClosures__success_function_2(Parameter<((Scalar,Scalar) -> Scalar)?>.value(function)))
		let perform = methodPerformValue(.imethodWithClosures__success_function_2(Parameter<((Scalar,Scalar) -> Scalar)?>.value(function))) as? (((Scalar,Scalar) -> Scalar)?) -> Void
		perform?(function)
		var __value: (Int) -> Void
		do {
		    __value = try methodReturnValue(.imethodWithClosures__success_function_2(Parameter<((Scalar,Scalar) -> Scalar)?>.value(function))).casted()
		} catch {
			onFatalFailure("stub return value not specified for methodWithClosures(success function: ((Scalar,Scalar) -> Scalar)?). Use given")
			Failure("stub return value not specified for methodWithClosures(success function: ((Scalar,Scalar) -> Scalar)?). Use given")
		}
		return __value
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

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

        static func serviceName(willReturn: String...) -> Given {
            return Given(method: .iserviceName, products: willReturn.map({ Product.return($0) }))
        }
        static func getPoint(from point: Parameter<Point>, willReturn: Point...) -> Given {
            return Given(method: .igetPoint__from_point(point), products: willReturn.map({ Product.return($0) }))
        }
        static func getPoint(from tuple: Parameter<(Float,Float)>, willReturn: Point...) -> Given {
            return Given(method: .igetPoint__from_tuple(tuple), products: willReturn.map({ Product.return($0) }))
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Float>, willReturn: Bool...) -> Given {
            return Given(method: .isimilarMethodThatDiffersOnType__value_1(value), products: willReturn.map({ Product.return($0) }))
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Point>, willReturn: Bool...) -> Given {
            return Given(method: .isimilarMethodThatDiffersOnType__value_2(value), products: willReturn.map({ Product.return($0) }))
        }
        static func methodWithClosures(success function: Parameter<LinearFunction>, willReturn: ClosureFabric...) -> Given {
            return Given(method: .imethodWithClosures__success_function_1(function), products: willReturn.map({ Product.return($0) }))
        }
        static func methodWithClosures(success function: Parameter<((Scalar,Scalar) -> Scalar)?>, willReturn: (Int) -> Void...) -> Given {
            return Given(method: .imethodWithClosures__success_function_2(function), products: willReturn.map({ Product.return($0) }))
        }
        static func serviceName(willProduce: (Stubber<String>) -> Void) -> Given {
            let willReturn: [String] = []
			let given: Given = { return Given(method: .iserviceName, products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (String).self)
			willProduce(stubber)
			return given
        }
        static func getPoint(from point: Parameter<Point>, willProduce: (Stubber<Point>) -> Void) -> Given {
            let willReturn: [Point] = []
			let given: Given = { return Given(method: .igetPoint__from_point(point), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Point).self)
			willProduce(stubber)
			return given
        }
        static func getPoint(from tuple: Parameter<(Float,Float)>, willProduce: (Stubber<Point>) -> Void) -> Given {
            let willReturn: [Point] = []
			let given: Given = { return Given(method: .igetPoint__from_tuple(tuple), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Point).self)
			willProduce(stubber)
			return given
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Float>, willProduce: (Stubber<Bool>) -> Void) -> Given {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .isimilarMethodThatDiffersOnType__value_1(value), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Point>, willProduce: (Stubber<Bool>) -> Void) -> Given {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .isimilarMethodThatDiffersOnType__value_2(value), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
        }
        static func methodWithClosures(success function: Parameter<LinearFunction>, willProduce: (Stubber<ClosureFabric>) -> Void) -> Given {
            let willReturn: [ClosureFabric] = []
			let given: Given = { return Given(method: .imethodWithClosures__success_function_1(function), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (ClosureFabric).self)
			willProduce(stubber)
			return given
        }
        static func methodWithClosures(success function: Parameter<((Scalar,Scalar) -> Scalar)?>, willProduce: (Stubber<(Int) -> Void>) -> Void) -> Given {
            let willReturn: [(Int) -> Void] = []
			let given: Given = { return Given(method: .imethodWithClosures__success_function_2(function), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: ((Int) -> Void).self)
			willProduce(stubber)
			return given
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

        static func serviceName(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .iserviceName, performs: perform)
        }
        static func getPoint(from point: Parameter<Point>, perform: @escaping (Point) -> Void) -> Perform {
            return Perform(method: .igetPoint__from_point(point), performs: perform)
        }
        static func getPoint(from tuple: Parameter<(Float,Float)>, perform: @escaping ((Float,Float)) -> Void) -> Perform {
            return Perform(method: .igetPoint__from_tuple(tuple), performs: perform)
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Float>, perform: @escaping (Float) -> Void) -> Perform {
            return Perform(method: .isimilarMethodThatDiffersOnType__value_1(value), performs: perform)
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Point>, perform: @escaping (Point) -> Void) -> Perform {
            return Perform(method: .isimilarMethodThatDiffersOnType__value_2(value), performs: perform)
        }
        static func methodWithTypedef(scalar: Parameter<Scalar>, perform: @escaping (Scalar) -> Void) -> Perform {
            return Perform(method: .imethodWithTypedef__scalar(scalar), performs: perform)
        }
        static func methodWithClosures(success function: Parameter<LinearFunction>, perform: @escaping (LinearFunction) -> Void) -> Perform {
            return Perform(method: .imethodWithClosures__success_function_1(function), performs: perform)
        }
        static func methodWithClosures(success function: Parameter<((Scalar,Scalar) -> Scalar)?>, perform: @escaping (((Scalar,Scalar) -> Scalar)?) -> Void) -> Perform {
            return Perform(method: .imethodWithClosures__success_function_2(function), performs: perform)
        }
    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
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
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }
    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) { }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> Product {
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
}

// MARK: - SelfConstrainedProtocol
class SelfConstrainedProtocolMock: SelfConstrainedProtocol, Mock, StaticMock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
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

    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyTestCase.onFatalFailure() // Prepare running test case that it should not continue
        XCTFail(message, file: file, line: line)
        #endif
    }

    static var matcher: Matcher = Matcher.default
    static var stubbingPolicy: StubbingPolicy = .wrap
    static var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    static private var invocations: [StaticMethodType] = []
    static private var methodReturnValues: [StaticGiven] = []
    static private var methodPerformValues: [StaticPerform] = []
    static func clear() {
        invocations = []
        methodReturnValues = []
        methodPerformValues = []
    }


    typealias Property = Swift.Never

    typealias StaticProperty = Swift.Never

    static func construct(param value: Int) -> Self {
        func _wrapped<__Self__>() -> __Self__ {
		addInvocation(.sconstruct__param_value(Parameter<Int>.value(value)))
		let perform = methodPerformValue(.sconstruct__param_value(Parameter<Int>.value(value))) as? (Int) -> Void
		perform?(value)
		var __value: __Self__
		do {
		    __value = try methodReturnValue(.sconstruct__param_value(Parameter<Int>.value(value))).casted()
		} catch {
			Failure("stub return value not specified for construct(param value: Int). Use given")
		}
		return __value
		}
		return _wrapped()
    }

    func methodReturningSelf() -> Self {
        func _wrapped<__Self__>() -> __Self__ {
		addInvocation(.imethodReturningSelf)
		let perform = methodPerformValue(.imethodReturningSelf) as? () -> Void
		perform?()
		var __value: __Self__
		do {
		    __value = try methodReturnValue(.imethodReturningSelf).casted()
		} catch {
			onFatalFailure("stub return value not specified for methodReturningSelf(). Use given")
			Failure("stub return value not specified for methodReturningSelf(). Use given")
		}
		return __value
		}
		return _wrapped()
    }

    func compare(with other: SelfConstrainedProtocolMock) -> Bool {
        addInvocation(.icompare__with_other(Parameter<SelfConstrainedProtocolMock>.value(other)))
		let perform = methodPerformValue(.icompare__with_other(Parameter<SelfConstrainedProtocolMock>.value(other))) as? (SelfConstrainedProtocolMock) -> Void
		perform?(other)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.icompare__with_other(Parameter<SelfConstrainedProtocolMock>.value(other))).casted()
		} catch {
			onFatalFailure("stub return value not specified for compare(with other: Self). Use given")
			Failure("stub return value not specified for compare(with other: Self). Use given")
		}
		return __value
    }

    func genericMethodWithNestedSelf<T>(param: Int, second: T, other: (SelfConstrainedProtocolMock,SelfConstrainedProtocolMock)) -> Self {
        func _wrapped<__Self__>() -> __Self__ {
		addInvocation(.igenericMethodWithNestedSelf__param_paramsecond_secondother_other(Parameter<Int>.value(param), Parameter<T>.value(second).wrapAsGeneric(), Parameter<(SelfConstrainedProtocolMock,SelfConstrainedProtocolMock)>.value(other)))
		let perform = methodPerformValue(.igenericMethodWithNestedSelf__param_paramsecond_secondother_other(Parameter<Int>.value(param), Parameter<T>.value(second).wrapAsGeneric(), Parameter<(SelfConstrainedProtocolMock,SelfConstrainedProtocolMock)>.value(other))) as? (Int, T, (SelfConstrainedProtocolMock,SelfConstrainedProtocolMock)) -> Void
		perform?(param, second, other)
		var __value: __Self__
		do {
		    __value = try methodReturnValue(.igenericMethodWithNestedSelf__param_paramsecond_secondother_other(Parameter<Int>.value(param), Parameter<T>.value(second).wrapAsGeneric(), Parameter<(SelfConstrainedProtocolMock,SelfConstrainedProtocolMock)>.value(other))).casted()
		} catch {
			onFatalFailure("stub return value not specified for genericMethodWithNestedSelf<T>(param: Int, second: T, other: (Self,Self)). Use given")
			Failure("stub return value not specified for genericMethodWithNestedSelf<T>(param: Int, second: T, other: (Self,Self)). Use given")
		}
		return __value
		}
		return _wrapped()
    }

    fileprivate enum StaticMethodType {
        case sconstruct__param_value(Parameter<Int>)


        static func compareParameters(lhs: StaticMethodType, rhs: StaticMethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.sconstruct__param_value(let lhsValue), .sconstruct__param_value(let rhsValue)):
                    guard Parameter.compare(lhs: lhsValue, rhs: rhsValue, with: matcher) else { return false } 
                    return true 
            }
        }

        func intValue() -> Int {
            switch self {
                case let .sconstruct__param_value(p0): return p0.intValue
            }
        }
    }

    class StaticGiven: StubbedMethod {
        fileprivate var method: StaticMethodType

        private init(method: StaticMethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

        static func construct(param value: Parameter<Int>, willReturn: SelfConstrainedProtocolMock...) -> StaticGiven {
            return StaticGiven(method: .sconstruct__param_value(value), products: willReturn.map({ Product.return($0) }))
        }
        static func construct(param value: Parameter<Int>, willProduce: (Stubber<SelfConstrainedProtocolMock>) -> Void) -> StaticGiven {
            let willReturn: [SelfConstrainedProtocolMock] = []
			let given: StaticGiven = { return StaticGiven(method: .sconstruct__param_value(value), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (SelfConstrainedProtocolMock).self)
			willProduce(stubber)
			return given
        }
    }

    struct StaticVerify {
        fileprivate var method: StaticMethodType

        static func construct(param value: Parameter<Int>) -> StaticVerify {
            return StaticVerify(method: .sconstruct__param_value(value))
        }
    }

    struct StaticPerform {
        fileprivate var method: StaticMethodType
        var performs: Any

        static func construct(param value: Parameter<Int>, perform: @escaping (Int) -> Void) -> StaticPerform {
            return StaticPerform(method: .sconstruct__param_value(value), performs: perform)
        }
    }

        fileprivate enum MethodType {
        case imethodReturningSelf
        case icompare__with_other(Parameter<SelfConstrainedProtocolMock>)
        case igenericMethodWithNestedSelf__param_paramsecond_secondother_other(Parameter<Int>, Parameter<GenericAttribute>, Parameter<(SelfConstrainedProtocolMock,SelfConstrainedProtocolMock)>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.imethodReturningSelf, .imethodReturningSelf):
                    return true 
                case (.icompare__with_other(let lhsOther), .icompare__with_other(let rhsOther)):
                    guard Parameter.compare(lhs: lhsOther, rhs: rhsOther, with: matcher) else { return false } 
                    return true 
                case (.igenericMethodWithNestedSelf__param_paramsecond_secondother_other(let lhsParam, let lhsSecond, let lhsOther), .igenericMethodWithNestedSelf__param_paramsecond_secondother_other(let rhsParam, let rhsSecond, let rhsOther)):
                    guard Parameter.compare(lhs: lhsParam, rhs: rhsParam, with: matcher) else { return false } 
                    guard Parameter.compare(lhs: lhsSecond, rhs: rhsSecond, with: matcher) else { return false } 
                    guard Parameter.compare(lhs: lhsOther, rhs: rhsOther, with: matcher) else { return false } 
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case .imethodReturningSelf: return 0
                case let .icompare__with_other(p0): return p0.intValue
                case let .igenericMethodWithNestedSelf__param_paramsecond_secondother_other(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            }
        }
    }

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

        static func methodReturningSelf(willReturn: SelfConstrainedProtocolMock...) -> Given {
            return Given(method: .imethodReturningSelf, products: willReturn.map({ Product.return($0) }))
        }
        static func compare(with other: Parameter<SelfConstrainedProtocolMock>, willReturn: Bool...) -> Given {
            return Given(method: .icompare__with_other(other), products: willReturn.map({ Product.return($0) }))
        }
        static func genericMethodWithNestedSelf<T>(param: Parameter<Int>, second: Parameter<T>, other: Parameter<(SelfConstrainedProtocolMock,SelfConstrainedProtocolMock)>, willReturn: SelfConstrainedProtocolMock...) -> Given {
            return Given(method: .igenericMethodWithNestedSelf__param_paramsecond_secondother_other(param, second.wrapAsGeneric(), other), products: willReturn.map({ Product.return($0) }))
        }
        static func methodReturningSelf(willProduce: (Stubber<SelfConstrainedProtocolMock>) -> Void) -> Given {
            let willReturn: [SelfConstrainedProtocolMock] = []
			let given: Given = { return Given(method: .imethodReturningSelf, products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (SelfConstrainedProtocolMock).self)
			willProduce(stubber)
			return given
        }
        static func compare(with other: Parameter<SelfConstrainedProtocolMock>, willProduce: (Stubber<Bool>) -> Void) -> Given {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .icompare__with_other(other), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
        }
        static func genericMethodWithNestedSelf<T>(param: Parameter<Int>, second: Parameter<T>, other: Parameter<(SelfConstrainedProtocolMock,SelfConstrainedProtocolMock)>, willProduce: (Stubber<SelfConstrainedProtocolMock>) -> Void) -> Given {
            let willReturn: [SelfConstrainedProtocolMock] = []
			let given: Given = { return Given(method: .igenericMethodWithNestedSelf__param_paramsecond_secondother_other(param, second.wrapAsGeneric(), other), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (SelfConstrainedProtocolMock).self)
			willProduce(stubber)
			return given
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func methodReturningSelf() -> Verify {
            return Verify(method: .imethodReturningSelf)
        }
        static func compare(with other: Parameter<SelfConstrainedProtocolMock>) -> Verify {
            return Verify(method: .icompare__with_other(other))
        }
        static func genericMethodWithNestedSelf<T>(param: Parameter<Int>, second: Parameter<T>, other: Parameter<(SelfConstrainedProtocolMock,SelfConstrainedProtocolMock)>) -> Verify {
            return Verify(method: .igenericMethodWithNestedSelf__param_paramsecond_secondother_other(param, second.wrapAsGeneric(), other))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func methodReturningSelf(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .imethodReturningSelf, performs: perform)
        }
        static func compare(with other: Parameter<SelfConstrainedProtocolMock>, perform: @escaping (SelfConstrainedProtocolMock) -> Void) -> Perform {
            return Perform(method: .icompare__with_other(other), performs: perform)
        }
        static func genericMethodWithNestedSelf<T>(param: Parameter<Int>, second: Parameter<T>, other: Parameter<(SelfConstrainedProtocolMock,SelfConstrainedProtocolMock)>, perform: @escaping (Int, T, (SelfConstrainedProtocolMock,SelfConstrainedProtocolMock)) -> Void) -> Perform {
            return Perform(method: .igenericMethodWithNestedSelf__param_paramsecond_secondother_other(param, second.wrapAsGeneric(), other), performs: perform)
        }
    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
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
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }
    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) { }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> Product {
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

    static private func matchingCalls(_ method: StaticVerify) -> Int {
        return matchingCalls(method.method).count
    }

    static public func given(_ method: StaticGiven) {
        methodReturnValues.append(method)
    }

    static public func perform(_ method: StaticPerform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    static public func verify(_ method: StaticVerify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }
    static public func verify(property: StaticProperty, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) { }

    static private func addInvocation(_ call: StaticMethodType) {
        invocations.append(call)
    }

    static private func methodReturnValue(_ method: StaticMethodType) throws -> Product {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && StaticMethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }

    static private func methodPerformValue(_ method: StaticMethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { StaticMethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    static private func matchingCalls(_ method: StaticMethodType) -> [StaticMethodType] {
        return invocations.filter { StaticMethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}

// MARK: - SimpleProtocolThatInheritsOtherProtocols
class SimpleProtocolThatInheritsOtherProtocolsMock: SimpleProtocolThatInheritsOtherProtocols, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
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

    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyTestCase.onFatalFailure() // Prepare running test case that it should not continue
        XCTFail(message, file: file, line: line)
        #endif
    }


    var property: String { 
		get {	invocations.append(.property_get)
				return __property.orFail("SimpleProtocolThatInheritsOtherProtocolsMock - value for property was not defined") }
		set {	invocations.append(.property_set(.value(newValue)))
				__property = newValue }
	}
	private var __property: (String)?
    var weakProperty: AnyObject! { 
		get {	invocations.append(.weakProperty_get)
				return __weakProperty.orFail("SimpleProtocolThatInheritsOtherProtocolsMock - value for weakProperty was not defined") }
		set {	invocations.append(.weakProperty_set(.value(newValue)))
				__weakProperty = newValue }
	}
	private var __weakProperty: (AnyObject)?
    var propertyGetOnly: String { 
		get {	invocations.append(.propertyGetOnly_get)
				return __propertyGetOnly.orFail("SimpleProtocolThatInheritsOtherProtocolsMock - value for propertyGetOnly was not defined") }
		set {	invocations.append(.propertyGetOnly_set(.value(newValue)))
				__propertyGetOnly = newValue }
	}
	private var __propertyGetOnly: (String)?
    var propertyOptional: Int? { 
		get {	invocations.append(.propertyOptional_get)
				return __propertyOptional }
		set {	invocations.append(.propertyOptional_set(.value(newValue)))
				__propertyOptional = newValue }
	}
	private var __propertyOptional: (Int)?
    var propertyImplicit: Int! { 
		get {	invocations.append(.propertyImplicit_get)
				return __propertyImplicit.orFail("SimpleProtocolThatInheritsOtherProtocolsMock - value for propertyImplicit was not defined") }
		set {	invocations.append(.propertyImplicit_set(.value(newValue)))
				__propertyImplicit = newValue }
	}
	private var __propertyImplicit: (Int)?

    struct Property {
        fileprivate var method: MethodType
        static var property: Property { return Property(method: .property_get) }
		static func property(set newValue: Parameter<String>) -> Property { return Property(method: .property_set(newValue)) }
        static var weakProperty: Property { return Property(method: .weakProperty_get) }
		static func weakProperty(set newValue: Parameter<AnyObject?>) -> Property { return Property(method: .weakProperty_set(newValue)) }
        static var propertyGetOnly: Property { return Property(method: .propertyGetOnly_get) }
		static func propertyGetOnly(set newValue: Parameter<String>) -> Property { return Property(method: .propertyGetOnly_set(newValue)) }
        static var propertyOptional: Property { return Property(method: .propertyOptional_get) }
		static func propertyOptional(set newValue: Parameter<Int?>) -> Property { return Property(method: .propertyOptional_set(newValue)) }
        static var propertyImplicit: Property { return Property(method: .propertyImplicit_get) }
		static func propertyImplicit(set newValue: Parameter<Int?>) -> Property { return Property(method: .propertyImplicit_set(newValue)) }
    }


    func simpleMethod() {
        addInvocation(.isimpleMethod)
		let perform = methodPerformValue(.isimpleMethod) as? () -> Void
		perform?()
    }

    func simpleMehtodThatReturns() -> Int {
        addInvocation(.isimpleMehtodThatReturns)
		let perform = methodPerformValue(.isimpleMehtodThatReturns) as? () -> Void
		perform?()
		var __value: Int
		do {
		    __value = try methodReturnValue(.isimpleMehtodThatReturns).casted()
		} catch {
			onFatalFailure("stub return value not specified for simpleMehtodThatReturns(). Use given")
			Failure("stub return value not specified for simpleMehtodThatReturns(). Use given")
		}
		return __value
    }

    func simpleMehtodThatReturns(param: String) -> String {
        addInvocation(.isimpleMehtodThatReturns__param_param(Parameter<String>.value(param)))
		let perform = methodPerformValue(.isimpleMehtodThatReturns__param_param(Parameter<String>.value(param))) as? (String) -> Void
		perform?(param)
		var __value: String
		do {
		    __value = try methodReturnValue(.isimpleMehtodThatReturns__param_param(Parameter<String>.value(param))).casted()
		} catch {
			onFatalFailure("stub return value not specified for simpleMehtodThatReturns(param: String). Use given")
			Failure("stub return value not specified for simpleMehtodThatReturns(param: String). Use given")
		}
		return __value
    }

    func simpleMehtodThatReturns(optionalParam: String?) -> String? {
        addInvocation(.isimpleMehtodThatReturns__optionalParam_optionalParam(Parameter<String?>.value(optionalParam)))
		let perform = methodPerformValue(.isimpleMehtodThatReturns__optionalParam_optionalParam(Parameter<String?>.value(optionalParam))) as? (String?) -> Void
		perform?(optionalParam)
		var __value: String?
		do {
		    __value = try methodReturnValue(.isimpleMehtodThatReturns__optionalParam_optionalParam(Parameter<String?>.value(optionalParam))).casted()
		} catch {
			onFatalFailure("stub return value not specified for simpleMehtodThatReturns(optionalParam: String?). Use given")
			Failure("stub return value not specified for simpleMehtodThatReturns(optionalParam: String?). Use given")
		}
		return __value
    }

    fileprivate enum MethodType {
        case isimpleMethod
        case isimpleMehtodThatReturns
        case isimpleMehtodThatReturns__param_param(Parameter<String>)
        case isimpleMehtodThatReturns__optionalParam_optionalParam(Parameter<String?>)
        case property_get
		case property_set(Parameter<String>)
        case weakProperty_get
		case weakProperty_set(Parameter<AnyObject?>)
        case propertyGetOnly_get
		case propertyGetOnly_set(Parameter<String>)
        case propertyOptional_get
		case propertyOptional_set(Parameter<Int?>)
        case propertyImplicit_get
		case propertyImplicit_set(Parameter<Int?>)

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
                case (.property_get,.property_get): return true
				case (.property_set(let left),.property_set(let right)): return Parameter<String>.compare(lhs: left, rhs: right, with: matcher)
                case (.weakProperty_get,.weakProperty_get): return true
				case (.weakProperty_set(let left),.weakProperty_set(let right)): return Parameter<AnyObject?>.compare(lhs: left, rhs: right, with: matcher)
                case (.propertyGetOnly_get,.propertyGetOnly_get): return true
				case (.propertyGetOnly_set(let left),.propertyGetOnly_set(let right)): return Parameter<String>.compare(lhs: left, rhs: right, with: matcher)
                case (.propertyOptional_get,.propertyOptional_get): return true
				case (.propertyOptional_set(let left),.propertyOptional_set(let right)): return Parameter<Int?>.compare(lhs: left, rhs: right, with: matcher)
                case (.propertyImplicit_get,.propertyImplicit_get): return true
				case (.propertyImplicit_set(let left),.propertyImplicit_set(let right)): return Parameter<Int?>.compare(lhs: left, rhs: right, with: matcher)
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case .isimpleMethod: return 0
                case .isimpleMehtodThatReturns: return 0
                case let .isimpleMehtodThatReturns__param_param(p0): return p0.intValue
                case let .isimpleMehtodThatReturns__optionalParam_optionalParam(p0): return p0.intValue
                case .property_get: return 0
				case .property_set(let newValue): return newValue.intValue
                case .weakProperty_get: return 0
				case .weakProperty_set(let newValue): return newValue.intValue
                case .propertyGetOnly_get: return 0
				case .propertyGetOnly_set(let newValue): return newValue.intValue
                case .propertyOptional_get: return 0
				case .propertyOptional_set(let newValue): return newValue.intValue
                case .propertyImplicit_get: return 0
				case .propertyImplicit_set(let newValue): return newValue.intValue
            }
        }
    }

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

        static func simpleMehtodThatReturns(willReturn: Int...) -> Given {
            return Given(method: .isimpleMehtodThatReturns, products: willReturn.map({ Product.return($0) }))
        }
        static func simpleMehtodThatReturns(param: Parameter<String>, willReturn: String...) -> Given {
            return Given(method: .isimpleMehtodThatReturns__param_param(param), products: willReturn.map({ Product.return($0) }))
        }
        static func simpleMehtodThatReturns(optionalParam: Parameter<String?>, willReturn: String?...) -> Given {
            return Given(method: .isimpleMehtodThatReturns__optionalParam_optionalParam(optionalParam), products: willReturn.map({ Product.return($0) }))
        }
        static func simpleMehtodThatReturns(willProduce: (Stubber<Int>) -> Void) -> Given {
            let willReturn: [Int] = []
			let given: Given = { return Given(method: .isimpleMehtodThatReturns, products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Int).self)
			willProduce(stubber)
			return given
        }
        static func simpleMehtodThatReturns(param: Parameter<String>, willProduce: (Stubber<String>) -> Void) -> Given {
            let willReturn: [String] = []
			let given: Given = { return Given(method: .isimpleMehtodThatReturns__param_param(param), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (String).self)
			willProduce(stubber)
			return given
        }
        static func simpleMehtodThatReturns(optionalParam: Parameter<String?>, willProduce: (Stubber<String?>) -> Void) -> Given {
            let willReturn: [String?] = []
			let given: Given = { return Given(method: .isimpleMehtodThatReturns__optionalParam_optionalParam(optionalParam), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (String?).self)
			willProduce(stubber)
			return given
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

        static func simpleMethod(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .isimpleMethod, performs: perform)
        }
        static func simpleMehtodThatReturns(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .isimpleMehtodThatReturns, performs: perform)
        }
        static func simpleMehtodThatReturns(param: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .isimpleMehtodThatReturns__param_param(param), performs: perform)
        }
        static func simpleMehtodThatReturns(optionalParam: Parameter<String?>, perform: @escaping (String?) -> Void) -> Perform {
            return Perform(method: .isimpleMehtodThatReturns__optionalParam_optionalParam(optionalParam), performs: perform)
        }
    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
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
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(property.method)
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(property.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> Product {
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
}

// MARK: - SimpleProtocolUsingCollections
class SimpleProtocolUsingCollectionsMock: SimpleProtocolUsingCollections, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
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

    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyTestCase.onFatalFailure() // Prepare running test case that it should not continue
        XCTFail(message, file: file, line: line)
        #endif
    }



    typealias Property = Swift.Never


    func getArray() -> [Int] {
        addInvocation(.igetArray)
		let perform = methodPerformValue(.igetArray) as? () -> Void
		perform?()
		var __value: [Int]
		do {
		    __value = try methodReturnValue(.igetArray).casted()
		} catch {
			onFatalFailure("stub return value not specified for getArray(). Use given")
			Failure("stub return value not specified for getArray(). Use given")
		}
		return __value
    }

    func map(array: [String], param: Int) -> [Int: String] {
        addInvocation(.imap__array_arrayparam_param(Parameter<[String]>.value(array), Parameter<Int>.value(param)))
		let perform = methodPerformValue(.imap__array_arrayparam_param(Parameter<[String]>.value(array), Parameter<Int>.value(param))) as? ([String], Int) -> Void
		perform?(array, param)
		var __value: [Int: String]
		do {
		    __value = try methodReturnValue(.imap__array_arrayparam_param(Parameter<[String]>.value(array), Parameter<Int>.value(param))).casted()
		} catch {
			onFatalFailure("stub return value not specified for map(array: [String], param: Int). Use given")
			Failure("stub return value not specified for map(array: [String], param: Int). Use given")
		}
		return __value
    }

    func use(dictionary: [Int: String]) -> [Int: String] {
        addInvocation(.iuse__dictionary_dictionary(Parameter<[Int: String]>.value(dictionary)))
		let perform = methodPerformValue(.iuse__dictionary_dictionary(Parameter<[Int: String]>.value(dictionary))) as? ([Int: String]) -> Void
		perform?(dictionary)
		var __value: [Int: String]
		do {
		    __value = try methodReturnValue(.iuse__dictionary_dictionary(Parameter<[Int: String]>.value(dictionary))).casted()
		} catch {
			onFatalFailure("stub return value not specified for use(dictionary: [Int: String]). Use given")
			Failure("stub return value not specified for use(dictionary: [Int: String]). Use given")
		}
		return __value
    }

    func verify(set: Set<Int>) -> Bool {
        addInvocation(.iverify__set_set(Parameter<Set<Int>>.value(set)))
		let perform = methodPerformValue(.iverify__set_set(Parameter<Set<Int>>.value(set))) as? (Set<Int>) -> Void
		perform?(set)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.iverify__set_set(Parameter<Set<Int>>.value(set))).casted()
		} catch {
			onFatalFailure("stub return value not specified for verify(set: Set<Int>). Use given")
			Failure("stub return value not specified for verify(set: Set<Int>). Use given")
		}
		return __value
    }

    fileprivate enum MethodType {
        case igetArray
        case imap__array_arrayparam_param(Parameter<[String]>, Parameter<Int>)
        case iuse__dictionary_dictionary(Parameter<[Int: String]>)
        case iverify__set_set(Parameter<Set<Int>>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.igetArray, .igetArray):
                    return true 
                case (.imap__array_arrayparam_param(let lhsArray, let lhsParam), .imap__array_arrayparam_param(let rhsArray, let rhsParam)):
                    guard Parameter.compare(lhs: lhsArray, rhs: rhsArray, with: matcher) else { return false } 
                    guard Parameter.compare(lhs: lhsParam, rhs: rhsParam, with: matcher) else { return false } 
                    return true 
                case (.iuse__dictionary_dictionary(let lhsDictionary), .iuse__dictionary_dictionary(let rhsDictionary)):
                    guard Parameter.compare(lhs: lhsDictionary, rhs: rhsDictionary, with: matcher) else { return false } 
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
                case let .iuse__dictionary_dictionary(p0): return p0.intValue
                case let .iverify__set_set(p0): return p0.intValue
            }
        }
    }

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

        static func getArray(willReturn: [Int]...) -> Given {
            return Given(method: .igetArray, products: willReturn.map({ Product.return($0) }))
        }
        static func map(array: Parameter<[String]>, param: Parameter<Int>, willReturn: [Int: String]...) -> Given {
            return Given(method: .imap__array_arrayparam_param(array, param), products: willReturn.map({ Product.return($0) }))
        }
        static func use(dictionary: Parameter<[Int: String]>, willReturn: [Int: String]...) -> Given {
            return Given(method: .iuse__dictionary_dictionary(dictionary), products: willReturn.map({ Product.return($0) }))
        }
        static func verify(set: Parameter<Set<Int>>, willReturn: Bool...) -> Given {
            return Given(method: .iverify__set_set(set), products: willReturn.map({ Product.return($0) }))
        }
        static func getArray(willProduce: (Stubber<[Int]>) -> Void) -> Given {
            let willReturn: [[Int]] = []
			let given: Given = { return Given(method: .igetArray, products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: ([Int]).self)
			willProduce(stubber)
			return given
        }
        static func map(array: Parameter<[String]>, param: Parameter<Int>, willProduce: (Stubber<[Int: String]>) -> Void) -> Given {
            let willReturn: [[Int: String]] = []
			let given: Given = { return Given(method: .imap__array_arrayparam_param(array, param), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: ([Int: String]).self)
			willProduce(stubber)
			return given
        }
        static func use(dictionary: Parameter<[Int: String]>, willProduce: (Stubber<[Int: String]>) -> Void) -> Given {
            let willReturn: [[Int: String]] = []
			let given: Given = { return Given(method: .iuse__dictionary_dictionary(dictionary), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: ([Int: String]).self)
			willProduce(stubber)
			return given
        }
        static func verify(set: Parameter<Set<Int>>, willProduce: (Stubber<Bool>) -> Void) -> Given {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .iverify__set_set(set), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
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
        static func use(dictionary: Parameter<[Int: String]>) -> Verify {
            return Verify(method: .iuse__dictionary_dictionary(dictionary))
        }
        static func verify(set: Parameter<Set<Int>>) -> Verify {
            return Verify(method: .iverify__set_set(set))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func getArray(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .igetArray, performs: perform)
        }
        static func map(array: Parameter<[String]>, param: Parameter<Int>, perform: @escaping ([String], Int) -> Void) -> Perform {
            return Perform(method: .imap__array_arrayparam_param(array, param), performs: perform)
        }
        static func use(dictionary: Parameter<[Int: String]>, perform: @escaping ([Int: String]) -> Void) -> Perform {
            return Perform(method: .iuse__dictionary_dictionary(dictionary), performs: perform)
        }
        static func verify(set: Parameter<Set<Int>>, perform: @escaping (Set<Int>) -> Void) -> Perform {
            return Perform(method: .iverify__set_set(set), performs: perform)
        }
    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
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
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }
    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) { }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> Product {
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
}

// MARK: - SimpleProtocolWithBothMethodsAndProperties
class SimpleProtocolWithBothMethodsAndPropertiesMock: SimpleProtocolWithBothMethodsAndProperties, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
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

    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyTestCase.onFatalFailure() // Prepare running test case that it should not continue
        XCTFail(message, file: file, line: line)
        #endif
    }


    var property: String { 
		get {	invocations.append(.property_get)
				return __property.orFail("SimpleProtocolWithBothMethodsAndPropertiesMock - value for property was not defined") }
		set {	invocations.append(.property_set(.value(newValue)))
				__property = newValue }
	}
	private var __property: (String)?

    struct Property {
        fileprivate var method: MethodType
        static var property: Property { return Property(method: .property_get) }
		static func property(set newValue: Parameter<String>) -> Property { return Property(method: .property_set(newValue)) }
    }


    func simpleMethod() -> String {
        addInvocation(.isimpleMethod)
		let perform = methodPerformValue(.isimpleMethod) as? () -> Void
		perform?()
		var __value: String
		do {
		    __value = try methodReturnValue(.isimpleMethod).casted()
		} catch {
			onFatalFailure("stub return value not specified for simpleMethod(). Use given")
			Failure("stub return value not specified for simpleMethod(). Use given")
		}
		return __value
    }

    fileprivate enum MethodType {
        case isimpleMethod
        case property_get
		case property_set(Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.isimpleMethod, .isimpleMethod):
                    return true 
                case (.property_get,.property_get): return true
				case (.property_set(let left),.property_set(let right)): return Parameter<String>.compare(lhs: left, rhs: right, with: matcher)
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case .isimpleMethod: return 0
                case .property_get: return 0
				case .property_set(let newValue): return newValue.intValue
            }
        }
    }

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

        static func simpleMethod(willReturn: String...) -> Given {
            return Given(method: .isimpleMethod, products: willReturn.map({ Product.return($0) }))
        }
        static func simpleMethod(willProduce: (Stubber<String>) -> Void) -> Given {
            let willReturn: [String] = []
			let given: Given = { return Given(method: .isimpleMethod, products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (String).self)
			willProduce(stubber)
			return given
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

        static func simpleMethod(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .isimpleMethod, performs: perform)
        }
    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
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
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(property.method)
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(property.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> Product {
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
}

// MARK: - SimpleProtocolWithMethods
class SimpleProtocolWithMethodsMock: SimpleProtocolWithMethods, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
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

    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyTestCase.onFatalFailure() // Prepare running test case that it should not continue
        XCTFail(message, file: file, line: line)
        #endif
    }



    typealias Property = Swift.Never


    func simpleMethod() {
        addInvocation(.isimpleMethod)
		let perform = methodPerformValue(.isimpleMethod) as? () -> Void
		perform?()
    }

    func simpleMehtodThatReturns() -> Int {
        addInvocation(.isimpleMehtodThatReturns)
		let perform = methodPerformValue(.isimpleMehtodThatReturns) as? () -> Void
		perform?()
		var __value: Int
		do {
		    __value = try methodReturnValue(.isimpleMehtodThatReturns).casted()
		} catch {
			onFatalFailure("stub return value not specified for simpleMehtodThatReturns(). Use given")
			Failure("stub return value not specified for simpleMehtodThatReturns(). Use given")
		}
		return __value
    }

    func simpleMehtodThatReturns(param: String) -> String {
        addInvocation(.isimpleMehtodThatReturns__param_param(Parameter<String>.value(param)))
		let perform = methodPerformValue(.isimpleMehtodThatReturns__param_param(Parameter<String>.value(param))) as? (String) -> Void
		perform?(param)
		var __value: String
		do {
		    __value = try methodReturnValue(.isimpleMehtodThatReturns__param_param(Parameter<String>.value(param))).casted()
		} catch {
			onFatalFailure("stub return value not specified for simpleMehtodThatReturns(param: String). Use given")
			Failure("stub return value not specified for simpleMehtodThatReturns(param: String). Use given")
		}
		return __value
    }

    func simpleMehtodThatReturns(optionalParam: String?) -> String? {
        addInvocation(.isimpleMehtodThatReturns__optionalParam_optionalParam(Parameter<String?>.value(optionalParam)))
		let perform = methodPerformValue(.isimpleMehtodThatReturns__optionalParam_optionalParam(Parameter<String?>.value(optionalParam))) as? (String?) -> Void
		perform?(optionalParam)
		var __value: String?
		do {
		    __value = try methodReturnValue(.isimpleMehtodThatReturns__optionalParam_optionalParam(Parameter<String?>.value(optionalParam))).casted()
		} catch {
			onFatalFailure("stub return value not specified for simpleMehtodThatReturns(optionalParam: String?). Use given")
			Failure("stub return value not specified for simpleMehtodThatReturns(optionalParam: String?). Use given")
		}
		return __value
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

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

        static func simpleMehtodThatReturns(willReturn: Int...) -> Given {
            return Given(method: .isimpleMehtodThatReturns, products: willReturn.map({ Product.return($0) }))
        }
        static func simpleMehtodThatReturns(param: Parameter<String>, willReturn: String...) -> Given {
            return Given(method: .isimpleMehtodThatReturns__param_param(param), products: willReturn.map({ Product.return($0) }))
        }
        static func simpleMehtodThatReturns(optionalParam: Parameter<String?>, willReturn: String?...) -> Given {
            return Given(method: .isimpleMehtodThatReturns__optionalParam_optionalParam(optionalParam), products: willReturn.map({ Product.return($0) }))
        }
        static func simpleMehtodThatReturns(willProduce: (Stubber<Int>) -> Void) -> Given {
            let willReturn: [Int] = []
			let given: Given = { return Given(method: .isimpleMehtodThatReturns, products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (Int).self)
			willProduce(stubber)
			return given
        }
        static func simpleMehtodThatReturns(param: Parameter<String>, willProduce: (Stubber<String>) -> Void) -> Given {
            let willReturn: [String] = []
			let given: Given = { return Given(method: .isimpleMehtodThatReturns__param_param(param), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (String).self)
			willProduce(stubber)
			return given
        }
        static func simpleMehtodThatReturns(optionalParam: Parameter<String?>, willProduce: (Stubber<String?>) -> Void) -> Given {
            let willReturn: [String?] = []
			let given: Given = { return Given(method: .isimpleMehtodThatReturns__optionalParam_optionalParam(optionalParam), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (String?).self)
			willProduce(stubber)
			return given
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

        static func simpleMethod(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .isimpleMethod, performs: perform)
        }
        static func simpleMehtodThatReturns(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .isimpleMehtodThatReturns, performs: perform)
        }
        static func simpleMehtodThatReturns(param: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .isimpleMehtodThatReturns__param_param(param), performs: perform)
        }
        static func simpleMehtodThatReturns(optionalParam: Parameter<String?>, perform: @escaping (String?) -> Void) -> Perform {
            return Perform(method: .isimpleMehtodThatReturns__optionalParam_optionalParam(optionalParam), performs: perform)
        }
    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
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
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }
    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) { }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> Product {
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
}

// MARK: - SimpleProtocolWithProperties
class SimpleProtocolWithPropertiesMock: SimpleProtocolWithProperties, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
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

    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyTestCase.onFatalFailure() // Prepare running test case that it should not continue
        XCTFail(message, file: file, line: line)
        #endif
    }


    var property: String { 
		get {	invocations.append(.property_get)
				return __property.orFail("SimpleProtocolWithPropertiesMock - value for property was not defined") }
		set {	invocations.append(.property_set(.value(newValue)))
				__property = newValue }
	}
	private var __property: (String)?
    var weakProperty: AnyObject! { 
		get {	invocations.append(.weakProperty_get)
				return __weakProperty.orFail("SimpleProtocolWithPropertiesMock - value for weakProperty was not defined") }
		set {	invocations.append(.weakProperty_set(.value(newValue)))
				__weakProperty = newValue }
	}
	private var __weakProperty: (AnyObject)?
    var propertyGetOnly: String { 
		get {	invocations.append(.propertyGetOnly_get)
				return __propertyGetOnly.orFail("SimpleProtocolWithPropertiesMock - value for propertyGetOnly was not defined") }
		set {	invocations.append(.propertyGetOnly_set(.value(newValue)))
				__propertyGetOnly = newValue }
	}
	private var __propertyGetOnly: (String)?
    var propertyOptional: Int? { 
		get {	invocations.append(.propertyOptional_get)
				return __propertyOptional }
		set {	invocations.append(.propertyOptional_set(.value(newValue)))
				__propertyOptional = newValue }
	}
	private var __propertyOptional: (Int)?
    var propertyImplicit: Int! { 
		get {	invocations.append(.propertyImplicit_get)
				return __propertyImplicit.orFail("SimpleProtocolWithPropertiesMock - value for propertyImplicit was not defined") }
		set {	invocations.append(.propertyImplicit_set(.value(newValue)))
				__propertyImplicit = newValue }
	}
	private var __propertyImplicit: (Int)?

    struct Property {
        fileprivate var method: MethodType
        static var property: Property { return Property(method: .property_get) }
		static func property(set newValue: Parameter<String>) -> Property { return Property(method: .property_set(newValue)) }
        static var weakProperty: Property { return Property(method: .weakProperty_get) }
		static func weakProperty(set newValue: Parameter<AnyObject?>) -> Property { return Property(method: .weakProperty_set(newValue)) }
        static var propertyGetOnly: Property { return Property(method: .propertyGetOnly_get) }
		static func propertyGetOnly(set newValue: Parameter<String>) -> Property { return Property(method: .propertyGetOnly_set(newValue)) }
        static var propertyOptional: Property { return Property(method: .propertyOptional_get) }
		static func propertyOptional(set newValue: Parameter<Int?>) -> Property { return Property(method: .propertyOptional_set(newValue)) }
        static var propertyImplicit: Property { return Property(method: .propertyImplicit_get) }
		static func propertyImplicit(set newValue: Parameter<Int?>) -> Property { return Property(method: .propertyImplicit_set(newValue)) }
    }


    fileprivate enum MethodType {
        case property_get
		case property_set(Parameter<String>)
        case weakProperty_get
		case weakProperty_set(Parameter<AnyObject?>)
        case propertyGetOnly_get
		case propertyGetOnly_set(Parameter<String>)
        case propertyOptional_get
		case propertyOptional_set(Parameter<Int?>)
        case propertyImplicit_get
		case propertyImplicit_set(Parameter<Int?>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.property_get,.property_get): return true
				case (.property_set(let left),.property_set(let right)): return Parameter<String>.compare(lhs: left, rhs: right, with: matcher)
                case (.weakProperty_get,.weakProperty_get): return true
				case (.weakProperty_set(let left),.weakProperty_set(let right)): return Parameter<AnyObject?>.compare(lhs: left, rhs: right, with: matcher)
                case (.propertyGetOnly_get,.propertyGetOnly_get): return true
				case (.propertyGetOnly_set(let left),.propertyGetOnly_set(let right)): return Parameter<String>.compare(lhs: left, rhs: right, with: matcher)
                case (.propertyOptional_get,.propertyOptional_get): return true
				case (.propertyOptional_set(let left),.propertyOptional_set(let right)): return Parameter<Int?>.compare(lhs: left, rhs: right, with: matcher)
                case (.propertyImplicit_get,.propertyImplicit_get): return true
				case (.propertyImplicit_set(let left),.propertyImplicit_set(let right)): return Parameter<Int?>.compare(lhs: left, rhs: right, with: matcher)
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case .property_get: return 0
				case .property_set(let newValue): return newValue.intValue
                case .weakProperty_get: return 0
				case .weakProperty_set(let newValue): return newValue.intValue
                case .propertyGetOnly_get: return 0
				case .propertyGetOnly_set(let newValue): return newValue.intValue
                case .propertyOptional_get: return 0
				case .propertyOptional_set(let newValue): return newValue.intValue
                case .propertyImplicit_get: return 0
				case .propertyImplicit_set(let newValue): return newValue.intValue
            }
        }
    }

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

    }

    struct Verify {
        fileprivate var method: MethodType

    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
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
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(property.method)
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(property.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> Product {
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
}

// MARK: - UserNetworkType
class UserNetworkTypeMock: UserNetworkType, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
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

    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyTestCase.onFatalFailure() // Prepare running test case that it should not continue
        XCTFail(message, file: file, line: line)
        #endif
    }



    typealias Property = Swift.Never


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

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
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

        static func getUser(for id: Parameter<String>, completion: Parameter<(User?) -> Void>, perform: @escaping (String, (User?) -> Void) -> Void) -> Perform {
            return Perform(method: .igetUser__for_idcompletion_completion(id, completion), performs: perform)
        }
        static func getUserEscaping(for id: Parameter<String>, completion: Parameter<(User?,Error?) -> Void>, perform: @escaping (String, @escaping (User?,Error?) -> Void) -> Void) -> Perform {
            return Perform(method: .igetUserEscaping__for_idcompletion_completion(id, completion), performs: perform)
        }
        static func doSomething(prop: Parameter<() -> String>, perform: @escaping (@autoclosure () -> String) -> Void) -> Perform {
            return Perform(method: .idoSomething__prop_prop(prop), performs: perform)
        }
        static func testDefaultValues(value: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .itestDefaultValues__value_value(value), performs: perform)
        }
    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
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
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }
    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) { }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> Product {
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
}

// MARK: - UserStorageType
class UserStorageTypeMock: UserStorageType, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
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

    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyTestCase.onFatalFailure() // Prepare running test case that it should not continue
        XCTFail(message, file: file, line: line)
        #endif
    }



    typealias Property = Swift.Never


    func surname(for name: String) -> String {
        addInvocation(.isurname__for_name(Parameter<String>.value(name)))
		let perform = methodPerformValue(.isurname__for_name(Parameter<String>.value(name))) as? (String) -> Void
		perform?(name)
		var __value: String
		do {
		    __value = try methodReturnValue(.isurname__for_name(Parameter<String>.value(name))).casted()
		} catch {
			onFatalFailure("stub return value not specified for surname(for name: String). Use given")
			Failure("stub return value not specified for surname(for name: String). Use given")
		}
		return __value
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

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

        static func surname(for name: Parameter<String>, willReturn: String...) -> Given {
            return Given(method: .isurname__for_name(name), products: willReturn.map({ Product.return($0) }))
        }
        static func surname(for name: Parameter<String>, willProduce: (Stubber<String>) -> Void) -> Given {
            let willReturn: [String] = []
			let given: Given = { return Given(method: .isurname__for_name(name), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (String).self)
			willProduce(stubber)
			return given
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

        static func surname(for name: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .isurname__for_name(name), performs: perform)
        }
        static func storeUser(name: Parameter<String>, surname: Parameter<String>, perform: @escaping (String, String) -> Void) -> Perform {
            return Perform(method: .istoreUser__name_namesurname_surname(name, surname), performs: perform)
        }
    }

    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
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
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }
    public func verify(property: Property, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) { }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) throws -> Product {
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
}

