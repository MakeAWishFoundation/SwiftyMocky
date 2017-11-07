// Generated using Sourcery 0.9.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


#if Mocky
import SwiftyMocky
import XCTest

import RxSwift
@testable import Mocky_Example

#else
import Sourcery
import SourceryRuntime
#endif

//swiftlint:disable force_cast
//swiftlint:disable function_body_length
//swiftlint:disable line_length
//swiftlint:disable vertical_whitespace



// MARK: - ComplicatedServiceType
class ComplicatedServiceTypeMock: ComplicatedServiceType, Mock {
    fileprivate var invocations: [MethodType] = []
    var methodReturnValues: [Given] = []
    var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default

    var youCouldOnlyGetThis: String { 
		get { return __youCouldOnlyGetThis.orFail("ComplicatedServiceTypeMock - value for youCouldOnlyGetThis was not defined") }
		set { __youCouldOnlyGetThis = newValue }
	}
	private var __youCouldOnlyGetThis: (String)?

    func serviceName() -> String {
        addInvocation(.serviceName)
		let perform = methodPerformValue(.serviceName) as? () -> Void
		perform?()
		let value = methodReturnValue(.serviceName) as? String
		return value.orFail("stub return value not specified for serviceName(). Use given")
    }

    func aNewWayToSayHooray() {
        addInvocation(.aNewWayToSayHooray)
		let perform = methodPerformValue(.aNewWayToSayHooray) as? () -> Void
		perform?()
    }

    func getPoint(from point: Point) -> Point {
        addInvocation(.getPoint__from_point(.value(point)))
		let perform = methodPerformValue(.getPoint__from_point(.value(point))) as? (Point) -> Void
		perform?(point)
		let value = methodReturnValue(.getPoint__from_point(.value(point))) as? Point
		return value.orFail("stub return value not specified for getPoint(from point: Point). Use given")
    }

    func getPoint(from tuple: (Float,Float)) -> Point {
        addInvocation(.getPoint__from_tuple(.value(tuple)))
		let perform = methodPerformValue(.getPoint__from_tuple(.value(tuple))) as? ((Float,Float)) -> Void
		perform?(tuple)
		let value = methodReturnValue(.getPoint__from_tuple(.value(tuple))) as? Point
		return value.orFail("stub return value not specified for getPoint(from tuple: (Float,Float)). Use given")
    }

    func similarMethodThatDiffersOnType(_ value: Float) -> Bool {
        addInvocation(.similarMethodThatDiffersOnType__value_1(.value(value)))
		let perform = methodPerformValue(.similarMethodThatDiffersOnType__value_1(.value(value))) as? (Float) -> Void
		perform?(value)
		let value = methodReturnValue(.similarMethodThatDiffersOnType__value_1(.value(value))) as? Bool
		return value.orFail("stub return value not specified for similarMethodThatDiffersOnType(_ value: Float). Use given")
    }

    func similarMethodThatDiffersOnType(_ value: Point) -> Bool {
        addInvocation(.similarMethodThatDiffersOnType__value_2(.value(value)))
		let perform = methodPerformValue(.similarMethodThatDiffersOnType__value_2(.value(value))) as? (Point) -> Void
		perform?(value)
		let value = methodReturnValue(.similarMethodThatDiffersOnType__value_2(.value(value))) as? Bool
		return value.orFail("stub return value not specified for similarMethodThatDiffersOnType(_ value: Point). Use given")
    }

    func methodWithTypedef(_ scalar: Scalar) {
        addInvocation(.methodWithTypedef__scalar(.value(scalar)))
		let perform = methodPerformValue(.methodWithTypedef__scalar(.value(scalar))) as? (Scalar) -> Void
		perform?(scalar)
    }

    func methodWithClosures(success function: LinearFunction) -> ClosureFabric {
        addInvocation(.methodWithClosures__success_function_1(Parameter<LinearFunction>.any))
		let perform = methodPerformValue(.methodWithClosures__success_function_1(Parameter<LinearFunction>.any)) as? (LinearFunction) -> Void
		perform?(function)
		let value = methodReturnValue(.methodWithClosures__success_function_1(Parameter<LinearFunction>.any)) as? ClosureFabric
		return value.orFail("stub return value not specified for methodWithClosures(success function: LinearFunction). Use given")
    }

    func methodWithClosures(success function: ((Scalar,Scalar) -> Scalar)?) -> ((Int) -> Void) {
        addInvocation(.methodWithClosures__success_function_2(.value(function)))
		let perform = methodPerformValue(.methodWithClosures__success_function_2(.value(function))) as? (((Scalar,Scalar) -> Scalar)?) -> Void
		perform?(function)
		let value = methodReturnValue(.methodWithClosures__success_function_2(.value(function))) as? ((Int) -> Void)
		return value.orFail("stub return value not specified for methodWithClosures(success function: ((Scalar,Scalar) -> Scalar)?). Use given")
    }

