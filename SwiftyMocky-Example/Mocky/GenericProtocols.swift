//
//  GenericProtocols.swift
//  Mocky_Example
//
//  Created by Andrzej Michnia on 09.11.2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

//sourcery: AutoMockable
public protocol DateSortable {
    var date: Date { get }
}

//sourcery: AutoMockable
public protocol HistorySectionMapperType: class {
    func map<T: DateSortable>(_ items: [T]) ->  [(key: String, items: [T])]
}
