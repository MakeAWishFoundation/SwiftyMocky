//
//  NonSwiftProtocol.swift
//  Mocky_Example
//
//  Created by przemyslaw.wosko on 29/10/2017.
//  Copyright © 2017 MakeAWishFoundation. All rights reserved.
//

import Foundation

//sourcery: AutoMockable
@objc protocol NonSwiftProtocol {
    @objc optional func returnNoting()
    func someMethod()
}

//sourcery: AutoMockable
@objc(PRProtocolWithObjc) public protocol ProtocolWithObjc {

    @objc(doStaticStuffWithParameter1: andParameter2:)
    static func doStaticStuff(parameter1: String, parameter2: String)

    @objc(doStuffWithParameter1: andParameter2:)
    func doStuff(parameter1: String, parameter2: String)
}
