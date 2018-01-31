//
//  ProtocolWithSimilarMethods.swift
//  SwiftyMocky
//
//  Created by Andrzej Michnia on 31.01.2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

//sourcery: AutoMockable
protocol ProtocolMethodsThatDifferOnlyInReturnType {
    func foo(bar: String) -> String
    func foo(bar: String) -> Int
}
