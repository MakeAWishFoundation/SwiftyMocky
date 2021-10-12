//
//  MultiThreadAccessTests.swift
//  SwiftyMocky
//
//  Created by Andrzej Michnia on 05/03/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import XCTest
import SwiftyMocky
#if os(iOS)
    #if IOS15
        @testable import Mocky_Example_iOS_15
    #else
        @testable import Mocky_Example_iOS
    #endif
#elseif os(tvOS)
    @testable import Mocky_Example_tvOS
#else
    @testable import Mocky_Example_macOS
#endif

class CombinedFetcher {
    let fetcher: Fetcher
    var count = 0

    init(fetcher: Fetcher) {
        self.fetcher = fetcher
    }

    func fetch(forIds ids: [String], _ completion: @escaping () -> Void) {
        let queue = DispatchQueue(label: "test", attributes: .concurrent)
        let group = DispatchGroup()

        ids.forEach { id in
            group.enter()
            queue.async {
                _ = self.fetcher.fetchProperty(with: id)
                group.leave()
            }
        }

        group.notify(queue: DispatchQueue.main) {
            self.count += 1
            completion()
        }
    }
}

class CombinedFetcherTests: XCTestCase {

    func test_fetch() {
        let id1 = "id1"
        let id2 = "id2"
        let fetcher = FetcherMock()
        Given(fetcher, .fetchProperty(with: .value(id1), willReturn: ""))
        Given(fetcher, .fetchProperty(with: .value(id2), willReturn: ""))
        let sut = CombinedFetcher(fetcher: fetcher)
        let range = 1...100
        range.forEach { _ in
            let exp = expectation(description: "Fetch complete")
            sut.fetch(forIds: [id1, id2]) { exp.fulfill() }
            waitForExpectations(timeout: 2)
        }
    }
}
