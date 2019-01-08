//
//  ItemsRepositoryMock.swift
//  Mocky
//
//  Created by przemyslaw.wosko on 19/05/2017.
//  Copyright © 2017 MakeAWishFoundation. All rights reserved.
//

import Foundation
import SwiftyMocky
import XCTest
@testable import Mocky_Example_macOS

// sourcery: mock = "ItemsRepository"
class ItemsRepositoryMock: ItemsRepository, Mock {
// sourcery:inline:auto:ItemsRepositoryMock.autoMocked
    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    typealias PropertyStub = Given
    typealias MethodStub = Given
    typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }






    func storedDetails(item: Item) -> ItemDetails? {
        addInvocation(.m_storedDetails__item_item(Parameter<Item>.value(`item`)))
		let perform = methodPerformValue(.m_storedDetails__item_item(Parameter<Item>.value(`item`))) as? (Item) -> Void
		perform?(`item`)
		var __value: ItemDetails? = nil
		do {
		    __value = try methodReturnValue(.m_storedDetails__item_item(Parameter<Item>.value(`item`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_storedDetails__item_item(Parameter<Item>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_storedDetails__item_item(let lhsItem), .m_storedDetails__item_item(let rhsItem)):
                guard Parameter.compare(lhs: lhsItem, rhs: rhsItem, with: matcher) else { return false } 
                return true 
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_storedDetails__item_item(p0): return p0.intValue
            }
        }
    }

    class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [Product]) {
            self.method = method
            super.init(products)
        }


        static func storedDetails(item: Parameter<Item>, willReturn: ItemDetails?...) -> MethodStub {
            return Given(method: .m_storedDetails__item_item(`item`), products: willReturn.map({ Product.return($0) }))
        }
        static func storedDetails(item: Parameter<Item>, willProduce: (Stubber<ItemDetails?>) -> Void) -> MethodStub {
            let willReturn: [ItemDetails?] = []
			let given: Given = { return Given(method: .m_storedDetails__item_item(`item`), products: willReturn.map({ Product.return($0) })) }()
			let stubber = given.stub(for: (ItemDetails?).self)
			willProduce(stubber)
			return given
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func storedDetails(item: Parameter<Item>) -> Verify { return Verify(method: .m_storedDetails__item_item(`item`))}
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func storedDetails(item: Parameter<Item>, perform: @escaping (Item) -> Void) -> Perform {
            return Perform(method: .m_storedDetails__item_item(`item`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expeced: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> Product {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
    
// sourcery:end
}
