//
//  ItemsRepositoryMock.swift
//  Mocky
//
//  Created by przemyslaw.wosko on 19/05/2017.
//  Copyright © 2017 MakeAWishFoundation. All rights reserved.
//

import Foundation
import SwiftyMocky
import XCTest
@testable import Mocky_Example_iOS

// sourcery: mock = "ItemsRepository"
class ItemsRepositoryMock: ItemsRepository, Mock {
// sourcery:inline:auto:ItemsRepositoryMock.autoMocked
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






    open func storeItems(items: [Item]) {
        addInvocation(.m_storeItems__items_items(Parameter<[Item]>.value(`items`)))
		let perform = methodPerformValue(.m_storeItems__items_items(Parameter<[Item]>.value(`items`))) as? ([Item]) -> Void
		perform?(`items`)
    }

    open func storeDetails(details: ItemDetails) {
        addInvocation(.m_storeDetails__details_details(Parameter<ItemDetails>.value(`details`)))
		let perform = methodPerformValue(.m_storeDetails__details_details(Parameter<ItemDetails>.value(`details`))) as? (ItemDetails) -> Void
		perform?(`details`)
    }

    open func storedItems() -> [Item]? {
        addInvocation(.m_storedItems)
		let perform = methodPerformValue(.m_storedItems) as? () -> Void
		perform?()
		var __value: [Item]? = nil
		do {
		    __value = try methodReturnValue(.m_storedItems).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func storedDetails(item: Item) -> ItemDetails? {
        addInvocation(.m_storedDetails__item_item(Parameter<Item>.value(`item`)))
		let perform = methodPerformValue(.m_storedDetails__item_item(Parameter<Item>.value(`item`))) as? (Item) -> Void
		perform?(`item`)
		var __value: ItemDetails? = nil
		do {
		    __value = try methodReturnValue(.m_storedDetails__item_item(Parameter<Item>.value(`item`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_storeItems__items_items(Parameter<[Item]>)
        case m_storeDetails__details_details(Parameter<ItemDetails>)
        case m_storedItems
        case m_storedDetails__item_item(Parameter<Item>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_storeItems__items_items(let lhsItems), .m_storeItems__items_items(let rhsItems)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsItems, rhs: rhsItems, with: matcher), lhsItems, rhsItems, "items"))
				return Matcher.ComparisonResult(results)

            case (.m_storeDetails__details_details(let lhsDetails), .m_storeDetails__details_details(let rhsDetails)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDetails, rhs: rhsDetails, with: matcher), lhsDetails, rhsDetails, "details"))
				return Matcher.ComparisonResult(results)

            case (.m_storedItems, .m_storedItems): return .match

            case (.m_storedDetails__item_item(let lhsItem), .m_storedDetails__item_item(let rhsItem)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsItem, rhs: rhsItem, with: matcher), lhsItem, rhsItem, "item"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_storeItems__items_items(p0): return p0.intValue
            case let .m_storeDetails__details_details(p0): return p0.intValue
            case .m_storedItems: return 0
            case let .m_storedDetails__item_item(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_storeItems__items_items: return ".storeItems(items:)"
            case .m_storeDetails__details_details: return ".storeDetails(details:)"
            case .m_storedItems: return ".storedItems()"
            case .m_storedDetails__item_item: return ".storedDetails(item:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func storedItems(willReturn: [Item]?...) -> MethodStub {
            return Given(method: .m_storedItems, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func storedDetails(item: Parameter<Item>, willReturn: ItemDetails?...) -> MethodStub {
            return Given(method: .m_storedDetails__item_item(`item`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func storedItems(willProduce: (Stubber<[Item]?>) -> Void) -> MethodStub {
            let willReturn: [[Item]?] = []
			let given: Given = { return Given(method: .m_storedItems, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: ([Item]?).self)
			willProduce(stubber)
			return given
        }
        public static func storedDetails(item: Parameter<Item>, willProduce: (Stubber<ItemDetails?>) -> Void) -> MethodStub {
            let willReturn: [ItemDetails?] = []
			let given: Given = { return Given(method: .m_storedDetails__item_item(`item`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (ItemDetails?).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func storeItems(items: Parameter<[Item]>) -> Verify { return Verify(method: .m_storeItems__items_items(`items`))}
        public static func storeDetails(details: Parameter<ItemDetails>) -> Verify { return Verify(method: .m_storeDetails__details_details(`details`))}
        public static func storedItems() -> Verify { return Verify(method: .m_storedItems)}
        public static func storedDetails(item: Parameter<Item>) -> Verify { return Verify(method: .m_storedDetails__item_item(`item`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func storeItems(items: Parameter<[Item]>, perform: @escaping ([Item]) -> Void) -> Perform {
            return Perform(method: .m_storeItems__items_items(`items`), performs: perform)
        }
        public static func storeDetails(details: Parameter<ItemDetails>, perform: @escaping (ItemDetails) -> Void) -> Perform {
            return Perform(method: .m_storeDetails__details_details(`details`), performs: perform)
        }
        public static func storedItems(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_storedItems, performs: perform)
        }
        public static func storedDetails(item: Parameter<Item>, perform: @escaping (Item) -> Void) -> Perform {
            return Perform(method: .m_storedDetails__item_item(`item`), performs: perform)
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
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
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
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
    
// sourcery:end
}