    fileprivate enum MethodType {
        case serviceName
        case aNewWayToSayHooray
        case getPoint__from_point(Parameter<Point>)
        case getPoint__from_tuple(Parameter<(Float,Float)>)
        case similarMethodThatDiffersOnType__value_1(Parameter<Float>)
        case similarMethodThatDiffersOnType__value_2(Parameter<Point>)
        case methodWithTypedef__scalar(Parameter<Scalar>)
        case methodWithClosures__success_function_1(Parameter<LinearFunction>)
        case methodWithClosures__success_function_2(Parameter<((Scalar,Scalar) -> Scalar)?>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.serviceName, .serviceName): 
                    return true 
                case (.aNewWayToSayHooray, .aNewWayToSayHooray): 
                    return true 
                case (.getPoint__from_point(let lhsPoint), .getPoint__from_point(let rhsPoint)): 
                    guard Parameter.compare(lhs: lhsPoint, rhs: rhsPoint, with: matcher) else { return false } 
                    return true 
                case (.getPoint__from_tuple(let lhsTuple), .getPoint__from_tuple(let rhsTuple)): 
                    guard Parameter.compare(lhs: lhsTuple, rhs: rhsTuple, with: matcher) else { return false } 
                    return true 
                case (.similarMethodThatDiffersOnType__value_1(let lhsValue), .similarMethodThatDiffersOnType__value_1(let rhsValue)): 
                    guard Parameter.compare(lhs: lhsValue, rhs: rhsValue, with: matcher) else { return false } 
                    return true 
                case (.similarMethodThatDiffersOnType__value_2(let lhsValue), .similarMethodThatDiffersOnType__value_2(let rhsValue)): 
                    guard Parameter.compare(lhs: lhsValue, rhs: rhsValue, with: matcher) else { return false } 
                    return true 
                case (.methodWithTypedef__scalar(let lhsScalar), .methodWithTypedef__scalar(let rhsScalar)): 
                    guard Parameter.compare(lhs: lhsScalar, rhs: rhsScalar, with: matcher) else { return false } 
                    return true 
                case (.methodWithClosures__success_function_1(let lhsFunction), .methodWithClosures__success_function_1(let rhsFunction)): 
                    guard Parameter.compare(lhs: lhsFunction, rhs: rhsFunction, with: matcher) else { return false } 
                    return true 
                case (.methodWithClosures__success_function_2(let lhsFunction), .methodWithClosures__success_function_2(let rhsFunction)): 
                    guard Parameter.compare(lhs: lhsFunction, rhs: rhsFunction, with: matcher) else { return false } 
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case .serviceName: return 0
                case .aNewWayToSayHooray: return 0
                case let .getPoint__from_point(p0): return p0.intValue
                case let .getPoint__from_tuple(p0): return p0.intValue
                case let .similarMethodThatDiffersOnType__value_1(p0): return p0.intValue
                case let .similarMethodThatDiffersOnType__value_2(p0): return p0.intValue
                case let .methodWithTypedef__scalar(p0): return p0.intValue
                case let .methodWithClosures__success_function_1(p0): return p0.intValue
                case let .methodWithClosures__success_function_2(p0): return p0.intValue
            }
        }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

        static func serviceName(willReturn: String) -> Given {
            return Given(method: .serviceName, returns: willReturn, throws: nil)
        }
        static func getPoint(from point: Parameter<Point>, willReturn: Point) -> Given {
            return Given(method: .getPoint__from_point(point), returns: willReturn, throws: nil)
        }
        static func getPoint(from tuple: Parameter<(Float,Float)>, willReturn: Point) -> Given {
            return Given(method: .getPoint__from_tuple(tuple), returns: willReturn, throws: nil)
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Float>, willReturn: Bool) -> Given {
            return Given(method: .similarMethodThatDiffersOnType__value_1(value), returns: willReturn, throws: nil)
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Point>, willReturn: Bool) -> Given {
            return Given(method: .similarMethodThatDiffersOnType__value_2(value), returns: willReturn, throws: nil)
        }
        static func methodWithClosures(success function: Parameter<LinearFunction>, willReturn: ClosureFabric) -> Given {
            return Given(method: .methodWithClosures__success_function_1(function), returns: willReturn, throws: nil)
        }
        static func methodWithClosures(success function: Parameter<((Scalar,Scalar) -> Scalar)?>, willReturn: ((Int) -> Void)) -> Given {
            return Given(method: .methodWithClosures__success_function_2(function), returns: willReturn, throws: nil)
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func serviceName() -> Verify {
            return Verify(method: .serviceName)
        }
        static func aNewWayToSayHooray() -> Verify {
            return Verify(method: .aNewWayToSayHooray)
        }
        static func getPoint(from point: Parameter<Point>) -> Verify {
            return Verify(method: .getPoint__from_point(point))
        }
        static func getPoint(from tuple: Parameter<(Float,Float)>) -> Verify {
            return Verify(method: .getPoint__from_tuple(tuple))
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Float>) -> Verify {
            return Verify(method: .similarMethodThatDiffersOnType__value_1(value))
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Point>) -> Verify {
            return Verify(method: .similarMethodThatDiffersOnType__value_2(value))
        }
        static func methodWithTypedef(scalar: Parameter<Scalar>) -> Verify {
            return Verify(method: .methodWithTypedef__scalar(scalar))
        }
        static func methodWithClosures(success function: Parameter<LinearFunction>) -> Verify {
            return Verify(method: .methodWithClosures__success_function_1(function))
        }
        static func methodWithClosures(success function: Parameter<((Scalar,Scalar) -> Scalar)?>) -> Verify {
            return Verify(method: .methodWithClosures__success_function_2(function))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func serviceName(perform: () -> Void) -> Perform {
            return Perform(method: .serviceName, performs: perform)
        }
        static func aNewWayToSayHooray(perform: () -> Void) -> Perform {
            return Perform(method: .aNewWayToSayHooray, performs: perform)
        }
        static func getPoint(from point: Parameter<Point>, perform: (Point) -> Void) -> Perform {
            return Perform(method: .getPoint__from_point(point), performs: perform)
        }
        static func getPoint(from tuple: Parameter<(Float,Float)>, perform: ((Float,Float)) -> Void) -> Perform {
            return Perform(method: .getPoint__from_tuple(tuple), performs: perform)
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Float>, perform: (Float) -> Void) -> Perform {
            return Perform(method: .similarMethodThatDiffersOnType__value_1(value), performs: perform)
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Point>, perform: (Point) -> Void) -> Perform {
            return Perform(method: .similarMethodThatDiffersOnType__value_2(value), performs: perform)
        }
        static func methodWithTypedef(scalar: Parameter<Scalar>, perform: (Scalar) -> Void) -> Perform {
            return Perform(method: .methodWithTypedef__scalar(scalar), performs: perform)
        }
        static func methodWithClosures(success function: Parameter<LinearFunction>, perform: (LinearFunction) -> Void) -> Perform {
            return Perform(method: .methodWithClosures__success_function_1(function), performs: perform)
        }
        static func methodWithClosures(success function: Parameter<((Scalar,Scalar) -> Scalar)?>, perform: (((Scalar,Scalar) -> Scalar)?) -> Void) -> Perform {
            return Perform(method: .methodWithClosures__success_function_2(function), performs: perform)
        }
    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> Any? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.returns != nil  }
        return matched?.returns
    }

    private func methodThrowValue(_ method: MethodType) -> Error? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.`throws` != nil  }
        return matched?.`throws`
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}
// MARK: - ItemsClient
class ItemsClientMock: ItemsClient, Mock {
    fileprivate var invocations: [MethodType] = []
    var methodReturnValues: [Given] = []
    var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default


    func getExampleItems() -> Observable<[Item]> {
        addInvocation(.getExampleItems)
		let perform = methodPerformValue(.getExampleItems) as? () -> Void
		perform?()
		let value = methodReturnValue(.getExampleItems) as? Observable<[Item]>
		return value.orFail("stub return value not specified for getExampleItems(). Use given")
    }

