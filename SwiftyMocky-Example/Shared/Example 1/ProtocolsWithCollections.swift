//
//  ProtocolsWithCollections.swift
//  Mocky_Example
//
//  Created by Andrzej Michnia on 16.11.2017.
//  Copyright © 2017 MakeAWishFoundation. All rights reserved.
//

import Foundation

//sourcery: AutoMockable
protocol SimpleProtocolUsingCollections {
    func getArray() -> [Int]
    func map(array: [String], param: Int) -> [Int: String]
    func use(dictionary: [Int: String]) -> [Int: String]
    func verify(set: Set<Int>) -> Bool
}
