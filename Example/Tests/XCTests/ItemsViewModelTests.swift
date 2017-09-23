//
//  ItemsViewModelTests.swift
//  Mocky
//
//  Created by przemyslaw.wosko on 20/05/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import XCTest
@testable import Mocky_Example
import Mocky
import RxSwift
import RxBlocking

class ItemsViewModelTests: XCTestCase {
    
    var sut: ItemsViewModel!
    var itemsModelMock: ItemsModelMock!
    
    override func setUp() {
        super.setUp()
        itemsModelMock = ItemsModelMock()
        sut = ItemsViewModel(itemsModel: itemsModelMock)
    }
    
    override func tearDown() {
        itemsModelMock = nil
        sut = nil
        super.tearDown()
    }
    
    func test_fetchItems() {
        itemsModelMock.given(.getExampleItems(willReturn: Observable.just([]) ))
        sut.fetchData()
        Verify(itemsModelMock, .getExampleItems)
    }

    func test_getItemsPrice() {
        let item1 = Item(name: "aaa", id: 1)
        let item2 = Item(name: "bbb", id: 2)

        itemsModelMock.matcher.register(Item.self) { (left, right) -> Bool in
            return left.id == right.id
        }

        if let comparator = itemsModelMock.matcher.comparator(for: Item.self) {
            print(comparator)

            XCTAssertTrue(comparator(item1, item1))
            XCTAssertTrue(comparator(item2, item2))
            XCTAssertFalse(comparator(item1, item2))
            XCTAssertFalse(comparator(item2, item1))
            print("done")
        } else {
            XCTFail()
        }

        itemsModelMock.given(.getPrice(item: .value(item1), willReturn: 10))
        itemsModelMock.given(.getPrice(item: .value(item2), willReturn: 100))

        let price1 = itemsModelMock.getPrice(for: item1)
        let price2 = itemsModelMock.getPrice(for: item2)

        XCTAssertEqual(price1, 10)
        XCTAssertEqual(price2, 100)
    }
}