    func getItemDetails(item: Item) -> Observable<ItemDetails> {
        addInvocation(.getItemDetails__item_item(.value(item)))
		let perform = methodPerformValue(.getItemDetails__item_item(.value(item))) as? (Item) -> Void
		perform?(item)
		let value = methodReturnValue(.getItemDetails__item_item(.value(item))) as? Observable<ItemDetails>
		return value.orFail("stub return value not specified for getItemDetails(item: Item). Use given")
    }

    func update(item: Item, withLimit limit: Decimal, expirationDate date: Date?) -> Single<Void> {
        addInvocation(.update__item_itemwithLimit_limitexpirationDate_date(.value(item), .value(limit), .value(date)))
		let perform = methodPerformValue(.update__item_itemwithLimit_limitexpirationDate_date(.value(item), .value(limit), .value(date))) as? (Item, Decimal, Date?) -> Void
		perform?(item, limit, date)
		let value = methodReturnValue(.update__item_itemwithLimit_limitexpirationDate_date(.value(item), .value(limit), .value(date))) as? Single<Void>
		return value.orFail("stub return value not specified for update(item: Item, withLimit limit: Decimal, expirationDate date: Date?). Use given")
    }

    fileprivate enum MethodType {
        case getExampleItems
        case getItemDetails__item_item(Parameter<Item>)
        case update__item_itemwithLimit_limitexpirationDate_date(Parameter<Item>, Parameter<Decimal>, Parameter<Date?>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.getExampleItems, .getExampleItems): 
                    return true 
                case (.getItemDetails__item_item(let lhsItem), .getItemDetails__item_item(let rhsItem)): 
                    guard Parameter.compare(lhs: lhsItem, rhs: rhsItem, with: matcher) else { return false } 
                    return true 
                case (.update__item_itemwithLimit_limitexpirationDate_date(let lhsItem, let lhsLimit, let lhsDate), .update__item_itemwithLimit_limitexpirationDate_date(let rhsItem, let rhsLimit, let rhsDate)): 
                    guard Parameter.compare(lhs: lhsItem, rhs: rhsItem, with: matcher) else { return false } 
                    guard Parameter.compare(lhs: lhsLimit, rhs: rhsLimit, with: matcher) else { return false } 
                    guard Parameter.compare(lhs: lhsDate, rhs: rhsDate, with: matcher) else { return false } 
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case .getExampleItems: return 0
                case let .getItemDetails__item_item(p0): return p0.intValue
                case let .update__item_itemwithLimit_limitexpirationDate_date(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            }
        }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

        static func getExampleItems(willReturn: Observable<[Item]>) -> Given {
            return Given(method: .getExampleItems, returns: willReturn, throws: nil)
        }
        static func getItemDetails(item: Parameter<Item>, willReturn: Observable<ItemDetails>) -> Given {
            return Given(method: .getItemDetails__item_item(item), returns: willReturn, throws: nil)
        }
        static func update(item: Parameter<Item>, withLimit limit: Parameter<Decimal>, expirationDate date: Parameter<Date?>, willReturn: Single<Void>) -> Given {
            return Given(method: .update__item_itemwithLimit_limitexpirationDate_date(item, limit, date), returns: willReturn, throws: nil)
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func getExampleItems() -> Verify {
            return Verify(method: .getExampleItems)
        }
        static func getItemDetails(item: Parameter<Item>) -> Verify {
            return Verify(method: .getItemDetails__item_item(item))
        }
        static func update(item: Parameter<Item>, withLimit limit: Parameter<Decimal>, expirationDate date: Parameter<Date?>) -> Verify {
            return Verify(method: .update__item_itemwithLimit_limitexpirationDate_date(item, limit, date))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func getExampleItems(perform: () -> Void) -> Perform {
            return Perform(method: .getExampleItems, performs: perform)
        }
        static func getItemDetails(item: Parameter<Item>, perform: (Item) -> Void) -> Perform {
            return Perform(method: .getItemDetails__item_item(item), performs: perform)
        }
        static func update(item: Parameter<Item>, withLimit limit: Parameter<Decimal>, expirationDate date: Parameter<Date?>, perform: (Item, Decimal, Date?) -> Void) -> Perform {
            return Perform(method: .update__item_itemwithLimit_limitexpirationDate_date(item, limit, date), performs: perform)
        }
    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> Any? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.returns != nil  }
        return matched?.returns
    }

    private func methodThrowValue(_ method: MethodType) -> Error? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.`throws` != nil  }
        return matched?.`throws`
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}
// MARK: - ItemsModel
class ItemsModelMock: ItemsModel, Mock {
    fileprivate var invocations: [MethodType] = []
    var methodReturnValues: [Given] = []
    var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default

    static var defaultIdentifier: Int { 
		get { return ItemsModelMock.__defaultIdentifier.orFail("ItemsModelMock - value for defaultIdentifier was not defined") }
		set { ItemsModelMock.__defaultIdentifier = newValue }
	}
	private static var __defaultIdentifier: (Int)?
    static var optionalIdentifier: String? { 
		get { return ItemsModelMock.__optionalIdentifier.orFail("ItemsModelMock - value for optionalIdentifier was not defined") }
		set { ItemsModelMock.__optionalIdentifier = newValue }
	}
	private static var __optionalIdentifier: (String)?
    var context: Any? { 
		get { return __context.orFail("ItemsModelMock - value for context was not defined") }
		set { __context = newValue }
	}
	private var __context: (Any)?
    var storage: Any! { 
		get { return __storage.orFail("ItemsModelMock - value for storage was not defined") }
		set { __storage = newValue }
	}
	private var __storage: (Any)?
    var some: Any { 
		get { return __some.orFail("ItemsModelMock - value for some was not defined") }
		set { __some = newValue }
	}
	private var __some: (Any)?
    var storedProperty: Any { 
		get { return __storedProperty.orFail("ItemsModelMock - value for storedProperty was not defined") }
		set { __storedProperty = newValue }
	}
	private var __storedProperty: (Any)?

    func getExampleItems() -> Observable<[Item]> {
        addInvocation(.getExampleItems)
		let perform = methodPerformValue(.getExampleItems) as? () -> Void
		perform?()
		let value = methodReturnValue(.getExampleItems) as? Observable<[Item]>
		return value.orFail("stub return value not specified for getExampleItems(). Use given")
    }

    func getItemDetails(item: Item) -> Observable<ItemDetails> {
        addInvocation(.getItemDetails__item_item(.value(item)))
		let perform = methodPerformValue(.getItemDetails__item_item(.value(item))) as? (Item) -> Void
		perform?(item)
		let value = methodReturnValue(.getItemDetails__item_item(.value(item))) as? Observable<ItemDetails>
		return value.orFail("stub return value not specified for getItemDetails(item: Item). Use given")
    }

