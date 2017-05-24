//
//  ItemsModel.swift
//  Mocky
//
//  Created by przemyslaw.wosko on 19/05/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import RxSwift

protocol ItemsModel {
    func getExampleItems() -> Observable<[Item]>
    func getItemDetails(item: Item) -> Observable<ItemDetails>
}


class ConcreteItemsModel: ItemsModel {
    
    let itemsClient: ItemsClient
    let itemsRepository: ItemsRepository
    
    init(itemsClient: ItemsClient, itemsRepository: ItemsRepository) {
        self.itemsClient = itemsClient
        self.itemsRepository = itemsRepository
    }
    
    func getExampleItems() -> Observable<[Item]> {
    
        if let items = itemsRepository.storedItems() {
            return Observable.just(items)
        } else {
            return itemsClient.getExampleItems()
                .flatMap({ [weak self] (newItems) -> Observable<[Item]> in
                self?.itemsRepository.storeItems(items: [])
                return Observable.just(newItems)
            })
        }
    }
    
    func getItemDetails(item: Item) -> Observable<ItemDetails> {
        if let itemDetails = itemsRepository.storedDetails(item: item) {
            return Observable.just(itemDetails)
        } else {
            return itemsClient.getItemDetails(item:item)
                .flatMap({ [weak self] (itemDetails) -> Observable<ItemDetails> in
                    self?.itemsRepository.storeDetails(details: itemDetails)
                    return Observable.just(itemDetails)
                })
        }
    }
    
}
