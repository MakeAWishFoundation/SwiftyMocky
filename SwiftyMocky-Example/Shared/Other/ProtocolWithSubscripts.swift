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
    func aaa(_ value: Int) -> Bool
    var something: Any { get set }
    subscript (_ index: Int) -> String { get set }
    subscript (x: Int, y: Int) -> String { get set }
    subscript (_ index: String) -> String { get set }
    subscript(label name: String) -> Int { get }
//    //sourcery: associatedtype = "T: Sequence where T.Element: Sequence"
//    subscript<T: Sequence>(with generic: T) -> Bool where T.Element: Sequence { get set }
    subscript(closure c: @escaping (Int) -> Void) -> Bool { get set }
}