    func getPrice(for item: Item) -> Decimal {
        addInvocation(.getPrice__for_item(.value(item)))
		let perform = methodPerformValue(.getPrice__for_item(.value(item))) as? (Item) -> Void
		perform?(item)
		let value = methodReturnValue(.getPrice__for_item(.value(item))) as? Decimal
		return value.orFail("stub return value not specified for getPrice(for item: Item). Use given")
    }

    fileprivate enum MethodType {
        case getExampleItems
        case getItemDetails__item_item(Parameter<Item>)
        case getPrice__for_item(Parameter<Item>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.getExampleItems, .getExampleItems): 
                    return true 
                case (.getItemDetails__item_item(let lhsItem), .getItemDetails__item_item(let rhsItem)): 
                    guard Parameter.compare(lhs: lhsItem, rhs: rhsItem, with: matcher) else { return false } 
                    return true 
                case (.getPrice__for_item(let lhsItem), .getPrice__for_item(let rhsItem)): 
                    guard Parameter.compare(lhs: lhsItem, rhs: rhsItem, with: matcher) else { return false } 
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case .getExampleItems: return 0
                case let .getItemDetails__item_item(p0): return p0.intValue
                case let .getPrice__for_item(p0): return p0.intValue
            }
        }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

        static func getExampleItems(willReturn: Observable<[Item]>) -> Given {
            return Given(method: .getExampleItems, returns: willReturn, throws: nil)
        }
        static func getItemDetails(item: Parameter<Item>, willReturn: Observable<ItemDetails>) -> Given {
            return Given(method: .getItemDetails__item_item(item), returns: willReturn, throws: nil)
        }
        static func getPrice(for item: Parameter<Item>, willReturn: Decimal) -> Given {
            return Given(method: .getPrice__for_item(item), returns: willReturn, throws: nil)
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func getExampleItems() -> Verify {
            return Verify(method: .getExampleItems)
        }
        static func getItemDetails(item: Parameter<Item>) -> Verify {
            return Verify(method: .getItemDetails__item_item(item))
        }
        static func getPrice(for item: Parameter<Item>) -> Verify {
            return Verify(method: .getPrice__for_item(item))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func getExampleItems(perform: () -> Void) -> Perform {
            return Perform(method: .getExampleItems, performs: perform)
        }
        static func getItemDetails(item: Parameter<Item>, perform: (Item) -> Void) -> Perform {
            return Perform(method: .getItemDetails__item_item(item), performs: perform)
        }
        static func getPrice(for item: Parameter<Item>, perform: (Item) -> Void) -> Perform {
            return Perform(method: .getPrice__for_item(item), performs: perform)
        }
    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> Any? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.returns != nil  }
        return matched?.returns
    }

    private func methodThrowValue(_ method: MethodType) -> Error? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.`throws` != nil  }
        return matched?.`throws`
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}
// MARK: - NonSwiftProtocol
class NonSwiftProtocolMock: NSObject, NonSwiftProtocol, Mock {
    fileprivate var invocations: [MethodType] = []
    var methodReturnValues: [Given] = []
    var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default


    func returnNoting() {
        addInvocation(.returnNoting)
		let perform = methodPerformValue(.returnNoting) as? () -> Void
		perform?()
    }

    func someMethod() {
        addInvocation(.someMethod)
		let perform = methodPerformValue(.someMethod) as? () -> Void
		perform?()
    }

    fileprivate enum MethodType {
        case returnNoting
        case someMethod

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.returnNoting, .returnNoting): 
                    return true 
                case (.someMethod, .someMethod): 
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case .returnNoting: return 0
                case .someMethod: return 0
            }
        }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

    }

    struct Verify {
        fileprivate var method: MethodType

        static func returnNoting() -> Verify {
            return Verify(method: .returnNoting)
        }
        static func someMethod() -> Verify {
            return Verify(method: .someMethod)
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func returnNoting(perform: () -> Void) -> Perform {
            return Perform(method: .returnNoting, performs: perform)
        }
        static func someMethod(perform: () -> Void) -> Perform {
            return Perform(method: .someMethod, performs: perform)
        }
    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> Any? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.returns != nil  }
        return matched?.returns
    }

    private func methodThrowValue(_ method: MethodType) -> Error? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.`throws` != nil  }
        return matched?.`throws`
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}
// MARK: - ProtocolWithOptionalClosures
class ProtocolWithOptionalClosuresMock: ProtocolWithOptionalClosures, Mock {
    fileprivate var invocations: [MethodType] = []
    var methodReturnValues: [Given] = []
    var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default

    var nonOptionalClosure: () -> Void { 
		get { return __nonOptionalClosure.orFail("ProtocolWithOptionalClosuresMock - value for nonOptionalClosure was not defined") }
		set { __nonOptionalClosure = newValue }
	}
	private var __nonOptionalClosure: (() -> Void)?
    var optionalClosure: (() -> Int)? { 
		get { return __optionalClosure.orFail("ProtocolWithOptionalClosuresMock - value for optionalClosure was not defined") }
		set { __optionalClosure = newValue }
	}
	private var __optionalClosure: (() -> Int)?
    var implicitelyUnwrappedClosure: (() -> Void)! { 
		get { return __implicitelyUnwrappedClosure.orFail("ProtocolWithOptionalClosuresMock - value for implicitelyUnwrappedClosure was not defined") }
		set { __implicitelyUnwrappedClosure = newValue }
	}
	private var __implicitelyUnwrappedClosure: (() -> Void)?


    fileprivate struct MethodType {
        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool { return true }
        func intValue() -> Int { return 0 }
    }
    
    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

    }

    struct Verify {
        fileprivate var method: MethodType

    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> Any? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.returns != nil  }
        return matched?.returns
    }

    private func methodThrowValue(_ method: MethodType) -> Error? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.`throws` != nil  }
        return matched?.`throws`
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}
// MARK: - ProtocolWithThrowingMethods
class ProtocolWithThrowingMethodsMock: ProtocolWithThrowingMethods, Mock {
    fileprivate var invocations: [MethodType] = []
    var methodReturnValues: [Given] = []
    var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default


    func methodThatThrows() throws {
        addInvocation(.methodThatThrows)
		let perform = methodPerformValue(.methodThatThrows) as? () -> Void
		perform?()
		if let error = methodThrowValue(.methodThatThrows) { throw error }
    }

