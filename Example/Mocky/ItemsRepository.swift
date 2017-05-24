//
//  ItemsRepository.swift
//  Mocky
//
//  Created by przemyslaw.wosko on 19/05/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

protocol ItemsRepository {
    func storeItems(items: [Item])
    func storeDetails(details: ItemDetails)
    func storedItems() -> [Item]?
    func storedDetails(item: Item) -> ItemDetails?
}

class ConcreteItemsRepository: ItemsRepository {
    
    func storeItems(items: [Item]) {
        
    }
    
    func storeDetails(details: ItemDetails) {
        
    }
    
    func storedItems() -> [Item]? {
        return nil
    }
    
    func storedDetails(item: Item) -> ItemDetails? {
        return nil
    }
}
