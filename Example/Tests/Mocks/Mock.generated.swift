// Generated using Sourcery 0.9.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


#if Mocky
import Mocky
import XCTest

import RxSwift
@testable import Mocky_Example

#else
import Sourcery
import SourceryRuntime
#endif



// MARK: - ComplicatedServiceType
class ComplicatedServiceTypeMock: ComplicatedServiceType, Mock {

      var invocations: [MethodType] = []
      var methodReturnValues: [MethodProxy] = []
      var matcher: Matcher = Matcher.default
            

      var youCouldOnlyGetThis: String { 
		get { return __youCouldOnlyGetThis }
		set { __youCouldOnlyGetThis = newValue }
	}
	private var __youCouldOnlyGetThis: String!                  

      func serviceName() -> String {
          addInvocation(.serviceName)
          return methodReturnValue(.serviceName) as! String 
      }
      
      func aNewWayToSayHooray() {
          addInvocation(.aNewWayToSayHooray)
          
      }
      
      func getPoint(from point: Point) -> Point {
          addInvocation(.getPoint__from_point(.value(point)))
          return methodReturnValue(.getPoint__from_point(.value(point))) as! Point 
      }
      
      func getPoint(from tuple: (Float,Float)) -> Point {
          addInvocation(.getPoint__from_tuple(.value(tuple)))
          return methodReturnValue(.getPoint__from_tuple(.value(tuple))) as! Point 
      }
      
      func similarMethodThatDiffersOnType(_ value: Float) -> Bool {
          addInvocation(.similarMethodThatDiffersOnType__value_1(.value(value)))
          return methodReturnValue(.similarMethodThatDiffersOnType__value_1(.value(value))) as! Bool 
      }
      
      func similarMethodThatDiffersOnType(_ value: Point) -> Bool {
          addInvocation(.similarMethodThatDiffersOnType__value_2(.value(value)))
          return methodReturnValue(.similarMethodThatDiffersOnType__value_2(.value(value))) as! Bool 
      }
      
      func methodWithTypedef(_ scalar: Scalar) {
          addInvocation(.methodWithTypedef__scalar(.value(scalar)))
          
      }
      
      func methodWithClosures(success function: LinearFunction) -> ClosureFabric {
          addInvocation(.methodWithClosures__success_function_1(.value(function)))
          return methodReturnValue(.methodWithClosures__success_function_1(.value(function))) as! ClosureFabric 
      }
      
      func methodWithClosures(success function: ((Scalar,Scalar) -> Scalar)?) -> ((Int) -> Void) {
          addInvocation(.methodWithClosures__success_function_2(.value(function)))
          return methodReturnValue(.methodWithClosures__success_function_2(.value(function))) as! ((Int) -> Void) 
      }
      
      enum MethodType {

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

      struct MethodProxy {
          var method: MethodType
          var returns: Any?

          static func serviceName(willReturn: String) -> MethodProxy {
              return MethodProxy(method: .serviceName, returns: willReturn)
          }
  
          static func aNewWayToSayHooray(willReturn: Void) -> MethodProxy {
              return MethodProxy(method: .aNewWayToSayHooray, returns: willReturn)
          }
  
          static func getPoint(from point: Parameter<Point>, willReturn: Point) -> MethodProxy {
              return MethodProxy(method: .getPoint__from_point(point), returns: willReturn)
          }
  
          static func getPoint(from tuple: Parameter<(Float,Float)>, willReturn: Point) -> MethodProxy {
              return MethodProxy(method: .getPoint__from_tuple(tuple), returns: willReturn)
          }
  
          static func similarMethodThatDiffersOnType(value: Parameter<Float>, willReturn: Bool) -> MethodProxy {
              return MethodProxy(method: .similarMethodThatDiffersOnType__value_1(value), returns: willReturn)
          }
  
          static func similarMethodThatDiffersOnType(value: Parameter<Point>, willReturn: Bool) -> MethodProxy {
              return MethodProxy(method: .similarMethodThatDiffersOnType__value_2(value), returns: willReturn)
          }
  
          static func methodWithTypedef(scalar: Parameter<Scalar>, willReturn: Void) -> MethodProxy {
              return MethodProxy(method: .methodWithTypedef__scalar(scalar), returns: willReturn)
          }
  
