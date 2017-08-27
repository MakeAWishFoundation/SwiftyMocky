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
    
}
