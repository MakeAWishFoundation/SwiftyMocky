//
//  ExamplePrincipalClass.swift
//  Mocky
//
//  Created by przemyslaw.wosko on 29/09/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import SwiftyMocky

class ExamplePrincipalClass: NSObject {

    override init() {
        super.init()
        SwiftyMockyTestObserver.setup()
    }
}
