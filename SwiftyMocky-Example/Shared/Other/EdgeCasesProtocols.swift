//
//  File.swift
//  Mocky
//
//  Created by Andrzej Michnia on 28.09.2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

struct Mytest<Key, Value> {
    let value: Value
    let key: Key
}

//sourcery: AutoMockable
protocol EdgeCasesGenericsProtocol {
    func sorted<Key, Value>(by key: Mytest<Key, Value>)
    func getter<K,V: Sequence,T>(swapped key: Mytest<K,V>) -> T
}
