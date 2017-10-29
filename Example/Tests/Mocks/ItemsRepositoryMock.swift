//
//  ItemsRepositoryMock.swift
//  Mocky
//
//  Created by przemyslaw.wosko on 19/05/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import Mocky
import XCTest
@testable import Mocky_Example
import RxSwift

// sourcery: mock = "ItemsRepository"
class ItemsRepositoryMock: ItemsRepository, Mock {
// sourcery:inline:auto:ItemsRepositoryMock.autoMocked

    var invocations: [MethodType] = []
    var methodReturnValues: [MethodProxy] = []
    var matcher: Matcher = Matcher.default
        
    //MARK : ItemsRepository
        

    func storeItems(items: [Item]) {
        addInvocation(.storeItems__items_items(.value(items)))
        
    }
    
    func storeDetails(details: ItemDetails) {
        addInvocation(.storeDetails__details_details(.value(details)))
        
    }
    
    func storedItems() -> [Item]? {
        addInvocation(.storedItems)
        return methodReturnValue(.storedItems) as! [Item]? 
    }
    
    func storedDetails(item: Item) -> ItemDetails? {
        addInvocation(.storedDetails__item_item(.value(item)))
        return methodReturnValue(.storedDetails__item_item(.value(item))) as! ItemDetails? 
    }
    
    enum MethodType {

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

    struct MethodProxy {
        var method: MethodType
        var returns: Any?

        static func storedItems(willReturn: [Item]?) -> MethodProxy {
            return MethodProxy(method: .storedItems, returns: willReturn)
        }

        static func storedDetails(item item: Parameter<Item>, willReturn: ItemDetails?) -> MethodProxy {
            return MethodProxy(method: .storedDetails__item_item(item), returns: willReturn)
        }
    }

    struct VerificationProxy {
        var method: MethodType


        static func storeItems(items items: Parameter<[Item]>) -> VerificationProxy {
            return VerificationProxy(method: .storeItems__items_items(items))
        }

        static func storeDetails(details details: Parameter<ItemDetails>) -> VerificationProxy {
            return VerificationProxy(method: .storeDetails__details_details(details))
        }

        static func storedItems() -> VerificationProxy {
            return VerificationProxy(method: .storedItems)
        }

        static func storedDetails(item item: Parameter<Item>) -> VerificationProxy {
            return VerificationProxy(method: .storedDetails__item_item(item))
        }
    }

    public func methodReturnValue(_ method: MethodType) -> Any? {
        let matched = methodReturnValues.reversed().first(where: { proxy -> Bool in
            return MethodType.compareParameters(lhs: proxy.method, rhs: method, matcher: matcher)
        })

        return matched?.returns
    }

    public func verify(_ method: VerificationProxy, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    public func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    public func matchingCalls(_ method: MethodType) -> [MethodType] {
        let matchingInvocations = invocations.filter({ (call) -> Bool in
            return MethodType.compareParameters(lhs: call, rhs: method, matcher: matcher)
        })
        return matchingInvocations
    }

    public func matchingCalls(_ method: VerificationProxy) -> [MethodType] {
        return matchingCalls(method.method)
    }

    public func given(_ method: MethodProxy) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }
    
// sourcery:end
}
