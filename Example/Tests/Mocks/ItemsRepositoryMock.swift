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

    var returnValues: [ReturnType] = []
    var invocations = [ParameterType]()


    func storeItems(items: [Item]) {  addInvocation(.storeItems(items: .value(items)))  }    
    func storeDetails(details: ItemDetails) {  addInvocation(.storeDetails(details: .value(details)))  }    
    func storedItems() -> [Item]? {  addInvocation(.storedItems)  ; return returnValue(.storedItems )  }    
    func storedDetails(item: Item) -> ItemDetails? {  addInvocation(.storedDetails(item: .value(item)))  ; return returnValue(.storedDetails )  }     

enum SignatureType {

    case storeItems    
    case storeDetails    
    case storedItems    
    case storedDetails    
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

enum ReturnType: AutoValue {

        
        
    case storedItems(returns: [Item]?)    
    case storedDetails(returns: ItemDetails?)    
}
// sourcery:end
}
