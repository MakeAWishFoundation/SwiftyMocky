//
//  ProtocolWithGenericsAndConstraintsTests.swift
//  Mocky_Tests_iOS
//
//  Created by przemyslaw.wosko on 25/02/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
import SwiftyMocky
#if os(iOS)
@testable import Mocky_Example_iOS
#elseif os(tvOS)
@testable import Mocky_Example_tvOS
#elseif os(macOS)
@testable import Mocky_Example_macOS
#endif

class ProtocolWithGenericsAndConstraintsTests: XCTestCase {

    func test_protocolWithGenericsAndConstraints() {
        let mock = ProtocolWithGenericsAndConstraintsMock()
    }

}
