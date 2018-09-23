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
@testable import Mocky_Example_macOS

// sourcery: mock = "ItemsRepository"
class ItemsRepositoryMock: ItemsRepository, Mock {
// sourcery:inline:auto:ItemsRepositoryMock.autoMocked
    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []



    typealias Property = Swift.Never


    func storeItems(items: [Item]) {
        addInvocation(.istoreItems__items_items(Parameter<[Item]>.value(items)))
		let perform = methodPerformValue(.istoreItems__items_items(Parameter<[Item]>.value(items))) as? ([Item]) -> Void
		perform?(items)
    }

    func storeDetails(details: ItemDetails) {
        addInvocation(.istoreDetails__details_details(Parameter<ItemDetails>.value(details)))
		let perform = methodPerformValue(.istoreDetails__details_details(Parameter<ItemDetails>.value(details))) as? (ItemDetails) -> Void
		perform?(details)
    }

    func storedItems() -> [Item]? {
        addInvocation(.istoredItems)
		let perform = methodPerformValue(.istoredItems) as? () -> Void
		perform?()
		var __value: [Item]?
		do {
		    __value = try methodReturnValue(.istoredItems).casted()
		} catch {
			Failure("stub return value not specified for storedItems(). Use given")
		}

		return __value
    }

    func storedDetails(item: Item) -> ItemDetails? {
        addInvocation(.istoredDetails__item_item(Parameter<Item>.value(item)))
		let perform = methodPerformValue(.istoredDetails__item_item(Parameter<Item>.value(item))) as? (Item) -> Void
		perform?(item)
		var __value: ItemDetails?
		do {
		    __value = try methodReturnValue(.istoredDetails__item_item(Parameter<Item>.value(item))).casted()
		} catch {
			Failure("stub return value not specified for storedDetails(item: Item). Use given")
		}

		return __value
    }

    fileprivate enum MethodType {
        case istoreItems__items_items(Parameter<[Item]>)
        case istoreDetails__details_details(Parameter<ItemDetails>)
        case istoredItems
        case istoredDetails__item_item(Parameter<Item>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.istoreItems__items_items(let lhsItems), .istoreItems__items_items(let rhsItems)):
                    guard Parameter.compare(lhs: lhsItems, rhs: rhsItems, with: matcher) else { return false } 
                    return true 
                case (.istoreDetails__details_details(let lhsDetails), .istoreDetails__details_details(let rhsDetails)):
                    guard Parameter.compare(lhs: lhsDetails, rhs: rhsDetails, with: matcher) else { return false } 
                    return true 
                case (.istoredItems, .istoredItems):
                    return true 
                case (.istoredDetails__item_item(let lhsItem), .istoredDetails__item_item(let rhsItem)):
                    guard Parameter.compare(lhs: lhsItem, rhs: rhsItem, with: matcher) else { return false } 
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case let .istoreItems__items_items(p0): return p0.intValue
                case let .istoreDetails__details_details(p0): return p0.intValue
                case .istoredItems: return 0
                case let .istoredDetails__item_item(p0): return p0.intValue
            }
        }
    }

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }

        static func storedItems(willReturn: [Item]?...) -> Given {
            return Given(method: .istoredItems, products: willReturn.map({ Product.return($0) }))
        }
        static func storedDetails(item: Parameter<Item>, willReturn: ItemDetails?...) -> Given {
            return Given(method: .istoredDetails__item_item(item), products: willReturn.map({ Product.return($0) }))
        }
        static func storedItems(willProduce: (Stubber<[Item]?>) -> Void) -> Given {
            let willReturn: [[Item]?] = []
			let given: Given = { return Given(method: .istoredItems, products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: ([Item]?).self)
			willProduce(stubber)
			return given
        }
        static func storedDetails(item: Parameter<Item>, willProduce: (Stubber<ItemDetails?>) -> Void) -> Given {
            let willReturn: [ItemDetails?] = []
			let given: Given = { return Given(method: .istoredDetails__item_item(item), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (ItemDetails?).self)
			willProduce(stubber)
			return given
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func storeItems(items: Parameter<[Item]>) -> Verify {
            return Verify(method: .istoreItems__items_items(items))
        }
        static func storeDetails(details: Parameter<ItemDetails>) -> Verify {
            return Verify(method: .istoreDetails__details_details(details))
        }
        static func storedItems() -> Verify {
            return Verify(method: .istoredItems)
        }
        static func storedDetails(item: Parameter<Item>) -> Verify {
            return Verify(method: .istoredDetails__item_item(item))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func storeItems(items: Parameter<[Item]>, perform: @escaping ([Item]) -> Void) -> Perform {
            return Perform(method: .istoreItems__items_items(items), performs: perform)
        }
        static func storeDetails(details: Parameter<ItemDetails>, perform: @escaping (ItemDetails) -> Void) -> Perform {
            return Perform(method: .istoreDetails__details_details(details), performs: perform)
        }
        static func storedItems(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .istoredItems, performs: perform)
        }
        static func storedDetails(item: Parameter<Item>, perform: @escaping (Item) -> Void) -> Perform {
            return Perform(method: .istoredDetails__item_item(item), performs: perform)
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
    
// sourcery:end
}