          static func methodWithClosures(success function: Parameter<LinearFunction>, willReturn: ClosureFabric) -> MethodProxy {
              return MethodProxy(method: .methodWithClosures__success_function_1(function), returns: willReturn)
          }
  
          static func methodWithClosures(success function: Parameter<((Scalar,Scalar) -> Scalar)?>, willReturn: ((Int) -> Void)) -> MethodProxy {
              return MethodProxy(method: .methodWithClosures__success_function_2(function), returns: willReturn)
          }
        }

      struct VerificationProxy {
          var method: MethodType


          static func serviceName() -> VerificationProxy {
              return VerificationProxy(method: .serviceName)
          }
  
          static func aNewWayToSayHooray() -> VerificationProxy {
              return VerificationProxy(method: .aNewWayToSayHooray)
          }
  
          static func getPoint(from point: Parameter<Point>) -> VerificationProxy {
              return VerificationProxy(method: .getPoint__from_point(point))
          }
  
          static func getPoint(from tuple: Parameter<(Float,Float)>) -> VerificationProxy {
              return VerificationProxy(method: .getPoint__from_tuple(tuple))
          }
  
          static func similarMethodThatDiffersOnType(value: Parameter<Float>) -> VerificationProxy {
              return VerificationProxy(method: .similarMethodThatDiffersOnType__value_1(value))
          }
  
          static func similarMethodThatDiffersOnType(value: Parameter<Point>) -> VerificationProxy {
              return VerificationProxy(method: .similarMethodThatDiffersOnType__value_2(value))
          }
  
          static func methodWithTypedef(scalar: Parameter<Scalar>) -> VerificationProxy {
              return VerificationProxy(method: .methodWithTypedef__scalar(scalar))
          }
  
          static func methodWithClosures(success function: Parameter<LinearFunction>) -> VerificationProxy {
              return VerificationProxy(method: .methodWithClosures__success_function_1(function))
          }
  
          static func methodWithClosures(success function: Parameter<((Scalar,Scalar) -> Scalar)?>) -> VerificationProxy {
              return VerificationProxy(method: .methodWithClosures__success_function_2(function))
          }
        }

      public func methodReturnValue(_ method: MethodType) -> Any? {
          let matched = methodReturnValues.reversed().first(where: { proxy -> Bool in
              return MethodType.compareParameters(lhs: proxy.method, rhs: method, matcher: matcher)
          })

          return matched?.returns
      }

      public func verify(_ method: VerificationProxy, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
          let method = method.method
          let invocations = matchingCalls(method)
          XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
      }

      public func addInvocation(_ call: MethodType) {
          invocations.append(call)
      }

      public func matchingCalls(_ method: MethodType) -> [MethodType] {
          let matchingInvocations = invocations.filter({ (call) -> Bool in
              return MethodType.compareParameters(lhs: call, rhs: method, matcher: matcher)
          })
          return matchingInvocations
      }

      public func matchingCalls(_ method: VerificationProxy) -> [MethodType] {
          return matchingCalls(method.method)
      }

      public func given(_ method: MethodProxy) {
          methodReturnValues.append(method)
          methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
      }
}

// MARK: - ItemsClient
class ItemsClientMock: ItemsClient, Mock {

      var invocations: [MethodType] = []
      var methodReturnValues: [MethodProxy] = []
      var matcher: Matcher = Matcher.default
            
            

      func getExampleItems() -> Observable<[Item]> {
          addInvocation(.getExampleItems)
          return methodReturnValue(.getExampleItems) as! Observable<[Item]> 
      }
      
      func getItemDetails(item: Item) -> Observable<ItemDetails> {
          addInvocation(.getItemDetails__item_item(.value(item)))
          return methodReturnValue(.getItemDetails__item_item(.value(item))) as! Observable<ItemDetails> 
      }
      
      func update(item: Item, withLimit limit: Decimal, expirationDate date: Date?) -> Single<Void> {
          addInvocation(.update__item_itemwithLimit_limitexpirationDate_date(.value(item), .value(limit), .value(date)))
          return methodReturnValue(.update__item_itemwithLimit_limitexpirationDate_date(.value(item), .value(limit), .value(date))) as! Single<Void> 
      }
      
      enum MethodType {

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

      struct MethodProxy {
          var method: MethodType
          var returns: Any?

          static func getExampleItems(willReturn: Observable<[Item]>) -> MethodProxy {
              return MethodProxy(method: .getExampleItems, returns: willReturn)
          }
  
