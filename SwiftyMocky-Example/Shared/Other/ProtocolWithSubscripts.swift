//
//  ProtocolWithSubscripts.swift
//  SwiftyMocky
//
//  Created by Andrzej Michnia on 26/09/2018.
//  Copyright © 2018 MakeAWishFoundation. All rights reserved.
//

import Foundation

//sourcery: AutoMockable
protocol ProtocolWithSubscripts {
    subscript (_ index: Int) -> String { get set }
    subscript (_ index: String) -> String { get set }
    subscript(label name: String) -> Int { get }
//    subscript<T>(with generic: T) -> Bool { get set }
    subscript(closure c: @escaping (Int) -> Void) -> Bool { get set }
}

