//
//  ExampleProtocols.swift
//  Mocky_Example
//
//  Created by Andrzej Michnia on 25.10.2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

//sourcery: AutoMockable
protocol UserStorageType {
    func surname(for name: String) -> String
    func storeUser(name: String, surname: String)
}

class UsersViewModel {
    var usersStorage: UserStorageType!

    func saveUser(name: String, surname: String) {
        usersStorage.storeUser(name: name, surname: surname)
    }
}
