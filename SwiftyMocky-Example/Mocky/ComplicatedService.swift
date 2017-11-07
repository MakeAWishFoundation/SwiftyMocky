//
//  ComplicatedService.swift
//  Mocky_Example
//
//  Created by Andrzej Michnia on 24.10.2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

protocol SimpleServiceType: AutoMockable {
    var youCouldOnlyGetThis: String { get }
    func serviceName() -> String
}

// sourcery: AutoMockable
protocol ComplicatedServiceType: SampleServiceType, SimpleServiceType {
    var youCouldOnlyGetThis:String { get }
    func serviceName() -> String
    func aNewWayToSayHooray() -> Void
}