    func methodThatReturnsAndThrows(param: String) throws -> Int {
        addInvocation(.methodThatReturnsAndThrows__param_param(.value(param)))
		let perform = methodPerformValue(.methodThatReturnsAndThrows__param_param(.value(param))) as? (String) -> Void
		perform?(param)
		if let error = methodThrowValue(.methodThatReturnsAndThrows__param_param(.value(param))) { throw error }
		let value = methodReturnValue(.methodThatReturnsAndThrows__param_param(.value(param))) as? Int
		return value.orFail("stub return value not specified for methodThatReturnsAndThrows(param: String). Use given")
    }

    func methodThatRethrows(param: (String) throws -> Int) rethrows -> Int {
        addInvocation(.methodThatRethrows__param_param(Parameter<(String) throws -> Int>.any))
		let perform = methodPerformValue(.methodThatRethrows__param_param(Parameter<(String) throws -> Int>.any)) as? ((String) throws -> Int) -> Void
		perform?(param)
		let value = methodReturnValue(.methodThatRethrows__param_param(Parameter<(String) throws -> Int>.any)) as? Int
		return value.orFail("stub return value not specified for methodThatRethrows(param: (String) throws -> Int). Use given")
    }

    fileprivate enum MethodType {
        case methodThatThrows
        case methodThatReturnsAndThrows__param_param(Parameter<String>)
        case methodThatRethrows__param_param(Parameter<(String) throws -> Int>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.methodThatThrows, .methodThatThrows): 
                    return true 
                case (.methodThatReturnsAndThrows__param_param(let lhsParam), .methodThatReturnsAndThrows__param_param(let rhsParam)): 
                    guard Parameter.compare(lhs: lhsParam, rhs: rhsParam, with: matcher) else { return false } 
                    return true 
                case (.methodThatRethrows__param_param(let lhsParam), .methodThatRethrows__param_param(let rhsParam)): 
                    guard Parameter.compare(lhs: lhsParam, rhs: rhsParam, with: matcher) else { return false } 
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case .methodThatThrows: return 0
                case let .methodThatReturnsAndThrows__param_param(p0): return p0.intValue
                case let .methodThatRethrows__param_param(p0): return p0.intValue
            }
        }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

        static func methodThatReturnsAndThrows(param: Parameter<String>, willReturn: Int) -> Given {
            return Given(method: .methodThatReturnsAndThrows__param_param(param), returns: willReturn, throws: nil)
        }
        static func methodThatRethrows(param: Parameter<(String) throws -> Int>, willReturn: Int) -> Given {
            return Given(method: .methodThatRethrows__param_param(param), returns: willReturn, throws: nil)
        }
        static func methodThatThrows(willThrow: Error) -> Given {
            return Given(method: .methodThatThrows, returns: nil, throws: willThrow)
        }
        static func methodThatReturnsAndThrows(param: Parameter<String>, willThrow: Error) -> Given {
            return Given(method: .methodThatReturnsAndThrows__param_param(param), returns: nil, throws: willThrow)
        }
        static func methodThatRethrows(param: Parameter<(String) throws -> Int>, willThrow: Error) -> Given {
            return Given(method: .methodThatRethrows__param_param(param), returns: nil, throws: willThrow)
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func methodThatThrows() -> Verify {
            return Verify(method: .methodThatThrows)
        }
        static func methodThatReturnsAndThrows(param: Parameter<String>) -> Verify {
            return Verify(method: .methodThatReturnsAndThrows__param_param(param))
        }
        static func methodThatRethrows(param: Parameter<(String) throws -> Int>) -> Verify {
            return Verify(method: .methodThatRethrows__param_param(param))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func methodThatThrows(perform: () -> Void) -> Perform {
            return Perform(method: .methodThatThrows, performs: perform)
        }
        static func methodThatReturnsAndThrows(param: Parameter<String>, perform: (String) -> Void) -> Perform {
            return Perform(method: .methodThatReturnsAndThrows__param_param(param), performs: perform)
        }
        static func methodThatRethrows(param: Parameter<(String) throws -> Int>, perform: ((String) throws -> Int) -> Void) -> Perform {
            return Perform(method: .methodThatRethrows__param_param(param), performs: perform)
        }
    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> Any? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.returns != nil  }
        return matched?.returns
    }

    private func methodThrowValue(_ method: MethodType) -> Error? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.`throws` != nil  }
        return matched?.`throws`
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}
// MARK: - SampleServiceType
class SampleServiceTypeMock: SampleServiceType, Mock {
    fileprivate var invocations: [MethodType] = []
    var methodReturnValues: [Given] = []
    var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default


    func serviceName() -> String {
        addInvocation(.serviceName)
		let perform = methodPerformValue(.serviceName) as? () -> Void
		perform?()
		let value = methodReturnValue(.serviceName) as? String
		return value.orFail("stub return value not specified for serviceName(). Use given")
    }

    func getPoint(from point: Point) -> Point {
        addInvocation(.getPoint__from_point(.value(point)))
		let perform = methodPerformValue(.getPoint__from_point(.value(point))) as? (Point) -> Void
		perform?(point)
		let value = methodReturnValue(.getPoint__from_point(.value(point))) as? Point
		return value.orFail("stub return value not specified for getPoint(from point: Point). Use given")
    }

    func getPoint(from tuple: (Float,Float)) -> Point {
        addInvocation(.getPoint__from_tuple(.value(tuple)))
		let perform = methodPerformValue(.getPoint__from_tuple(.value(tuple))) as? ((Float,Float)) -> Void
		perform?(tuple)
		let value = methodReturnValue(.getPoint__from_tuple(.value(tuple))) as? Point
		return value.orFail("stub return value not specified for getPoint(from tuple: (Float,Float)). Use given")
    }

    func similarMethodThatDiffersOnType(_ value: Float) -> Bool {
        addInvocation(.similarMethodThatDiffersOnType__value_1(.value(value)))
		let perform = methodPerformValue(.similarMethodThatDiffersOnType__value_1(.value(value))) as? (Float) -> Void
		perform?(value)
		let value = methodReturnValue(.similarMethodThatDiffersOnType__value_1(.value(value))) as? Bool
		return value.orFail("stub return value not specified for similarMethodThatDiffersOnType(_ value: Float). Use given")
    }

