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
// sourcery:inline:auto:ItemsModelMock.autoMocked
    var invocations = [ParameterType]()
    var methodReturnValues: [MethodProxy] = []

    func getExampleItems() -> Observable<[Item]> {
        addInvocation(.getExampleItems)
        return methodReturnValue(for: .getExampleItems) as! Observable<[Item]>
    }

    func getItemDetails(item: Item) -> Observable<ItemDetails> {
        addInvocation(.getItemDetails(item: .value(item)))
        return methodReturnValue(for: .getItemDetails(item: .value(item))) as! Observable<ItemDetails>
    }

    enum ParameterType : Equatable {
        case getExampleItems    
        case getItemDetails(item : Parameter<Item>)     
        
        static func ==(lhs: ParameterType, rhs: ParameterType) -> Bool {
            switch (lhs, rhs) {
                case (.getExampleItems, .getExampleItems): return true        
                case (let .getItemDetails(lhsParams), let .getItemDetails(rhsParams)): return lhsParams == rhsParams         
                default: return false    
            }
        }
    }

    // MARK: - NEW
    struct MethodProxy {
        fileprivate var method: ParameterType
        fileprivate var returns: Any?

        static func getExampleItems(willReturn: Observable<[Item]>) -> MethodProxy {
            return MethodProxy(method: .getExampleItems, returns: willReturn)
        }
        static func getItemDetails(item: Parameter<Item>, willReturn: Observable<ItemDetails>) -> MethodProxy {
            return MethodProxy(method: .getItemDetails(item: item), returns: willReturn)
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
