//
//  ProtocolWithInitializers.swift
//  Mocky_Example
//
//  Created by Andrzej Michnia on 17.11.2017.
//  Copyright © 2017 MakeAWishFoundation. All rights reserved.
//

import Foundation

//sourcery: AutoMockable
protocol ProtocolWithInitializers {
    var param: Int { get }
    var other: String { get }

    init(param: Int, other: String)
    init(param: Int)
}
