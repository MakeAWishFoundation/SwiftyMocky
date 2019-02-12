//
//  SelfConstrainedProtocol.swift
//  Mocky
//
//  Created by Andrzej Michnia on 09.01.2018.
//  Copyright © 2018 MakeAWishFoundation. All rights reserved.
//

import Foundation

//sourcery: AutoMockable
protocol SelfConstrainedProtocol {
    func methodReturningSelf() -> Self
    static func construct(param value: Int) -> Self
    func compare(with other: Self) -> Bool
    func genericMethodWithNestedSelf<T>(param: Int, second: T, other: (Self,Self)) -> Self
    func configure(with secret: String) throws -> Self
}
