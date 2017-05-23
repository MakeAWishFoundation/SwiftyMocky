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
    var invocations = [ParameterType]()
    var methodReturnValues: [MethodProxy] = []

    func storeItems(items: [Item]) {
        addInvocation(.storeItems(items: .value(items)))
    }

    func storeDetails(details: ItemDetails) {
        addInvocation(.storeDetails(details: .value(details)))
    }

    func storedItems() -> [Item]? {
        addInvocation(.storedItems)
        return methodReturnValue(for: .storedItems) as? [Item]
    }

    func storedDetails(item: Item) -> ItemDetails? {
        addInvocation(.storedDetails(item: .value(item)))
        return methodReturnValue(for: .storedDetails(item: .value(item))) as? ItemDetails
    }

    enum ParameterType : Equatable {
        case storeItems(items : Parameter<[Item]>)
        case storeDetails(details : Parameter<ItemDetails>)    
        case storedItems    
        case storedDetails(item : Parameter<Item>)     
        
        static func ==(lhs: ParameterType, rhs: ParameterType) -> Bool {
            switch (lhs, rhs) {
                case (let .storeItems(lhsParams), let .storeItems(rhsParams)): return lhsParams == rhsParams        
                case (let .storeDetails(lhsParams), let .storeDetails(rhsParams)): return lhsParams == rhsParams        
                case (.storedItems, .storedItems): return true        
                case (let .storedDetails(lhsParams), let .storedDetails(rhsParams)): return lhsParams == rhsParams         
                default: return false    
            }
        }
    }

    // MARK: - NEW
    struct MethodProxy {
        fileprivate var method: ParameterType
        fileprivate var returns: Any?

        static func storeItems(items: Parameter<[Item]>) -> MethodProxy {
            return MethodProxy(method: .storeItems(items: items), returns: nil)
        }
        static func storeDetails(details : Parameter<ItemDetails>) -> MethodProxy {
            return MethodProxy(method: .storeDetails(details: details), returns: nil)
        }
        static func storedItems(willReturn: [Item]?) -> MethodProxy {
            return MethodProxy(method: .storedItems, returns: willReturn)
        }
        static func storedDetails(item : Parameter<Item>, willReturn: ItemDetails?) -> MethodProxy {
            return MethodProxy(method: .storedDetails(item: item), returns: willReturn)
        }
    }

    fileprivate func methodReturnValue(for method: ParameterType) -> Any? {
        let all = methodReturnValues.filter({ proxy -> Bool in
            return proxy.method == method
        })

        return all.last?.returns
    }

    func given(_ method: MethodProxy) {
        methodReturnValues.append(method)
    }
// sourcery:end
}
