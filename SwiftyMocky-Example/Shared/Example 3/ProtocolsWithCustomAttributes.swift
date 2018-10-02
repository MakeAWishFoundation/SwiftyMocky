//
//  ProtocolsWithCustomAttributes.swift
//  Mocky_Example
//
//  Created by Andrzej Michnia on 16.11.2017.
//  Copyright © 2017 MakeAWishFoundation. All rights reserved.
//

import Foundation

struct UserObject {
    let name: String
    let surname: String
    let age: Int
}

//sourcery: AutoMockable
protocol ProtocolWithTuples {
    func methodThatTakesTuple(tuple: (String,Int)) -> Int
}

//sourcery: AutoMockable
protocol ProtocolWithCustomAttributes {
    func methodThatTakesUser(user: UserObject) throws
    func methodThatTakesArrayOfUsers(array: [UserObject]) -> Int
}
