//
//  ItemsModelMock.swift
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

// sourcery: mock = "ItemsModel"
class ItemsModelMock: ItemsModel, Mock {
    var some: Any = "manually supported property"
    var storedProperty: Any = ""

// sourcery:inline:auto:ItemsModelMock.autoMocked

    var invocations: [MethodType] = []
    var methodReturnValues: [MethodProxy] = []
    var matcher: Matcher = Matcher.default

    //MARK : ItemsModel

    var context: Any?    
    var storage: Any!    
    // var some: Any - not supported    
    // var storedProperty: Any - not supported    
                                            

    func getExampleItems() -> Observable<[Item]> {
        addInvocation(.getExampleItems)
        return methodReturnValue(.getExampleItems) as! Observable<[Item]> 
    }
    
    func getItemDetails(item: Item) -> Observable<ItemDetails> {
        addInvocation(.getItemDetails__item_item(.value(item)))
        return methodReturnValue(.getItemDetails__item_item(.value(item))) as! Observable<ItemDetails> 
    }
    
    func getPrice(for item: Item) -> Decimal {
        addInvocation(.getPrice__for_item(.value(item)))
        return methodReturnValue(.getPrice__for_item(.value(item))) as! Decimal 
    }
    
    enum MethodType {

        case getExampleItems    
        case getItemDetails__item_item(Parameter<Item>)    
        case getPrice__for_item(Parameter<Item>)    
        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {

                case (.getExampleItems, .getExampleItems): 
                    return true 
                case (.getItemDetails__item_item(let lhsItem), .getItemDetails__item_item(let rhsItem)): 
                    guard Parameter.compare(lhs: lhsItem, rhs: rhsItem, with: matcher) else { return false } 
                    return true 
                case (.getPrice__for_item(let lhsItem), .getPrice__for_item(let rhsItem)): 
                    guard Parameter.compare(lhs: lhsItem, rhs: rhsItem, with: matcher) else { return false } 
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

        static func getPrice(for item: Parameter<Item>, willReturn: Decimal) -> MethodProxy {
            return MethodProxy(method: .getPrice__for_item(item), returns: willReturn)
        }
    }

    struct VerificationProxy {
        var method: MethodType


        static func getExampleItems() -> VerificationProxy {
            return VerificationProxy(method: .getExampleItems)
        }

        static func getItemDetails(item item: Parameter<Item>) -> VerificationProxy {
            return VerificationProxy(method: .getItemDetails__item_item(item))
        }

        static func getPrice(for item: Parameter<Item>) -> VerificationProxy {
            return VerificationProxy(method: .getPrice__for_item(item))
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

    public func given(_ method: MethodProxy) {
        methodReturnValues.append(method)
    }
 
// sourcery:end
}