          static func getItemDetails(item item: Parameter<Item>, willReturn: Observable<ItemDetails>) -> MethodProxy {
              return MethodProxy(method: .getItemDetails__item_item(item), returns: willReturn)
          }
  
          static func update(item item: Parameter<Item>, withLimit limit: Parameter<Decimal>, expirationDate date: Parameter<Date?>, willReturn: Single<Void>) -> MethodProxy {
              return MethodProxy(method: .update__item_itemwithLimit_limitexpirationDate_date(item, limit, date), returns: willReturn)
          }
        }

      struct VerificationProxy {
          var method: MethodType


          static func getExampleItems() -> VerificationProxy {
              return VerificationProxy(method: .getExampleItems)
          }
  
          static func getItemDetails(item item: Parameter<Item>) -> VerificationProxy {
              return VerificationProxy(method: .getItemDetails__item_item(item))
          }
  
          static func update(item item: Parameter<Item>, withLimit limit: Parameter<Decimal>, expirationDate date: Parameter<Date?>) -> VerificationProxy {
              return VerificationProxy(method: .update__item_itemwithLimit_limitexpirationDate_date(item, limit, date))
          }
        }

      public func methodReturnValue(_ method: MethodType) -> Any? {
          let matched = methodReturnValues.reversed().first(where: { proxy -> Bool in
              return MethodType.compareParameters(lhs: proxy.method, rhs: method, matcher: matcher)
          })

          return matched?.returns
      }

      public func verify(_ method: VerificationProxy, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
          let method = method.method
          let invocations = matchingCalls(method)
          XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
      }

      public func addInvocation(_ call: MethodType) {
          invocations.append(call)
      }

      public func matchingCalls(_ method: MethodType) -> [MethodType] {
          let matchingInvocations = invocations.filter({ (call) -> Bool in
              return MethodType.compareParameters(lhs: call, rhs: method, matcher: matcher)
          })
          return matchingInvocations
      }

      public func matchingCalls(_ method: VerificationProxy) -> [MethodType] {
          return matchingCalls(method.method)
      }

      public func given(_ method: MethodProxy) {
          methodReturnValues.append(method)
          methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
      }
}

// MARK: - ItemsModel
class ItemsModelMock: ItemsModel, Mock {

      var invocations: [MethodType] = []
      var methodReturnValues: [MethodProxy] = []
      var matcher: Matcher = Matcher.default
            

      static var defaultIdentifier: Int { 
		get { return ItemsModelMock.__defaultIdentifier }
		set { ItemsModelMock.__defaultIdentifier = newValue }
	}
	private static var __defaultIdentifier: Int!      
      static var optionalIdentifier: String? { 
		get { return ItemsModelMock.__optionalIdentifier }
		set { ItemsModelMock.__optionalIdentifier = newValue }
	}
	private static var __optionalIdentifier: String?      
      var context: Any? { 
		get { return __context }
		set { __context = newValue }
	}
	private var __context: Any?      
      var storage: Any! { 
		get { return __storage }
		set { __storage = newValue }
	}
	private var __storage: Any!      
      var some: Any { 
		get { return __some }
		set { __some = newValue }
	}
	private var __some: Any!      
      var storedProperty: Any { 
		get { return __storedProperty }
		set { __storedProperty = newValue }
	}
	private var __storedProperty: Any!                  

      func getExampleItems() -> Observable<[Item]> {
          addInvocation(.getExampleItems)
          return methodReturnValue(.getExampleItems) as! Observable<[Item]> 
      }
      
      func getItemDetails(item: Item) -> Observable<ItemDetails> {
          addInvocation(.getItemDetails__item_item(.value(item)))
          return methodReturnValue(.getItemDetails__item_item(.value(item))) as! Observable<ItemDetails> 
      }
      
      func getPrice(for item: Item) -> Decimal {
          addInvocation(.getPrice__for_item(.value(item)))
          return methodReturnValue(.getPrice__for_item(.value(item))) as! Decimal 
      }
      
      enum MethodType {

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

      struct MethodProxy {
          var method: MethodType
          var returns: Any?

          static func getExampleItems(willReturn: Observable<[Item]>) -> MethodProxy {
              return MethodProxy(method: .getExampleItems, returns: willReturn)
          }
  
