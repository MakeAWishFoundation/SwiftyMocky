//
//  ProtocolWithGenericsAndConstraints.swift
//  SwiftyMocky
//
//  Created by przemyslaw.wosko on 25/02/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

protocol ProtocolWithGenericsAndConstraints: AutoMockable {
    func save<T: Codable>(data: T) throws
    func getData<T: Codable>() -> T?
}
