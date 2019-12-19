// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT



// Generated with SwiftyMocky 3.5.0

import SwiftyMocky
#if !MockyCustom
import XCTest
#endif
import Foundation
import PathKit
@testable import SwiftyMockyCLICore


// MARK: - GenerationCommand
open class GenerationCommandMock: GenerationCommand, Mock {
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





    open func generate(disableCache: Bool, verbose: Bool) throws {
        addInvocation(.m_generate__disableCache_disableCacheverbose_verbose(Parameter<Bool>.value(`disableCache`), Parameter<Bool>.value(`verbose`)))
		let perform = methodPerformValue(.m_generate__disableCache_disableCacheverbose_verbose(Parameter<Bool>.value(`disableCache`), Parameter<Bool>.value(`verbose`))) as? (Bool, Bool) -> Void
		perform?(`disableCache`, `verbose`)
		do {
		    _ = try methodReturnValue(.m_generate__disableCache_disableCacheverbose_verbose(Parameter<Bool>.value(`disableCache`), Parameter<Bool>.value(`verbose`))).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }

    open func generate(mockName: String, disableCache: Bool, verbose: Bool, watch: Bool) throws {
        addInvocation(.m_generate__mockName_mockNamedisableCache_disableCacheverbose_verbosewatch_watch(Parameter<String>.value(`mockName`), Parameter<Bool>.value(`disableCache`), Parameter<Bool>.value(`verbose`), Parameter<Bool>.value(`watch`)))
		let perform = methodPerformValue(.m_generate__mockName_mockNamedisableCache_disableCacheverbose_verbosewatch_watch(Parameter<String>.value(`mockName`), Parameter<Bool>.value(`disableCache`), Parameter<Bool>.value(`verbose`), Parameter<Bool>.value(`watch`))) as? (String, Bool, Bool, Bool) -> Void
		perform?(`mockName`, `disableCache`, `verbose`, `watch`)
		do {
		    _ = try methodReturnValue(.m_generate__mockName_mockNamedisableCache_disableCacheverbose_verbosewatch_watch(Parameter<String>.value(`mockName`), Parameter<Bool>.value(`disableCache`), Parameter<Bool>.value(`verbose`), Parameter<Bool>.value(`watch`))).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }

    open func updateAllImports() throws {
        addInvocation(.m_updateAllImports)
		let perform = methodPerformValue(.m_updateAllImports) as? () -> Void
		perform?()
		do {
		    _ = try methodReturnValue(.m_updateAllImports).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }

    open func updateImports(forMockNamed name: String) throws {
        addInvocation(.m_updateImports__forMockNamed_name(Parameter<String>.value(`name`)))
		let perform = methodPerformValue(.m_updateImports__forMockNamed_name(Parameter<String>.value(`name`))) as? (String) -> Void
		perform?(`name`)
		do {
		    _ = try methodReturnValue(.m_updateImports__forMockNamed_name(Parameter<String>.value(`name`))).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }


    fileprivate enum MethodType {
        case m_generate__disableCache_disableCacheverbose_verbose(Parameter<Bool>, Parameter<Bool>)
        case m_generate__mockName_mockNamedisableCache_disableCacheverbose_verbosewatch_watch(Parameter<String>, Parameter<Bool>, Parameter<Bool>, Parameter<Bool>)
        case m_updateAllImports
        case m_updateImports__forMockNamed_name(Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_generate__disableCache_disableCacheverbose_verbose(let lhsDisablecache, let lhsVerbose), .m_generate__disableCache_disableCacheverbose_verbose(let rhsDisablecache, let rhsVerbose)):
                guard Parameter.compare(lhs: lhsDisablecache, rhs: rhsDisablecache, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsVerbose, rhs: rhsVerbose, with: matcher) else { return false } 
                return true 
            case (.m_generate__mockName_mockNamedisableCache_disableCacheverbose_verbosewatch_watch(let lhsMockname, let lhsDisablecache, let lhsVerbose, let lhsWatch), .m_generate__mockName_mockNamedisableCache_disableCacheverbose_verbosewatch_watch(let rhsMockname, let rhsDisablecache, let rhsVerbose, let rhsWatch)):
                guard Parameter.compare(lhs: lhsMockname, rhs: rhsMockname, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsDisablecache, rhs: rhsDisablecache, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsVerbose, rhs: rhsVerbose, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsWatch, rhs: rhsWatch, with: matcher) else { return false } 
                return true 
            case (.m_updateAllImports, .m_updateAllImports):
                return true 
            case (.m_updateImports__forMockNamed_name(let lhsName), .m_updateImports__forMockNamed_name(let rhsName)):
                guard Parameter.compare(lhs: lhsName, rhs: rhsName, with: matcher) else { return false } 
                return true 
            default: return false
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_generate__disableCache_disableCacheverbose_verbose(p0, p1): return p0.intValue + p1.intValue
            case let .m_generate__mockName_mockNamedisableCache_disableCacheverbose_verbosewatch_watch(p0, p1, p2, p3): return p0.intValue + p1.intValue + p2.intValue + p3.intValue
            case .m_updateAllImports: return 0
            case let .m_updateImports__forMockNamed_name(p0): return p0.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func generate(disableCache: Parameter<Bool>, verbose: Parameter<Bool>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_generate__disableCache_disableCacheverbose_verbose(`disableCache`, `verbose`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func generate(disableCache: Parameter<Bool>, verbose: Parameter<Bool>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_generate__disableCache_disableCacheverbose_verbose(`disableCache`, `verbose`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
        public static func generate(mockName: Parameter<String>, disableCache: Parameter<Bool>, verbose: Parameter<Bool>, watch: Parameter<Bool>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_generate__mockName_mockNamedisableCache_disableCacheverbose_verbosewatch_watch(`mockName`, `disableCache`, `verbose`, `watch`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func generate(mockName: Parameter<String>, disableCache: Parameter<Bool>, verbose: Parameter<Bool>, watch: Parameter<Bool>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_generate__mockName_mockNamedisableCache_disableCacheverbose_verbosewatch_watch(`mockName`, `disableCache`, `verbose`, `watch`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
        public static func updateAllImports(willThrow: Error...) -> MethodStub {
            return Given(method: .m_updateAllImports, products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func updateAllImports(willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_updateAllImports, products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
        public static func updateImports(forMockNamed name: Parameter<String>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_updateImports__forMockNamed_name(`name`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func updateImports(forMockNamed name: Parameter<String>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_updateImports__forMockNamed_name(`name`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func generate(disableCache: Parameter<Bool>, verbose: Parameter<Bool>) -> Verify { return Verify(method: .m_generate__disableCache_disableCacheverbose_verbose(`disableCache`, `verbose`))}
        public static func generate(mockName: Parameter<String>, disableCache: Parameter<Bool>, verbose: Parameter<Bool>, watch: Parameter<Bool>) -> Verify { return Verify(method: .m_generate__mockName_mockNamedisableCache_disableCacheverbose_verbosewatch_watch(`mockName`, `disableCache`, `verbose`, `watch`))}
        public static func updateAllImports() -> Verify { return Verify(method: .m_updateAllImports)}
        public static func updateImports(forMockNamed name: Parameter<String>) -> Verify { return Verify(method: .m_updateImports__forMockNamed_name(`name`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func generate(disableCache: Parameter<Bool>, verbose: Parameter<Bool>, perform: @escaping (Bool, Bool) -> Void) -> Perform {
            return Perform(method: .m_generate__disableCache_disableCacheverbose_verbose(`disableCache`, `verbose`), performs: perform)
        }
        public static func generate(mockName: Parameter<String>, disableCache: Parameter<Bool>, verbose: Parameter<Bool>, watch: Parameter<Bool>, perform: @escaping (String, Bool, Bool, Bool) -> Void) -> Perform {
            return Perform(method: .m_generate__mockName_mockNamedisableCache_disableCacheverbose_verbosewatch_watch(`mockName`, `disableCache`, `verbose`, `watch`), performs: perform)
        }
        public static func updateAllImports(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_updateAllImports, performs: perform)
        }
        public static func updateImports(forMockNamed name: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_updateImports__forMockNamed_name(`name`), performs: perform)
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
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - InstanceFactory
open class InstanceFactoryMock: InstanceFactory, Mock {
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





    open func resolveGenerationCommand(root: Path) throws -> GenerationCommand {
        addInvocation(.m_resolveGenerationCommand__root_root(Parameter<Path>.value(`root`)))
		let perform = methodPerformValue(.m_resolveGenerationCommand__root_root(Parameter<Path>.value(`root`))) as? (Path) -> Void
		perform?(`root`)
		var __value: GenerationCommand
		do {
		    __value = try methodReturnValue(.m_resolveGenerationCommand__root_root(Parameter<Path>.value(`root`))).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for resolveGenerationCommand(root: Path). Use given")
			Failure("Stub return value not specified for resolveGenerationCommand(root: Path). Use given")
		} catch {
		    throw error
		}
		return __value
    }

    open func resolveGenerationCommand(root: Path, mockfile: Mockfile) -> GenerationCommand {
        addInvocation(.m_resolveGenerationCommand__root_rootmockfile_mockfile(Parameter<Path>.value(`root`), Parameter<Mockfile>.value(`mockfile`)))
		let perform = methodPerformValue(.m_resolveGenerationCommand__root_rootmockfile_mockfile(Parameter<Path>.value(`root`), Parameter<Mockfile>.value(`mockfile`))) as? (Path, Mockfile) -> Void
		perform?(`root`, `mockfile`)
		var __value: GenerationCommand
		do {
		    __value = try methodReturnValue(.m_resolveGenerationCommand__root_rootmockfile_mockfile(Parameter<Path>.value(`root`), Parameter<Mockfile>.value(`mockfile`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for resolveGenerationCommand(root: Path, mockfile: Mockfile). Use given")
			Failure("Stub return value not specified for resolveGenerationCommand(root: Path, mockfile: Mockfile). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_resolveGenerationCommand__root_root(Parameter<Path>)
        case m_resolveGenerationCommand__root_rootmockfile_mockfile(Parameter<Path>, Parameter<Mockfile>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_resolveGenerationCommand__root_root(let lhsRoot), .m_resolveGenerationCommand__root_root(let rhsRoot)):
                guard Parameter.compare(lhs: lhsRoot, rhs: rhsRoot, with: matcher) else { return false } 
                return true 
            case (.m_resolveGenerationCommand__root_rootmockfile_mockfile(let lhsRoot, let lhsMockfile), .m_resolveGenerationCommand__root_rootmockfile_mockfile(let rhsRoot, let rhsMockfile)):
                guard Parameter.compare(lhs: lhsRoot, rhs: rhsRoot, with: matcher) else { return false } 
                guard Parameter.compare(lhs: lhsMockfile, rhs: rhsMockfile, with: matcher) else { return false } 
                return true 
            default: return false
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_resolveGenerationCommand__root_root(p0): return p0.intValue
            case let .m_resolveGenerationCommand__root_rootmockfile_mockfile(p0, p1): return p0.intValue + p1.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func resolveGenerationCommand(root: Parameter<Path>, willReturn: GenerationCommand...) -> MethodStub {
            return Given(method: .m_resolveGenerationCommand__root_root(`root`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func resolveGenerationCommand(root: Parameter<Path>, mockfile: Parameter<Mockfile>, willReturn: GenerationCommand...) -> MethodStub {
            return Given(method: .m_resolveGenerationCommand__root_rootmockfile_mockfile(`root`, `mockfile`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func resolveGenerationCommand(root: Parameter<Path>, mockfile: Parameter<Mockfile>, willProduce: (Stubber<GenerationCommand>) -> Void) -> MethodStub {
            let willReturn: [GenerationCommand] = []
			let given: Given = { return Given(method: .m_resolveGenerationCommand__root_rootmockfile_mockfile(`root`, `mockfile`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (GenerationCommand).self)
			willProduce(stubber)
			return given
        }
        public static func resolveGenerationCommand(root: Parameter<Path>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_resolveGenerationCommand__root_root(`root`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func resolveGenerationCommand(root: Parameter<Path>, willProduce: (StubberThrows<GenerationCommand>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_resolveGenerationCommand__root_root(`root`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (GenerationCommand).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func resolveGenerationCommand(root: Parameter<Path>) -> Verify { return Verify(method: .m_resolveGenerationCommand__root_root(`root`))}
        public static func resolveGenerationCommand(root: Parameter<Path>, mockfile: Parameter<Mockfile>) -> Verify { return Verify(method: .m_resolveGenerationCommand__root_rootmockfile_mockfile(`root`, `mockfile`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func resolveGenerationCommand(root: Parameter<Path>, perform: @escaping (Path) -> Void) -> Perform {
            return Perform(method: .m_resolveGenerationCommand__root_root(`root`), performs: perform)
        }
        public static func resolveGenerationCommand(root: Parameter<Path>, mockfile: Parameter<Mockfile>, perform: @escaping (Path, Mockfile) -> Void) -> Perform {
            return Perform(method: .m_resolveGenerationCommand__root_rootmockfile_mockfile(`root`, `mockfile`), performs: perform)
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
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