          static func getItemDetails(item item: Parameter<Item>, willReturn: Observable<ItemDetails>) -> MethodProxy {
              return MethodProxy(method: .getItemDetails__item_item(item), returns: willReturn)
          }
  
          static func getPrice(for item: Parameter<Item>, willReturn: Decimal) -> MethodProxy {
              return MethodProxy(method: .getPrice__for_item(item), returns: willReturn)
          }
        }

      struct VerificationProxy {
          var method: MethodType


          static func getExampleItems() -> VerificationProxy {
              return VerificationProxy(method: .getExampleItems)
          }
  
          static func getItemDetails(item item: Parameter<Item>) -> VerificationProxy {
              return VerificationProxy(method: .getItemDetails__item_item(item))
          }
  
          static func getPrice(for item: Parameter<Item>) -> VerificationProxy {
              return VerificationProxy(method: .getPrice__for_item(item))
          }
        }

      public func methodReturnValue(_ method: MethodType) -> Any? {
          let matched = methodReturnValues.reversed().first(where: { proxy -> Bool in
              return MethodType.compareParameters(lhs: proxy.method, rhs: method, matcher: matcher)
          })

          return matched?.returns
      }

      public func verify(_ method: VerificationProxy, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
          let method = method.method
          let invocations = matchingCalls(method)
          XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
      }

      public func addInvocation(_ call: MethodType) {
          invocations.append(call)
      }

      public func matchingCalls(_ method: MethodType) -> [MethodType] {
          let matchingInvocations = invocations.filter({ (call) -> Bool in
              return MethodType.compareParameters(lhs: call, rhs: method, matcher: matcher)
          })
          return matchingInvocations
      }

      public func matchingCalls(_ method: VerificationProxy) -> [MethodType] {
          return matchingCalls(method.method)
      }

      public func given(_ method: MethodProxy) {
          methodReturnValues.append(method)
          methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
      }
}

// MARK: - SampleServiceType
class SampleServiceTypeMock: SampleServiceType, Mock {

      var invocations: [MethodType] = []
      var methodReturnValues: [MethodProxy] = []
      var matcher: Matcher = Matcher.default
            
            

      func serviceName() -> String {
          addInvocation(.serviceName)
          return methodReturnValue(.serviceName) as! String 
      }
      
      func getPoint(from point: Point) -> Point {
          addInvocation(.getPoint__from_point(.value(point)))
          return methodReturnValue(.getPoint__from_point(.value(point))) as! Point 
      }
      
      func getPoint(from tuple: (Float,Float)) -> Point {
          addInvocation(.getPoint__from_tuple(.value(tuple)))
          return methodReturnValue(.getPoint__from_tuple(.value(tuple))) as! Point 
      }
      
      func similarMethodThatDiffersOnType(_ value: Float) -> Bool {
          addInvocation(.similarMethodThatDiffersOnType__value_1(.value(value)))
          return methodReturnValue(.similarMethodThatDiffersOnType__value_1(.value(value))) as! Bool 
      }
      
      func similarMethodThatDiffersOnType(_ value: Point) -> Bool {
          addInvocation(.similarMethodThatDiffersOnType__value_2(.value(value)))
          return methodReturnValue(.similarMethodThatDiffersOnType__value_2(.value(value))) as! Bool 
      }
      
      func methodWithTypedef(_ scalar: Scalar) {
          addInvocation(.methodWithTypedef__scalar(.value(scalar)))
          
      }
      
      func methodWithClosures(success function: LinearFunction) -> ClosureFabric {
          addInvocation(.methodWithClosures__success_function_1(.value(function)))
          return methodReturnValue(.methodWithClosures__success_function_1(.value(function))) as! ClosureFabric 
      }
      
      func methodWithClosures(success function: ((Scalar,Scalar) -> Scalar)?) -> ((Int) -> Void) {
          addInvocation(.methodWithClosures__success_function_2(.value(function)))
          return methodReturnValue(.methodWithClosures__success_function_2(.value(function))) as! ((Int) -> Void) 
      }
      
      enum MethodType {

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

      struct MethodProxy {
          var method: MethodType
          var returns: Any?

          static func serviceName(willReturn: String) -> MethodProxy {
              return MethodProxy(method: .serviceName, returns: willReturn)
          }
  
          static func getPoint(from point: Parameter<Point>, willReturn: Point) -> MethodProxy {
              return MethodProxy(method: .getPoint__from_point(point), returns: willReturn)
          }
  