    func similarMethodThatDiffersOnType(_ value: Point) -> Bool {
        addInvocation(.similarMethodThatDiffersOnType__value_2(.value(value)))
		let perform = methodPerformValue(.similarMethodThatDiffersOnType__value_2(.value(value))) as? (Point) -> Void
		perform?(value)
		let value = methodReturnValue(.similarMethodThatDiffersOnType__value_2(.value(value))) as? Bool
		return value.orFail("stub return value not specified for similarMethodThatDiffersOnType(_ value: Point). Use given")
    }

    func methodWithTypedef(_ scalar: Scalar) {
        addInvocation(.methodWithTypedef__scalar(.value(scalar)))
		let perform = methodPerformValue(.methodWithTypedef__scalar(.value(scalar))) as? (Scalar) -> Void
		perform?(scalar)
    }

    func methodWithClosures(success function: LinearFunction) -> ClosureFabric {
        addInvocation(.methodWithClosures__success_function_1(Parameter<LinearFunction>.any))
		let perform = methodPerformValue(.methodWithClosures__success_function_1(Parameter<LinearFunction>.any)) as? (LinearFunction) -> Void
		perform?(function)
		let value = methodReturnValue(.methodWithClosures__success_function_1(Parameter<LinearFunction>.any)) as? ClosureFabric
		return value.orFail("stub return value not specified for methodWithClosures(success function: LinearFunction). Use given")
    }

    func methodWithClosures(success function: ((Scalar,Scalar) -> Scalar)?) -> ((Int) -> Void) {
        addInvocation(.methodWithClosures__success_function_2(.value(function)))
		let perform = methodPerformValue(.methodWithClosures__success_function_2(.value(function))) as? (((Scalar,Scalar) -> Scalar)?) -> Void
		perform?(function)
		let value = methodReturnValue(.methodWithClosures__success_function_2(.value(function))) as? ((Int) -> Void)
		return value.orFail("stub return value not specified for methodWithClosures(success function: ((Scalar,Scalar) -> Scalar)?). Use given")
    }

    fileprivate enum MethodType {
        case serviceName
        case getPoint__from_point(Parameter<Point>)
        case getPoint__from_tuple(Parameter<(Float,Float)>)
        case similarMethodThatDiffersOnType__value_1(Parameter<Float>)
        case similarMethodThatDiffersOnType__value_2(Parameter<Point>)
        case methodWithTypedef__scalar(Parameter<Scalar>)
        case methodWithClosures__success_function_1(Parameter<LinearFunction>)
        case methodWithClosures__success_function_2(Parameter<((Scalar,Scalar) -> Scalar)?>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.serviceName, .serviceName): 
                    return true 
                case (.getPoint__from_point(let lhsPoint), .getPoint__from_point(let rhsPoint)): 
                    guard Parameter.compare(lhs: lhsPoint, rhs: rhsPoint, with: matcher) else { return false } 
                    return true 
                case (.getPoint__from_tuple(let lhsTuple), .getPoint__from_tuple(let rhsTuple)): 
                    guard Parameter.compare(lhs: lhsTuple, rhs: rhsTuple, with: matcher) else { return false } 
                    return true 
                case (.similarMethodThatDiffersOnType__value_1(let lhsValue), .similarMethodThatDiffersOnType__value_1(let rhsValue)): 
                    guard Parameter.compare(lhs: lhsValue, rhs: rhsValue, with: matcher) else { return false } 
                    return true 
                case (.similarMethodThatDiffersOnType__value_2(let lhsValue), .similarMethodThatDiffersOnType__value_2(let rhsValue)): 
                    guard Parameter.compare(lhs: lhsValue, rhs: rhsValue, with: matcher) else { return false } 
                    return true 
                case (.methodWithTypedef__scalar(let lhsScalar), .methodWithTypedef__scalar(let rhsScalar)): 
                    guard Parameter.compare(lhs: lhsScalar, rhs: rhsScalar, with: matcher) else { return false } 
                    return true 
                case (.methodWithClosures__success_function_1(let lhsFunction), .methodWithClosures__success_function_1(let rhsFunction)): 
                    guard Parameter.compare(lhs: lhsFunction, rhs: rhsFunction, with: matcher) else { return false } 
                    return true 
                case (.methodWithClosures__success_function_2(let lhsFunction), .methodWithClosures__success_function_2(let rhsFunction)): 
                    guard Parameter.compare(lhs: lhsFunction, rhs: rhsFunction, with: matcher) else { return false } 
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case .serviceName: return 0
                case let .getPoint__from_point(p0): return p0.intValue
                case let .getPoint__from_tuple(p0): return p0.intValue
                case let .similarMethodThatDiffersOnType__value_1(p0): return p0.intValue
                case let .similarMethodThatDiffersOnType__value_2(p0): return p0.intValue
                case let .methodWithTypedef__scalar(p0): return p0.intValue
                case let .methodWithClosures__success_function_1(p0): return p0.intValue
                case let .methodWithClosures__success_function_2(p0): return p0.intValue
            }
        }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

        static func serviceName(willReturn: String) -> Given {
            return Given(method: .serviceName, returns: willReturn, throws: nil)
        }
        static func getPoint(from point: Parameter<Point>, willReturn: Point) -> Given {
            return Given(method: .getPoint__from_point(point), returns: willReturn, throws: nil)
        }
        static func getPoint(from tuple: Parameter<(Float,Float)>, willReturn: Point) -> Given {
            return Given(method: .getPoint__from_tuple(tuple), returns: willReturn, throws: nil)
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Float>, willReturn: Bool) -> Given {
            return Given(method: .similarMethodThatDiffersOnType__value_1(value), returns: willReturn, throws: nil)
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Point>, willReturn: Bool) -> Given {
            return Given(method: .similarMethodThatDiffersOnType__value_2(value), returns: willReturn, throws: nil)
        }
        static func methodWithClosures(success function: Parameter<LinearFunction>, willReturn: ClosureFabric) -> Given {
            return Given(method: .methodWithClosures__success_function_1(function), returns: willReturn, throws: nil)
        }
        static func methodWithClosures(success function: Parameter<((Scalar,Scalar) -> Scalar)?>, willReturn: ((Int) -> Void)) -> Given {
            return Given(method: .methodWithClosures__success_function_2(function), returns: willReturn, throws: nil)
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func serviceName() -> Verify {
            return Verify(method: .serviceName)
        }
        static func getPoint(from point: Parameter<Point>) -> Verify {
            return Verify(method: .getPoint__from_point(point))
        }
        static func getPoint(from tuple: Parameter<(Float,Float)>) -> Verify {
            return Verify(method: .getPoint__from_tuple(tuple))
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Float>) -> Verify {
            return Verify(method: .similarMethodThatDiffersOnType__value_1(value))
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Point>) -> Verify {
            return Verify(method: .similarMethodThatDiffersOnType__value_2(value))
        }
        static func methodWithTypedef(scalar: Parameter<Scalar>) -> Verify {
            return Verify(method: .methodWithTypedef__scalar(scalar))
        }
        static func methodWithClosures(success function: Parameter<LinearFunction>) -> Verify {
            return Verify(method: .methodWithClosures__success_function_1(function))
        }
        static func methodWithClosures(success function: Parameter<((Scalar,Scalar) -> Scalar)?>) -> Verify {
            return Verify(method: .methodWithClosures__success_function_2(function))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func serviceName(perform: () -> Void) -> Perform {
            return Perform(method: .serviceName, performs: perform)
        }
        static func getPoint(from point: Parameter<Point>, perform: (Point) -> Void) -> Perform {
            return Perform(method: .getPoint__from_point(point), performs: perform)
        }
        static func getPoint(from tuple: Parameter<(Float,Float)>, perform: ((Float,Float)) -> Void) -> Perform {
            return Perform(method: .getPoint__from_tuple(tuple), performs: perform)
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Float>, perform: (Float) -> Void) -> Perform {
            return Perform(method: .similarMethodThatDiffersOnType__value_1(value), performs: perform)
        }
        static func similarMethodThatDiffersOnType(value: Parameter<Point>, perform: (Point) -> Void) -> Perform {
            return Perform(method: .similarMethodThatDiffersOnType__value_2(value), performs: perform)
        }
        static func methodWithTypedef(scalar: Parameter<Scalar>, perform: (Scalar) -> Void) -> Perform {
            return Perform(method: .methodWithTypedef__scalar(scalar), performs: perform)
        }
        static func methodWithClosures(success function: Parameter<LinearFunction>, perform: (LinearFunction) -> Void) -> Perform {
            return Perform(method: .methodWithClosures__success_function_1(function), performs: perform)
        }
        static func methodWithClosures(success function: Parameter<((Scalar,Scalar) -> Scalar)?>, perform: (((Scalar,Scalar) -> Scalar)?) -> Void) -> Perform {
            return Perform(method: .methodWithClosures__success_function_2(function), performs: perform)
        }
    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> Any? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.returns != nil  }
        return matched?.returns
    }

    private func methodThrowValue(_ method: MethodType) -> Error? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.`throws` != nil  }
        return matched?.`throws`
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}
// MARK: - SimpleServiceType
class SimpleServiceTypeMock: SimpleServiceType, Mock {
    fileprivate var invocations: [MethodType] = []
    var methodReturnValues: [Given] = []
    var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default

