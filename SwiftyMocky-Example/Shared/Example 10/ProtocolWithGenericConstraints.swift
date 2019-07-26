//
//  ProtocolWithGenericConstraints.swift
//  SwiftyMocky
//
//  Created by Oleksandr Demishkevych on 7/17/19.
//  Copyright © 2018 MakeAWishFoundation. All rights reserved.
//

import Foundation

// sourcery: AutoMockable
// sourcery: associatedtype = "ContainedType"
protocol ProtocolWithGenericConstraints {
    associatedtype ContainedType
    var value: ContainedType { get }

    func extractString<U: CustomStringConvertible>() -> String? where ContainedType == Optional<U>
}
