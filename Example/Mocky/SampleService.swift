//
//  SampleService.swift
//  Mocky
//
//  Created by Andrzej Michnia on 24.09.2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

struct Point {
    let x: Float
    let y: Float
}

protocol SampleServiceType {
    func serviceName() -> String
    func getPoint(from point: Point) -> Point
    func getPoint(from tuple: (Float,Float)) -> Point
    func similarMethodThatDiffersOnType(_ value: Float) -> Bool
    func similarMethodThatDiffersOnType(_ value: Point) -> Bool
}
