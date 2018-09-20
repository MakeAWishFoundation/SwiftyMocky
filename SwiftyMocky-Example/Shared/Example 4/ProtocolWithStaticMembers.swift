//
//  ProtocolWithStaticMembers.swift
//  Mocky_Example
//
//  Created by Andrzej Michnia on 16.11.2017.
//  Copyright © 2017 MakeAWishFoundation. All rights reserved.
//

import Foundation

//sourcery: AutoMockable
protocol ProtocolWithStaticMembers {
    static var staticProperty: String { get }
    static func staticMethod(param: Int) throws -> Int
}
