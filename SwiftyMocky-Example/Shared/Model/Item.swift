//
//  Item.swift
//  Mocky
//
//  Created by przemyslaw.wosko on 19/05/2017.
//  Copyright © 2017 MakeAWishFoundation. All rights reserved.
//

import Foundation

struct Item {
    let name: String
    let id: Int
}

struct ItemDetails {
    let item: Item
    let price: Decimal
    let description: [String: String]
}
