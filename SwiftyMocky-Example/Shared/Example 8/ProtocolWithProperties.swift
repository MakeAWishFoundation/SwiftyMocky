//
//  ProtocolWithProperties.swift
//  SwiftyMocky
//
//  Created by Andrzej Michnia on 08.12.2017.
//  Copyright © 2017 MakeAWishFoundation. All rights reserved.
//

import Foundation

//sourcery: AutoMockable
protocol ProtocolWithProperties {
    var name: String { get set }
    static var name: String { get set }
    var email: String? { get set }
    static var defaultEmail: String? { get set }

    var internalProperty: InternalType { get set }

    // Methods cannot have labels called "set"
    func name(_ newValue: String)
    func email(_ newValue: String!)
    static func defaultEmail(_ newValue: String!)
}

internal struct InternalType { }
