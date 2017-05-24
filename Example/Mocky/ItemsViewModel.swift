//
//  ItemsViewModel.swift
//  Mocky
//
//  Created by przemyslaw.wosko on 19/05/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import RxSwift

class ItemsViewModel {
    
    let itemsModel: ItemsModel
    let disposeBag = DisposeBag()
    
    init(itemsModel: ItemsModel) {
        self.itemsModel = itemsModel
    }
    
    func fetchData() {
        itemsModel.getExampleItems().subscribe { (event) in
            switch event {
            case .next(let items):
                print(items)
            case .error(let error):
                print(error)
            case .completed: break
            }
        }.disposed(by: disposeBag)
    }
}
