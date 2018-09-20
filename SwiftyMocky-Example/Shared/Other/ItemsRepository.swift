//
//  ItemsRepository.swift
//  Mocky
//
//  Created by przemyslaw.wosko on 19/05/2017.
//  Copyright © 2017 MakeAWishFoundation. All rights reserved.
//

import Foundation

protocol ItemsRepository {
    func storeItems(items: [Item])
    func storeDetails(details: ItemDetails)
    func storedItems() -> [Item]?
    func storedDetails(item: Item) -> ItemDetails?
}

