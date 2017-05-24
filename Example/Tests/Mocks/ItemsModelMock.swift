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

    var returnValues: [ReturnType] = []
    var invocations = [ParameterType]()


    func getExampleItems() -> Observable<[Item]> {  addInvocation(.getExampleItems)  ; return returnValue(.getExampleItems )  }    
    func getItemDetails(item: Item) -> Observable<ItemDetails> {  addInvocation(.getItemDetails(item: .value(item)))  ; return returnValue(.getItemDetails )  }     

enum SignatureType {

    case getExampleItems    
    case getItemDetails    
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

enum ReturnType: AutoValue {

    case getExampleItems(returns: Observable<[Item]>)    
    case getItemDetails(returns: Observable<ItemDetails>)    
}
// sourcery:end
}
