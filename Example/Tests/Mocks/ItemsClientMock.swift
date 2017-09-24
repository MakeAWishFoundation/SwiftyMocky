//
//  ItemsClientMock.swift
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

// sourcery: mock = "ItemsClient"
class ItemsClientMock: ItemsClient, Mock {
// sourcery:inline:auto:ItemsClientMock.autoMocked

    var invocations: [MethodType] = []
    var methodReturnValues: [MethodProxy] = []
    var matcher: Matcher = Matcher.default

    //MARK : ItemsClient


            
            
            


    func getExampleItems() -> Observable<[Item]> {
        addInvocation(.getExampleItems)
        return methodReturnValue(.getExampleItems) as! Observable<[Item]> 
    }
    
    func getItemDetails(item: Item) -> Observable<ItemDetails> {
        addInvocation(.getItemDetails__item_item(.value(item)))
        return methodReturnValue(.getItemDetails__item_item(.value(item))) as! Observable<ItemDetails> 
    }
    
    func update(item: Item, withLimit limit: Decimal, expirationDate date: Date?) -> Single<Void> {
        addInvocation(.update__item_itemwithLimit_limitexpirationDate_date(.value(item), .value(limit), .value(date)))
        return methodReturnValue(.update__item_itemwithLimit_limitexpirationDate_date(.value(item), .value(limit), .value(date))) as! Single<Void> 
    }
    
    enum MethodType {

        case getExampleItems    
        case getItemDetails__item_item(Parameter<Item>)    
        case update__item_itemwithLimit_limitexpirationDate_date(Parameter<Item>, Parameter<Decimal>, Parameter<Date?>)    
        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {

                case (.getExampleItems, .getExampleItems): 
                    return true 
                case (.getItemDetails__item_item(let lhsItem), .getItemDetails__item_item(let rhsItem)): 
                    guard Parameter.compare(lhs: lhsItem, rhs: rhsItem, with: matcher) else { return false } 
                    return true 
                case (.update__item_itemwithLimit_limitexpirationDate_date(let lhsItem, let lhsLimit, let lhsDate), .update__item_itemwithLimit_limitexpirationDate_date(let rhsItem, let rhsLimit, let rhsDate)): 
                    guard Parameter.compare(lhs: lhsItem, rhs: rhsItem, with: matcher) else { return false } 
                    guard Parameter.compare(lhs: lhsLimit, rhs: rhsLimit, with: matcher) else { return false } 
                    guard Parameter.compare(lhs: lhsDate, rhs: rhsDate, with: matcher) else { return false } 
                    return true 
                default: return false
            }
        }
    }

    struct MethodProxy {
        var method: MethodType
        var returns: Any?

        static func getExampleItems(willReturn: Observable<[Item]>) -> MethodProxy {
            return MethodProxy(method: .getExampleItems, returns: willReturn)
        }
        
        static func getItemDetails(item item: Parameter<Item>, willReturn: Observable<ItemDetails>) -> MethodProxy {
            return MethodProxy(method: .getItemDetails__item_item(item), returns: willReturn)
        }
        
        static func update(item item: Parameter<Item>, withLimit limit: Parameter<Decimal>, expirationDate date: Parameter<Date?>, willReturn: Single<Void>) -> MethodProxy {
            return MethodProxy(method: .update__item_itemwithLimit_limitexpirationDate_date(item, limit, date), returns: willReturn)
        }
            }

    public func methodReturnValue(_ method: MethodType) -> Any? {
        let matched = methodReturnValues.reversed().first(where: { proxy -> Bool in
            return MethodType.compareParameters(lhs: proxy.method, rhs: method, matcher: matcher)
        })

        return matched?.returns
    }

    public func verify(_ method: MethodType, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
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

    public func given(_ method: MethodProxy) {
        methodReturnValues.append(method)
    }
    
// sourcery:end
}
