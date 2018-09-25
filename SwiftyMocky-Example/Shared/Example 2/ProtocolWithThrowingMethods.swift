//
//  ProtocolWithThrowingMethods.swift
//  Mocky_Example
//
//  Created by Andrzej Michnia on 16.11.2017.
//  Copyright © 2017 MakeAWishFoundation. All rights reserved.
//

import Foundation

//sourcery: AutoMockable
protocol ProtocolWithThrowingMethods {
    func methodThatThrows() throws
    func methodThatReturnsAndThrows(param: Int) throws -> Bool
}
