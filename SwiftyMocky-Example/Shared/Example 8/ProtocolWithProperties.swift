//
//  ProtocolWithProperties.swift
//  SwiftyMocky
//
//  Created by Andrzej Michnia on 08.12.2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

//sourcery: AutoMockable
protocol ProtocolWithPropoerties {
    var name: String { get set }
    static var name: String { get set }
    var email: String? { get set }
    static var defaultEmail: String? { get set }

    func name(set newValue: String)
    func email(set: String!)
    static func defaultEmail(set newValue: String!)
}
