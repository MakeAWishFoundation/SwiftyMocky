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
//swiftlint:disable force_cast
//swiftlint:disable function_body_length
//swiftlint:disable line_length
//swiftlint:disable vertical_whitespace

    fileprivate var invocations: [MethodType] = []
    var methodReturnValues: [Given] = []
    var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default

    //MARK : ItemsRepository

    func storeItems(items: [Item]) {
        addInvocation(.storeItems__items_items(.value(items)))
		let perform = methodPerformValue(.storeItems__items_items(.value(items))) as? ([Item]) -> Void
		perform?(items)
    }

    func storeDetails(details: ItemDetails) {
        addInvocation(.storeDetails__details_details(.value(details)))
		let perform = methodPerformValue(.storeDetails__details_details(.value(details))) as? (ItemDetails) -> Void
		perform?(details)
    }

    func storedItems() -> [Item]? {
        addInvocation(.storedItems)
		let perform = methodPerformValue(.storedItems) as? () -> Void
		perform?()
		let value = methodReturnValue(.storedItems) as? [Item]?
		return value.orFail("stub return value not specified for storedItems(). Use given")
    }

    func storedDetails(item: Item) -> ItemDetails? {
        addInvocation(.storedDetails__item_item(.value(item)))
		let perform = methodPerformValue(.storedDetails__item_item(.value(item))) as? (Item) -> Void
		perform?(item)
		let value = methodReturnValue(.storedDetails__item_item(.value(item))) as? ItemDetails?
		return value.orFail("stub return value not specified for storedDetails(item: Item). Use given")
    }

    fileprivate enum MethodType {
        case storeItems__items_items(Parameter<[Item]>)
        case storeDetails__details_details(Parameter<ItemDetails>)
        case storedItems
        case storedDetails__item_item(Parameter<Item>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.storeItems__items_items(let lhsItems), .storeItems__items_items(let rhsItems)): 
                guard Parameter.compare(lhs: lhsItems, rhs: rhsItems, with: matcher) else { return false } 
                    return true 
                case (.storeDetails__details_details(let lhsDetails), .storeDetails__details_details(let rhsDetails)): 
                guard Parameter.compare(lhs: lhsDetails, rhs: rhsDetails, with: matcher) else { return false } 
                    return true 
                case (.storedItems, .storedItems): 
                    return true 
                case (.storedDetails__item_item(let lhsItem), .storedDetails__item_item(let rhsItem)): 
                guard Parameter.compare(lhs: lhsItem, rhs: rhsItem, with: matcher) else { return false } 
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case let .storeItems__items_items(p0): return p0.intValue
                case let .storeDetails__details_details(p0): return p0.intValue
                case .storedItems: return 0
                case let .storedDetails__item_item(p0): return p0.intValue
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
            return Given(method: .storedItems, returns: willReturn, throws: nil)
        }
        static func storedDetails(item: Parameter<Item>, willReturn: ItemDetails?) -> Given {
            return Given(method: .storedDetails__item_item(item), returns: willReturn, throws: nil)
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func storeItems(items: Parameter<[Item]>) -> Verify {
            return Verify(method: .storeItems__items_items(items))
        }
        static func storeDetails(details: Parameter<ItemDetails>) -> Verify {
            return Verify(method: .storeDetails__details_details(details))
        }
        static func storedItems() -> Verify {
            return Verify(method: .storedItems)
        }
        static func storedDetails(item: Parameter<Item>) -> Verify {
            return Verify(method: .storedDetails__item_item(item))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func storeItems(items: Parameter<[Item]>, perform: ([Item]) -> Void) -> Perform {
            return Perform(method: .storeItems__items_items(items), performs: perform)
        }
        static func storeDetails(details: Parameter<ItemDetails>, perform: (ItemDetails) -> Void) -> Perform {
            return Perform(method: .storeDetails__details_details(details), performs: perform)
        }
        static func storedItems(perform: () -> Void) -> Perform {
            return Perform(method: .storedItems, performs: perform)
        }
        static func storedDetails(item: Parameter<Item>, perform: (Item) -> Void) -> Perform {
            return Perform(method: .storedDetails__item_item(item), performs: perform)
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
    
// sourcery:end
}
