//
//  Item.swift
//  Mocky
//
//  Created by przemyslaw.wosko on 19/05/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

struct Item: AutoEquatable {
    let name: String
    let id: Int
}

struct ItemDetails: AutoEquatable {
    let item: Item
    let price: Decimal
    let description: [String: String]
}
