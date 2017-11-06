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

struct User {
    let name: String
}

struct NetworkConfig {
    let baseUrl: String
}

//sourcery: AutoMockable
protocol UserNetworkType {
    init(config: NetworkConfig)
    init(baseUrl: String)

    func getUser(for id: String, completion: (User?) -> Void)
    func getUserEscaping(for id: String, completion: @escaping (User?,Error?) -> Void)
    func doSomething(prop: @autoclosure () -> String)
    func testDefaultValues(value: String)
}

extension UserNetworkType {
    func testDefaultValues(value: String = "asd") {

    }
}