          static func getPoint(from tuple: Parameter<(Float,Float)>, willReturn: Point) -> MethodProxy {
              return MethodProxy(method: .getPoint__from_tuple(tuple), returns: willReturn)
          }
  
          static func similarMethodThatDiffersOnType(value: Parameter<Float>, willReturn: Bool) -> MethodProxy {
              return MethodProxy(method: .similarMethodThatDiffersOnType__value_1(value), returns: willReturn)
          }
  
          static func similarMethodThatDiffersOnType(value: Parameter<Point>, willReturn: Bool) -> MethodProxy {
              return MethodProxy(method: .similarMethodThatDiffersOnType__value_2(value), returns: willReturn)
          }
  
          static func methodWithTypedef(scalar: Parameter<Scalar>, willReturn: Void) -> MethodProxy {
              return MethodProxy(method: .methodWithTypedef__scalar(scalar), returns: willReturn)
          }
  
          static func methodWithClosures(success function: Parameter<LinearFunction>, willReturn: ClosureFabric) -> MethodProxy {
              return MethodProxy(method: .methodWithClosures__success_function_1(function), returns: willReturn)
          }
  
          static func methodWithClosures(success function: Parameter<((Scalar,Scalar) -> Scalar)?>, willReturn: ((Int) -> Void)) -> MethodProxy {
              return MethodProxy(method: .methodWithClosures__success_function_2(function), returns: willReturn)
          }
        }

      struct VerificationProxy {
          var method: MethodType


          static func serviceName() -> VerificationProxy {
              return VerificationProxy(method: .serviceName)
          }
  
          static func getPoint(from point: Parameter<Point>) -> VerificationProxy {
              return VerificationProxy(method: .getPoint__from_point(point))
          }
  
          static func getPoint(from tuple: Parameter<(Float,Float)>) -> VerificationProxy {
              return VerificationProxy(method: .getPoint__from_tuple(tuple))
          }
  
          static func similarMethodThatDiffersOnType(value: Parameter<Float>) -> VerificationProxy {
              return VerificationProxy(method: .similarMethodThatDiffersOnType__value_1(value))
          }
  
          static func similarMethodThatDiffersOnType(value: Parameter<Point>) -> VerificationProxy {
              return VerificationProxy(method: .similarMethodThatDiffersOnType__value_2(value))
          }
  
          static func methodWithTypedef(scalar: Parameter<Scalar>) -> VerificationProxy {
              return VerificationProxy(method: .methodWithTypedef__scalar(scalar))
          }
  
          static func methodWithClosures(success function: Parameter<LinearFunction>) -> VerificationProxy {
              return VerificationProxy(method: .methodWithClosures__success_function_1(function))
          }
  
          static func methodWithClosures(success function: Parameter<((Scalar,Scalar) -> Scalar)?>) -> VerificationProxy {
              return VerificationProxy(method: .methodWithClosures__success_function_2(function))
          }
        }

      public func methodReturnValue(_ method: MethodType) -> Any? {
          let matched = methodReturnValues.reversed().first(where: { proxy -> Bool in
              return MethodType.compareParameters(lhs: proxy.method, rhs: method, matcher: matcher)
          })

          return matched?.returns
      }

      public func verify(_ method: VerificationProxy, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
          let method = method.method
          let invocations = matchingCalls(method)
          XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
      }

      public func addInvocation(_ call: MethodType) {
          invocations.append(call)
      }

      public func matchingCalls(_ method: MethodType) -> [MethodType] {
          let matchingInvocations = invocations.filter({ (call) -> Bool in
              return MethodType.compareParameters(lhs: call, rhs: method, matcher: matcher)
          })
          return matchingInvocations
      }

      public func matchingCalls(_ method: VerificationProxy) -> [MethodType] {
          return matchingCalls(method.method)
      }

      public func given(_ method: MethodProxy) {
          methodReturnValues.append(method)
          methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
      }
}

// MARK: - SimpleServiceType
class SimpleServiceTypeMock: SimpleServiceType, Mock {

      var invocations: [MethodType] = []
      var methodReturnValues: [MethodProxy] = []
      var matcher: Matcher = Matcher.default
            

      var youCouldOnlyGetThis: String { 
		get { return __youCouldOnlyGetThis }
		set { __youCouldOnlyGetThis = newValue }
	}
	private var __youCouldOnlyGetThis: String!                  

