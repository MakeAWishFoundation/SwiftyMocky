//
//  ProtocolWithInitializersTests.swift
//  Mocky_Tests
//
//  Created by Andrzej Michnia on 17.11.2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
import SwiftyMocky
@testable import Mocky_Example

class ProtocolWithInitializersTests: XCTestCase {
    func test_protocol_with_initializers() {
        // You can use all defined initializers
        let mock1 = ProtocolWithInitializersMock(param: 1)
        let mock2 = ProtocolWithInitializersMock(param: 2, other: "something")

        // Please hav in mind, that they are only to satisfy protocol requirements
        // there is no logic behind that, and so all properties has to be set manually anyway
        mock1.param = 1
        mock1.other = ""
        mock2.param = 2
        mock2.other = "something"
    }
}
