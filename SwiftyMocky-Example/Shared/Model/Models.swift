//
//  Models.swift
//  Mocky_Example
//
//  Created by Andrzej Michnia on 09.11.2017.
//  Copyright © 2017 MakeAWishFoundation. All rights reserved.
//

import Foundation

struct User {
    let name: String
}

struct NetworkConfig {
    let baseUrl: String
}

class UsersViewModel {
    var usersStorage: UserStorageType!
    var userNetwork: UserNetworkType!

    var id: String = "someid"
    var error: Error?
    var user: User?

    func saveUser(name: String, surname: String) {
        usersStorage.storeUser(name: name, surname: surname)
    }

    func fetchUser(completion: @escaping () -> Void) {
        userNetwork.getUser(for: id) { user in
            self.user = user
            completion()
        }
    }
}
