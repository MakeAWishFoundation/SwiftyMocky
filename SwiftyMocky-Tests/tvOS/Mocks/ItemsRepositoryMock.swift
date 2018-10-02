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
@testable import Mocky_Example_tvOS

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

    typealias PropertyStub = Given
    typealias MethodStub = Given
    typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }






    func storeItems(items: [Item]) {
        addInvocation(.m_storeItems__items_items(Parameter<[Item]>.value(`items`)))
		let perform = methodPerformValue(.m_storeItems__items_items(Parameter<[Item]>.value(`items`))) as? ([Item]) -> Void
		perform?(`items`)
    }

    func storeDetails(details: ItemDetails) {
        addInvocation(.m_storeDetails__details_details(Parameter<ItemDetails>.value(`details`)))
		let perform = methodPerformValue(.m_storeDetails__details_details(Parameter<ItemDetails>.value(`details`))) as? (ItemDetails) -> Void
		perform?(`details`)
    }

    func storedItems() -> [Item]? {
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

    func storedDetails(item: Item) -> ItemDetails? {
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

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_storeItems__items_items(let lhsItems), .m_storeItems__items_items(let rhsItems)):
                guard Parameter.compare(lhs: lhsItems, rhs: rhsItems, with: matcher) else { return false } 
                return true 
            case (.m_storeDetails__details_details(let lhsDetails), .m_storeDetails__details_details(let rhsDetails)):
                guard Parameter.compare(lhs: lhsDetails, rhs: rhsDetails, with: matcher) else { return false } 
                return true 
            case (.m_storedItems, .m_storedItems):
                return true 
            case (.m_storedDetails__item_item(let lhsItem), .m_storedDetails__item_item(let rhsItem)):
                guard Parameter.compare(lhs: lhsItem, rhs: rhsItem, with: matcher) else { return false } 
                return true 
            default: return false
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
    }

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }


        static func storedItems(willReturn: [Item]?...) -> MethodStub {
            return Given(method: .m_storedItems, products: willReturn.map({ Product.return($0) }))
        }
        static func storedDetails(item: Parameter<Item>, willReturn: ItemDetails?...) -> MethodStub {
            return Given(method: .m_storedDetails__item_item(`item`), products: willReturn.map({ Product.return($0) }))
        }
        static func storedItems(willProduce: (Stubber<[Item]?>) -> Void) -> MethodStub {
            let willReturn: [[Item]?] = []
			let given: Given = { return Given(method: .m_storedItems, products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: ([Item]?).self)
			willProduce(stubber)
			return given
        }
        static func storedDetails(item: Parameter<Item>, willProduce: (Stubber<ItemDetails?>) -> Void) -> MethodStub {
            let willReturn: [ItemDetails?] = []
			let given: Given = { return Given(method: .m_storedDetails__item_item(`item`), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (ItemDetails?).self)
			willProduce(stubber)
			return given
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func storeItems(items: Parameter<[Item]>) -> Verify { return Verify(method: .m_storeItems__items_items(`items`))}
        static func storeDetails(details: Parameter<ItemDetails>) -> Verify { return Verify(method: .m_storeDetails__details_details(`details`))}
        static func storedItems() -> Verify { return Verify(method: .m_storedItems)}
        static func storedDetails(item: Parameter<Item>) -> Verify { return Verify(method: .m_storedDetails__item_item(`item`))}
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func storeItems(items: Parameter<[Item]>, perform: @escaping ([Item]) -> Void) -> Perform {
            return Perform(method: .m_storeItems__items_items(`items`), performs: perform)
        }
        static func storeDetails(details: Parameter<ItemDetails>, perform: @escaping (ItemDetails) -> Void) -> Perform {
            return Perform(method: .m_storeDetails__details_details(`details`), performs: perform)
        }
        static func storedItems(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_storedItems, performs: perform)
        }
        static func storedDetails(item: Parameter<Item>, perform: @escaping (Item) -> Void) -> Perform {
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
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
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
    
// sourcery:end
}
