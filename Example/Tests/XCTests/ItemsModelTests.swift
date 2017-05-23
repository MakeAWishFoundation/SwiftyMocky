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
        itemsRepositoryMock.given(.storedItems(returns: [item]))
        
        let receivedItems = try! sut.getExampleItems().toBlocking().single()!
    
        XCTAssertEqual([item], receivedItems)
        Verify(itemsRepositoryMock, .storedItems)
    }
    
    func test_getItemDetails_should_whenNoItemsStored_shouldFetchItemsAndSave() {
        let item = Item(name: "itemName", id: 0)
        itemsRepositoryMock.given(.storedItems(returns: nil))
        itemsClientMock.given(.getExampleItems(returns: Observable.just([item])))
        
        let receivedItems = try! sut.getExampleItems().toBlocking().single()!
        
        XCTAssertEqual([item], receivedItems)
        Verify(itemsRepositoryMock, .storeItems(items: .value(receivedItems)))
        Verify(itemsClientMock, .getExampleItems)
    }
    
    func test_getItemDetails_whenNoDetailsStored_shouldFetchItemsAnsSave() {
        let item = Item(name: "itemName", id: 0)
        let details = ItemDetails(item: item, price: 0, description: ["desc": "value"])
        itemsRepositoryMock.given(.storedDetails(returns: nil))
        itemsClientMock.given(.getItemDetails(returns: Observable.just(details)))
        
        let reveivedDetails = try! sut.getItemDetails(item: item).toBlocking().single()!
        
        XCTAssertEqual(reveivedDetails, details)
        Verify(itemsRepositoryMock, .storedDetails(item: .value(item)))
        Verify(itemsClientMock, .getItemDetails(item: .value(item)))
        Verify(itemsRepositoryMock, .storeDetails(details: .value(details)))
    }
    
    func test_getItemDetails_whenDetailsAlreadyStored_shouldReturnSavedDetails() {
        let item = Item(name: "itemName", id: 0)
        let details = ItemDetails(item: item, price: 0, description: ["desc": "value"])
        itemsRepositoryMock.given(.storedDetails(returns: details))
        
        let reveivedDetails = try! sut.getItemDetails(item: item).toBlocking().single()!
        XCTAssertEqual(reveivedDetails, details)
        Verify(itemsRepositoryMock, .storedDetails(item: .value(item)))
    }
}
