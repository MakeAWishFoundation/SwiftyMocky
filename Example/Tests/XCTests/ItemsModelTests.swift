//
//  ItemsModelTests.swift
//  Mocky
//
//  Created by przemyslaw.wosko on 20/05/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import Mocky_Example
import RxBlocking
import Mocky
import RxSwift

class ItemsModelTests: XCTestCase {
    
    var sut: ConcreteItemsModel!
    var itemsClientMock: ItemsClientMock!
    var itemsRepositoryMock: ItemsRepositoryMock!
    
    override func setUp() {
        super.setUp()

        Matcher.default.register(ItemDetails.self) { (lhs, rhs) -> Bool in
            return lhs.item.id == rhs.item.id
        }

        Matcher.default.register(Item.self) { (lhs, rhs) -> Bool in
            return lhs.id == rhs.id
        }

        itemsClientMock = ItemsClientMock()
        itemsRepositoryMock = ItemsRepositoryMock()
        sut = ConcreteItemsModel(itemsClient: itemsClientMock, itemsRepository: itemsRepositoryMock)
    }
    
    override func tearDown() {
        itemsClientMock = nil
        itemsRepositoryMock = nil
        sut = nil
        super.tearDown()
    }
    
    func test_getExampleItems_whenItemsStored_shouldReturnStoredItems() {
        let item = Item(name: "itemName", id: 0)

        Given(itemsRepositoryMock, .storedItems(willReturn: [item]))
        let receivedItem = try! sut.getExampleItems().toBlocking().single()!.first
    
        XCTAssertEqual(item.name, receivedItem?.name)
        Verify(itemsRepositoryMock, .storedItems())
    }

    func test_getItemDetails_should_whenNoItemsStored_shouldFetchItemsAndSave() {
        itemsClientMock.matcher.register(Item.self) { (left, right) -> Bool in
            return left.id == right.id
        }

        let item = Item(name: "itemName", id: 0)
        itemsRepositoryMock.given(.storedItems(willReturn: nil))
        itemsClientMock.given(.getExampleItems(willReturn: Observable.just([item])))

        let receivedItem = try! sut.getExampleItems().toBlocking().single()!.first
        
        XCTAssertEqual(item.name, receivedItem?.name)

        itemsRepositoryMock.verify(.storeItems(items: .value([item])))
        itemsClientMock.verify(.getExampleItems())
    }

    func test_getItemDetails_whenNoDetailsStored_shouldFetchItemsAnsSave() {
        let item = Item(name: "itemName1", id: 1)
        let details = ItemDetails(item: item, price: 0, description: ["desc": "value"])

        itemsRepositoryMock.given(.storedDetails(item: .value(item), willReturn: nil))
        itemsClientMock.given(.getItemDetails(item: .any, willReturn: Observable.just(details)))

        let reveivedDetails = try! sut.getItemDetails(item: item).toBlocking().single()!

        XCTAssertEqual(reveivedDetails.item.id, details.item.id)
        itemsRepositoryMock.verify(.storedDetails(item: .value(item)))
        itemsClientMock.verify(.getItemDetails(item: .value(item)))
        itemsRepositoryMock.verify(.storeDetails(details: .value(details)))
    }

    func test_getItemDetails_whenDetailsAlreadyStored_shouldReturnSavedDetails() {
        let item = Item(name: "itemName", id: 0)
        let details = ItemDetails(item: item, price: 0, description: ["desc": "value"])

        itemsRepositoryMock.given(.storedDetails(item: .any, willReturn: details))

        let reveivedDetails = try! sut.getItemDetails(item: item).toBlocking().single()!

        XCTAssertEqual(reveivedDetails.item.id, details.item.id)
        itemsRepositoryMock.verify(.storedDetails(item: .value(item)))
    }
}
