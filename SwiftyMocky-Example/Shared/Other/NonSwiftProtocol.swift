//
//  NonSwiftProtocol.swift
//  Mocky_Example
//
//  Created by przemyslaw.wosko on 29/10/2017.
//  Copyright © 2017 MakeAWishFoundation. All rights reserved.
//

import Foundation

//sourcery: AutoMockable
//sourcery: ObjcProtocol
@objc protocol NonSwiftProtocol {
    @objc optional func returnNoting()
    func someMethod()
}
