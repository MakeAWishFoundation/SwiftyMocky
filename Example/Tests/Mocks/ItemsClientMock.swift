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
    //swiftlint:disable force_cast

    var invocations = [MethodType]()
    var methodReturnValues: [MethodProxy] = []

    //MARK : ItemsClient


    func getExampleItems() -> Observable<[Item]> {
        addInvocation(.getExampleItems)
        return methodReturnValue(.getExampleItems) as! Observable<[Item]> 
    }
    
    func getItemDetails(item: Item) -> Observable<ItemDetails> {
        addInvocation(.getItemDetails(item: .value(item)))
        return methodReturnValue(.getItemDetails(item: .value(item))) as! Observable<ItemDetails> 
    }
    
    func update(item: Item, withLimit limit: Decimal, expirationDate date: Date?) -> Single<Void> {
        addInvocation(.update(item: .value(item), limit: .value(limit), date: .value(date)))
        return methodReturnValue(.update(item: .value(item), limit: .value(limit), date: .value(date))) as! Single<Void> 
    }
    
    enum MethodType: Equatable {

        case getExampleItems    
        case getItemDetails(item : Parameter<Item>)    
        case update(item : Parameter<Item>,limit : Parameter<Decimal>,date : Parameter<Date?>)     
    
        static func ==(lhs: MethodType, rhs: MethodType) -> Bool {
            switch (lhs, rhs) {

                case (.getExampleItems, .getExampleItems): return true                
                case (.getItemDetails, .getItemDetails): return true                
                case (.update, .update): return true                 
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
        
        static func getItemDetails(item: Parameter<Item>, willReturn: Observable<ItemDetails>) -> MethodProxy {
            return MethodProxy(method: .getItemDetails(item: item), returns: willReturn)
        }
        
        static func update(item: Parameter<Item>, limit: Parameter<Decimal>, date: Parameter<Date?>, willReturn: Single<Void>) -> MethodProxy {
            return MethodProxy(method: .update(item: item, limit: limit, date: date), returns: willReturn)
        }
         
    }

    private func methodReturnValue(_ method: MethodType) -> Any? {
        let all = methodReturnValues.filter({ proxy -> Bool in
            return proxy.method == method
        })

        return all.last?.returns
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
            return method == call
        })
        return matchingInvocations
    }
    
    public func given(_ method: MethodProxy) {
        methodReturnValues.append(method)
    }
    
// sourcery:end
}
