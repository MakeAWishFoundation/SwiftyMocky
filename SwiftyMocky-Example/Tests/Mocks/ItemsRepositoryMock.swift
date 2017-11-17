//
//  ItemsRepositoryMock.swift
//  Mocky
//
//  Created by przemyslaw.wosko on 19/05/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import SwiftyMocky
import XCTest
@testable import Mocky_Example
import RxSwift

// sourcery: mock = "ItemsRepository"
class ItemsRepositoryMock: ItemsRepository, Mock {
// sourcery:inline:auto:ItemsRepositoryMock.autoMocked
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default


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
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.istoredItems)
		let value = givenValue.value as? [Item]?
		return value.orFail("stub return value not specified for storedItems(). Use given")
    }

    func storedDetails(item: Item) -> ItemDetails? {
        addInvocation(.istoredDetails__item_item(Parameter<Item>.value(item)))
		let perform = methodPerformValue(.istoredDetails__item_item(Parameter<Item>.value(item))) as? (Item) -> Void
		perform?(item)
		let givenValue: (value: Any?, error: Error?) = methodReturnValue(.istoredDetails__item_item(Parameter<Item>.value(item)))
		let value = givenValue.value as? ItemDetails?
		return value.orFail("stub return value not specified for storedDetails(item: Item). Use given")
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

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

        static func storedItems(willReturn: [Item]?) -> Given {
            return Given(method: .istoredItems, returns: willReturn, throws: nil)
        }
        static func storedDetails(item: Parameter<Item>, willReturn: ItemDetails?) -> Given {
            return Given(method: .istoredDetails__item_item(item), returns: willReturn, throws: nil)
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

        static func storeItems(items: Parameter<[Item]>, perform: ([Item]) -> Void) -> Perform {
            return Perform(method: .istoreItems__items_items(items), performs: perform)
        }
        static func storeDetails(details: Parameter<ItemDetails>, perform: (ItemDetails) -> Void) -> Perform {
            return Perform(method: .istoreDetails__details_details(details), performs: perform)
        }
        static func storedItems(perform: () -> Void) -> Perform {
            return Perform(method: .istoredItems, performs: perform)
        }
        static func storedDetails(item: Parameter<Item>, perform: (Item) -> Void) -> Perform {
            return Perform(method: .istoredDetails__item_item(item), performs: perform)
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
    
// sourcery:end
}
