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
    //swiftlint:disable force_cast

    var invocations = [MethodType]()
    var methodReturnValues: [MethodProxy] = []

    //MARK : ItemsRepository


    func storeItems(items: [Item]) {
        addInvocation(.storeItems(items: .value(items)))
        
    }
    
    func storeDetails(details: ItemDetails) {
        addInvocation(.storeDetails(details: .value(details)))
        
    }
    
    func storedItems() -> [Item]? {
        addInvocation(.storedItems)
        return methodReturnValue(.storedItems) as! [Item]? 
    }
    
    func storedDetails(item: Item) -> ItemDetails? {
        addInvocation(.storedDetails(item: .value(item)))
        return methodReturnValue(.storedDetails(item: .value(item))) as! ItemDetails? 
    }
    
    enum MethodType: Equatable {

        case storeItems(items : Parameter<[Item]>)    
        case storeDetails(details : Parameter<ItemDetails>)    
        case storedItems    
        case storedDetails(item : Parameter<Item>)     
    
        static func ==(lhs: MethodType, rhs: MethodType) -> Bool {
            switch (lhs, rhs) {

                case (.storeItems, .storeItems): return true                
                case (.storeDetails, .storeDetails): return true                
                case (.storedItems, .storedItems): return true                
                case (.storedDetails, .storedDetails): return true                 
                default: return false   
            }
        }
    }

    struct MethodProxy {
        var method: MethodType 
        var returns: Any? 

        static func storeItems(items: Parameter<[Item]>, willReturn: Void) -> MethodProxy {
            return MethodProxy(method: .storeItems(items: items), returns: willReturn)
        }
        
        static func storeDetails(details: Parameter<ItemDetails>, willReturn: Void) -> MethodProxy {
            return MethodProxy(method: .storeDetails(details: details), returns: willReturn)
        }
        
        static func storedItems(willReturn: [Item]?) -> MethodProxy {
            return MethodProxy(method: .storedItems, returns: willReturn)
        }
        
        static func storedDetails(item: Parameter<Item>, willReturn: ItemDetails?) -> MethodProxy {
            return MethodProxy(method: .storedDetails(item: item), returns: willReturn)
        }
         
    }

    private func methodReturnValue(_ method: MethodType) -> Any? {
        let all = methodReturnValues.filter({ proxy -> Bool in
            return proxy.method == method
        })

        return all.last?.returns
    }
// sourcery:end
}