      func serviceName() -> String {
          addInvocation(.serviceName)
          return methodReturnValue(.serviceName) as! String 
      }
      
      enum MethodType {

          case serviceName      

          static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
              switch (lhs, rhs) {
                  case (.serviceName, .serviceName): 
                      return true 
                  default: return false
              }
          }

          func intValue() -> Int {
              switch self {
                  case .serviceName: return 0
              }
          }
      }

      struct MethodProxy {
          var method: MethodType
          var returns: Any?

          static func serviceName(willReturn: String) -> MethodProxy {
              return MethodProxy(method: .serviceName, returns: willReturn)
          }
        }

      struct VerificationProxy {
          var method: MethodType


          static func serviceName() -> VerificationProxy {
              return VerificationProxy(method: .serviceName)
          }
        }

      public func methodReturnValue(_ method: MethodType) -> Any? {
          let matched = methodReturnValues.reversed().first(where: { proxy -> Bool in
              return MethodType.compareParameters(lhs: proxy.method, rhs: method, matcher: matcher)
          })

          return matched?.returns
      }

      public func verify(_ method: VerificationProxy, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
          let method = method.method
          let invocations = matchingCalls(method)
          XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
      }

      public func addInvocation(_ call: MethodType) {
          invocations.append(call)
      }

      public func matchingCalls(_ method: MethodType) -> [MethodType] {
          let matchingInvocations = invocations.filter({ (call) -> Bool in
              return MethodType.compareParameters(lhs: call, rhs: method, matcher: matcher)
          })
          return matchingInvocations
      }

      public func matchingCalls(_ method: VerificationProxy) -> [MethodType] {
          return matchingCalls(method.method)
      }

      public func given(_ method: MethodProxy) {
          methodReturnValues.append(method)
          methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
      }
}

// MARK: - UserStorageType
class UserStorageTypeMock: UserStorageType, Mock {

      var invocations: [MethodType] = []
      var methodReturnValues: [MethodProxy] = []
      var matcher: Matcher = Matcher.default
            
            

      func surname(for name: String) -> String {
          addInvocation(.surname__for_name(.value(name)))
          return methodReturnValue(.surname__for_name(.value(name))) as! String 
      }
      
      func storeUser(name: String, surname: String) {
          addInvocation(.storeUser__name_namesurname_surname(.value(name), .value(surname)))
          
      }
      
      enum MethodType {

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

      struct MethodProxy {
          var method: MethodType
          var returns: Any?

          static func surname(for name: Parameter<String>, willReturn: String) -> MethodProxy {
              return MethodProxy(method: .surname__for_name(name), returns: willReturn)
          }
  
          static func storeUser(name name: Parameter<String>, surname surname: Parameter<String>, willReturn: Void) -> MethodProxy {
              return MethodProxy(method: .storeUser__name_namesurname_surname(name, surname), returns: willReturn)
          }
        }

      struct VerificationProxy {
          var method: MethodType


          static func surname(for name: Parameter<String>) -> VerificationProxy {
              return VerificationProxy(method: .surname__for_name(name))
          }
  
          static func storeUser(name name: Parameter<String>, surname surname: Parameter<String>) -> VerificationProxy {
              return VerificationProxy(method: .storeUser__name_namesurname_surname(name, surname))
          }
        }

      public func methodReturnValue(_ method: MethodType) -> Any? {
          let matched = methodReturnValues.reversed().first(where: { proxy -> Bool in
              return MethodType.compareParameters(lhs: proxy.method, rhs: method, matcher: matcher)
          })

          return matched?.returns
      }

      public func verify(_ method: VerificationProxy, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
          let method = method.method
          let invocations = matchingCalls(method)
          XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
      }

      public func addInvocation(_ call: MethodType) {
          invocations.append(call)
      }

      public func matchingCalls(_ method: MethodType) -> [MethodType] {
          let matchingInvocations = invocations.filter({ (call) -> Bool in
              return MethodType.compareParameters(lhs: call, rhs: method, matcher: matcher)
          })
          return matchingInvocations
      }

      public func matchingCalls(_ method: VerificationProxy) -> [MethodType] {
          return matchingCalls(method.method)
      }

      public func given(_ method: MethodProxy) {
          methodReturnValues.append(method)
          methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
      }
}