    var youCouldOnlyGetThis: String { 
		get { return __youCouldOnlyGetThis.orFail("SimpleServiceTypeMock - value for youCouldOnlyGetThis was not defined") }
		set { __youCouldOnlyGetThis = newValue }
	}
	private var __youCouldOnlyGetThis: (String)?

    func serviceName() -> String {
        addInvocation(.serviceName)
		let perform = methodPerformValue(.serviceName) as? () -> Void
		perform?()
		let value = methodReturnValue(.serviceName) as? String
		return value.orFail("stub return value not specified for serviceName(). Use given")
    }

    fileprivate enum MethodType {
        case serviceName

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.serviceName, .serviceName): 
                    return true 
            }
        }

        func intValue() -> Int {
            switch self {
                case .serviceName: return 0
            }
        }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

        static func serviceName(willReturn: String) -> Given {
            return Given(method: .serviceName, returns: willReturn, throws: nil)
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func serviceName() -> Verify {
            return Verify(method: .serviceName)
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func serviceName(perform: () -> Void) -> Perform {
            return Perform(method: .serviceName, performs: perform)
        }
    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> Any? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.returns != nil  }
        return matched?.returns
    }

    private func methodThrowValue(_ method: MethodType) -> Error? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.`throws` != nil  }
        return matched?.`throws`
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}
// MARK: - UserNetworkType
class UserNetworkTypeMock: UserNetworkType, Mock {
    fileprivate var invocations: [MethodType] = []
    var methodReturnValues: [Given] = []
    var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default


    required init(config: NetworkConfig) {
        
    }

    required init(baseUrl: String) {
        
    }

    func getUser(for id: String, completion: (User?) -> Void) {
        addInvocation(.getUser__for_idcompletion_completion(.value(id), Parameter<(User?) -> Void>.any))
		let perform = methodPerformValue(.getUser__for_idcompletion_completion(.value(id), Parameter<(User?) -> Void>.any)) as? (String, (User?) -> Void) -> Void
		perform?(id, completion)
    }

    func getUserEscaping(for id: String, completion: @escaping (User?,Error?) -> Void) {
        addInvocation(.getUserEscaping__for_idcompletion_completion(.value(id), .value(completion)))
		let perform = methodPerformValue(.getUserEscaping__for_idcompletion_completion(.value(id), .value(completion))) as? (String, @escaping (User?,Error?) -> Void) -> Void
		perform?(id, completion)
    }

    func doSomething(prop: @autoclosure () -> String) {
        addInvocation(.doSomething__prop_prop(Parameter< () -> String>.any))
		let perform = methodPerformValue(.doSomething__prop_prop(Parameter< () -> String>.any)) as? (@autoclosure () -> String) -> Void
		perform?(prop)
    }

    func testDefaultValues(value: String) {
        addInvocation(.testDefaultValues__value_value(.value(value)))
		let perform = methodPerformValue(.testDefaultValues__value_value(.value(value))) as? (String) -> Void
		perform?(value)
    }

