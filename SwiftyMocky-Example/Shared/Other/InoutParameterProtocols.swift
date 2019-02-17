//
//  InoutParameterProtocols.swift
//  SwiftyMocky
//
//  Created by Andrzej Michnia on 17/02/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

//sourcery: AutoMockable
protocol InoutProtocol: class {
    func passThisAsInOut(value: inout URLRequest)
    func returnAndInOut(value: inout Int) -> String
}