    fileprivate enum MethodType {
        case getUser__for_idcompletion_completion(Parameter<String>, Parameter<(User?) -> Void>)
        case getUserEscaping__for_idcompletion_completion(Parameter<String>, Parameter< (User?,Error?) -> Void>)
        case doSomething__prop_prop(Parameter< () -> String>)
        case testDefaultValues__value_value(Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.getUser__for_idcompletion_completion(let lhsId, let lhsCompletion), .getUser__for_idcompletion_completion(let rhsId, let rhsCompletion)): 
                    guard Parameter.compare(lhs: lhsId, rhs: rhsId, with: matcher) else { return false } 
                    guard Parameter.compare(lhs: lhsCompletion, rhs: rhsCompletion, with: matcher) else { return false } 
                    return true 
                case (.getUserEscaping__for_idcompletion_completion(let lhsId, let lhsCompletion), .getUserEscaping__for_idcompletion_completion(let rhsId, let rhsCompletion)): 
                    guard Parameter.compare(lhs: lhsId, rhs: rhsId, with: matcher) else { return false } 
                    guard Parameter.compare(lhs: lhsCompletion, rhs: rhsCompletion, with: matcher) else { return false } 
                    return true 
                case (.doSomething__prop_prop(let lhsProp), .doSomething__prop_prop(let rhsProp)): 
                    guard Parameter.compare(lhs: lhsProp, rhs: rhsProp, with: matcher) else { return false } 
                    return true 
                case (.testDefaultValues__value_value(let lhsValue), .testDefaultValues__value_value(let rhsValue)): 
                    guard Parameter.compare(lhs: lhsValue, rhs: rhsValue, with: matcher) else { return false } 
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case let .getUser__for_idcompletion_completion(p0, p1): return p0.intValue + p1.intValue
                case let .getUserEscaping__for_idcompletion_completion(p0, p1): return p0.intValue + p1.intValue
                case let .doSomething__prop_prop(p0): return p0.intValue
                case let .testDefaultValues__value_value(p0): return p0.intValue
            }
        }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

    }

    struct Verify {
        fileprivate var method: MethodType

        static func getUser(for id: Parameter<String>, completion: Parameter<(User?) -> Void>) -> Verify {
            return Verify(method: .getUser__for_idcompletion_completion(id, completion))
        }
        static func getUserEscaping(for id: Parameter<String>, completion: Parameter< (User?,Error?) -> Void>) -> Verify {
            return Verify(method: .getUserEscaping__for_idcompletion_completion(id, completion))
        }
        static func doSomething(prop: Parameter< () -> String>) -> Verify {
            return Verify(method: .doSomething__prop_prop(prop))
        }
        static func testDefaultValues(value: Parameter<String>) -> Verify {
            return Verify(method: .testDefaultValues__value_value(value))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func getUser(for id: Parameter<String>, completion: Parameter<(User?) -> Void>, perform: (String, (User?) -> Void) -> Void) -> Perform {
            return Perform(method: .getUser__for_idcompletion_completion(id, completion), performs: perform)
        }
        static func getUserEscaping(for id: Parameter<String>, completion: Parameter< (User?,Error?) -> Void>, perform: (String, @escaping (User?,Error?) -> Void) -> Void) -> Perform {
            return Perform(method: .getUserEscaping__for_idcompletion_completion(id, completion), performs: perform)
        }
        static func doSomething(prop: Parameter< () -> String>, perform: (@autoclosure () -> String) -> Void) -> Perform {
            return Perform(method: .doSomething__prop_prop(prop), performs: perform)
        }
        static func testDefaultValues(value: Parameter<String>, perform: (String) -> Void) -> Perform {
            return Perform(method: .testDefaultValues__value_value(value), performs: perform)
        }
    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> Any? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.returns != nil  }
        return matched?.returns
    }

    private func methodThrowValue(_ method: MethodType) -> Error? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.`throws` != nil  }
        return matched?.`throws`
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}
// MARK: - UserStorageType
class UserStorageTypeMock: UserStorageType, Mock {
    fileprivate var invocations: [MethodType] = []
    var methodReturnValues: [Given] = []
    var methodPerformValues: [Perform] = []
    var matcher: Matcher = Matcher.default


    func surname(for name: String) -> String {
        addInvocation(.surname__for_name(.value(name)))
		let perform = methodPerformValue(.surname__for_name(.value(name))) as? (String) -> Void
		perform?(name)
		let value = methodReturnValue(.surname__for_name(.value(name))) as? String
		return value.orFail("stub return value not specified for surname(for name: String). Use given")
    }

    func storeUser(name: String, surname: String) {
        addInvocation(.storeUser__name_namesurname_surname(.value(name), .value(surname)))
		let perform = methodPerformValue(.storeUser__name_namesurname_surname(.value(name), .value(surname))) as? (String, String) -> Void
		perform?(name, surname)
    }

    fileprivate enum MethodType {
        case surname__for_name(Parameter<String>)
        case storeUser__name_namesurname_surname(Parameter<String>, Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
                case (.surname__for_name(let lhsName), .surname__for_name(let rhsName)): 
                    guard Parameter.compare(lhs: lhsName, rhs: rhsName, with: matcher) else { return false } 
                    return true 
                case (.storeUser__name_namesurname_surname(let lhsName, let lhsSurname), .storeUser__name_namesurname_surname(let rhsName, let rhsSurname)): 
                    guard Parameter.compare(lhs: lhsName, rhs: rhsName, with: matcher) else { return false } 
                    guard Parameter.compare(lhs: lhsSurname, rhs: rhsSurname, with: matcher) else { return false } 
                    return true 
                default: return false
            }
        }

        func intValue() -> Int {
            switch self {
                case let .surname__for_name(p0): return p0.intValue
                case let .storeUser__name_namesurname_surname(p0, p1): return p0.intValue + p1.intValue
            }
        }
    }

    struct Given {
        fileprivate var method: MethodType
        var returns: Any?
        var `throws`: Error?

        private init(method: MethodType, returns: Any?, throws: Error?) {
            self.method = method
            self.returns = returns
            self.`throws` = `throws`
        }

        static func surname(for name: Parameter<String>, willReturn: String) -> Given {
            return Given(method: .surname__for_name(name), returns: willReturn, throws: nil)
        }
    }

    struct Verify {
        fileprivate var method: MethodType

        static func surname(for name: Parameter<String>) -> Verify {
            return Verify(method: .surname__for_name(name))
        }
        static func storeUser(name: Parameter<String>, surname: Parameter<String>) -> Verify {
            return Verify(method: .storeUser__name_namesurname_surname(name, surname))
        }
    }

    struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        static func surname(for name: Parameter<String>, perform: (String) -> Void) -> Perform {
            return Perform(method: .surname__for_name(name), performs: perform)
        }
        static func storeUser(name: Parameter<String>, surname: Parameter<String>, perform: (String, String) -> Void) -> Perform {
            return Perform(method: .storeUser__name_namesurname_surname(name, surname), performs: perform)
        }
    }

    public func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
        methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
        let method = method.method
        let invocations = matchingCalls(method)
        XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }

    private func methodReturnValue(_ method: MethodType) -> Any? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.returns != nil  }
        return matched?.returns
    }

    private func methodThrowValue(_ method: MethodType) -> Error? {
        let matched = methodReturnValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) && $0.`throws` != nil  }
        return matched?.`throws`
    }

    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }

    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
}

