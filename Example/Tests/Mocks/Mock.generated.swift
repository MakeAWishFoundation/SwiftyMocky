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

//swiftlint:disable force_cast
//swiftlint:disable function_body_length
//swiftlint:disable line_length
//swiftlint:disable vertical_whitespace



// MARK: - ComplicatedServiceType
class ComplicatedServiceTypeMock: ComplicatedServiceType, Mock {

      fileprivate var invocations: [MethodType] = []
      var methodReturnValues: [MethodProxy] = []
      var methodPerformValues: [PerformProxy] = []
      var matcher: Matcher = Matcher.default
            

      var youCouldOnlyGetThis: String { 
		get { 
			guard let value = __youCouldOnlyGetThis else { 				print("[FATAL] ComplicatedServiceTypeMock - value for __youCouldOnlyGetThis is not set!")
				fatalError("[FATAL] ComplicatedServiceTypeMock - value for __youCouldOnlyGetThis is not set!")
			}
			return value 
		}
		set { __youCouldOnlyGetThis = newValue }
	}
	private var __youCouldOnlyGetThis: String!                  

      func serviceName() -> String {
          addInvocation(.serviceName)
          	let perform = methodPerformValue(.serviceName) as? () -> Void
			perform?()
          guard let value = methodReturnValue(.serviceName) as? String else {
			print("[FATAL] stub return value not specified for serviceName(). Use given.")
			fatalError("[FATAL] stub return value not specified for serviceName(). Use given.")
		}
		return value
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
          guard let value = methodReturnValue(.getPoint__from_point(.value(point))) as? Point else {
			print("[FATAL] stub return value not specified for getPoint(from point: Point). Use given.")
			fatalError("[FATAL] stub return value not specified for getPoint(from point: Point). Use given.")
		}
		return value
      }
      
      func getPoint(from tuple: (Float,Float)) -> Point {
          addInvocation(.getPoint__from_tuple(.value(tuple)))
          	let perform = methodPerformValue(.getPoint__from_tuple(.value(tuple))) as? ((Float,Float)) -> Void
			perform?(tuple)
          guard let value = methodReturnValue(.getPoint__from_tuple(.value(tuple))) as? Point else {
			print("[FATAL] stub return value not specified for getPoint(from tuple: (Float,Float)). Use given.")
			fatalError("[FATAL] stub return value not specified for getPoint(from tuple: (Float,Float)). Use given.")
		}
		return value
      }
      
      func similarMethodThatDiffersOnType(_ value: Float) -> Bool {
          addInvocation(.similarMethodThatDiffersOnType__value_1(.value(value)))
          	let perform = methodPerformValue(.similarMethodThatDiffersOnType__value_1(.value(value))) as? (Float) -> Void
			perform?(value)
          guard let value = methodReturnValue(.similarMethodThatDiffersOnType__value_1(.value(value))) as? Bool else {
			print("[FATAL] stub return value not specified for similarMethodThatDiffersOnType(_ value: Float). Use given.")
			fatalError("[FATAL] stub return value not specified for similarMethodThatDiffersOnType(_ value: Float). Use given.")
		}
		return value
      }
      
      func similarMethodThatDiffersOnType(_ value: Point) -> Bool {
          addInvocation(.similarMethodThatDiffersOnType__value_2(.value(value)))
          	let perform = methodPerformValue(.similarMethodThatDiffersOnType__value_2(.value(value))) as? (Point) -> Void
			perform?(value)
          guard let value = methodReturnValue(.similarMethodThatDiffersOnType__value_2(.value(value))) as? Bool else {
			print("[FATAL] stub return value not specified for similarMethodThatDiffersOnType(_ value: Point). Use given.")
			fatalError("[FATAL] stub return value not specified for similarMethodThatDiffersOnType(_ value: Point). Use given.")
		}
		return value
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
          guard let value = methodReturnValue(.methodWithClosures__success_function_1(.value(function))) as? ClosureFabric else {
			print("[FATAL] stub return value not specified for methodWithClosures(success function: LinearFunction). Use given.")
			fatalError("[FATAL] stub return value not specified for methodWithClosures(success function: LinearFunction). Use given.")
		}
		return value
      }
      
      func methodWithClosures(success function: ((Scalar,Scalar) -> Scalar)?) -> ((Int) -> Void) {
          addInvocation(.methodWithClosures__success_function_2(.value(function)))
          	let perform = methodPerformValue(.methodWithClosures__success_function_2(.value(function))) as? (((Scalar,Scalar) -> Scalar)?) -> Void
			perform?(function)
          guard let value = methodReturnValue(.methodWithClosures__success_function_2(.value(function))) as? ((Int) -> Void) else {
			print("[FATAL] stub return value not specified for methodWithClosures(success function: ((Scalar,Scalar) -> Scalar)?). Use given.")
			fatalError("[FATAL] stub return value not specified for methodWithClosures(success function: ((Scalar,Scalar) -> Scalar)?). Use given.")
		}
		return value
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

      struct MethodProxy {
          fileprivate var method: MethodType
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
  
          static func methodWithClosures(success function: Parameter<LinearFunction>, willReturn: ClosureFabric) -> MethodProxy {
              return MethodProxy(method: .methodWithClosures__success_function_1(function), returns: willReturn)
          }
  
          static func methodWithClosures(success function: Parameter<((Scalar,Scalar) -> Scalar)?>, willReturn: ((Int) -> Void)) -> MethodProxy {
              return MethodProxy(method: .methodWithClosures__success_function_2(function), returns: willReturn)
          }
        }

      struct VerificationProxy {
          fileprivate var method: MethodType


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

      struct PerformProxy {
          fileprivate var method: MethodType
          var performs: Any

          static func serviceName(perform: () -> Void) -> PerformProxy {
              return PerformProxy(method: .serviceName, performs: perform)
          }
  
          static func aNewWayToSayHooray(perform: () -> Void) -> PerformProxy {
              return PerformProxy(method: .aNewWayToSayHooray, performs: perform)
          }
  
          static func getPoint(from point: Parameter<Point>, perform: (Point) -> Void) -> PerformProxy {
              return PerformProxy(method: .getPoint__from_point(point), performs: perform)
          }
  
          static func getPoint(from tuple: Parameter<(Float,Float)>, perform: ((Float,Float)) -> Void) -> PerformProxy {
              return PerformProxy(method: .getPoint__from_tuple(tuple), performs: perform)
          }
  
          static func similarMethodThatDiffersOnType(value: Parameter<Float>, perform: (Float) -> Void) -> PerformProxy {
              return PerformProxy(method: .similarMethodThatDiffersOnType__value_1(value), performs: perform)
          }
  
          static func similarMethodThatDiffersOnType(value: Parameter<Point>, perform: (Point) -> Void) -> PerformProxy {
              return PerformProxy(method: .similarMethodThatDiffersOnType__value_2(value), performs: perform)
          }
  
          static func methodWithTypedef(scalar: Parameter<Scalar>, perform: (Scalar) -> Void) -> PerformProxy {
              return PerformProxy(method: .methodWithTypedef__scalar(scalar), performs: perform)
          }
  
          static func methodWithClosures(success function: Parameter<LinearFunction>, perform: (LinearFunction) -> Void) -> PerformProxy {
              return PerformProxy(method: .methodWithClosures__success_function_1(function), performs: perform)
          }
  
          static func methodWithClosures(success function: Parameter<((Scalar,Scalar) -> Scalar)?>, perform: (((Scalar,Scalar) -> Scalar)?) -> Void) -> PerformProxy {
              return PerformProxy(method: .methodWithClosures__success_function_2(function), performs: perform)
          }
        }

      public func matchingCalls(_ method: VerificationProxy) -> Int {
          return matchingCalls(method.method).count
      }

      public func given(_ method: MethodProxy) {
          methodReturnValues.append(method)
          methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
      }

      public func perform(_ method: PerformProxy) {
          methodPerformValues.append(method)
          methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
      }

      public func verify(_ method: VerificationProxy, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
          let method = method.method
          let invocations = matchingCalls(method)
          XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
      }

      private func addInvocation(_ call: MethodType) {
          invocations.append(call)
      }

      private func methodReturnValue(_ method: MethodType) -> Any? {
          let matched = methodReturnValues.reversed().first(where: { proxy -> Bool in
              return MethodType.compareParameters(lhs: proxy.method, rhs: method, matcher: matcher)
          })

          return matched?.returns
      }

      private func methodPerformValue(_ method: MethodType) -> Any? {
          let matched = methodPerformValues.reversed().first(where: { proxy -> Bool in
              return MethodType.compareParameters(lhs: proxy.method, rhs: method, matcher: matcher)
          })

          return matched?.performs
      }

      private func matchingCalls(_ method: MethodType) -> [MethodType] {
          let matchingInvocations = invocations.filter({ (call) -> Bool in
              return MethodType.compareParameters(lhs: call, rhs: method, matcher: matcher)
          })
          return matchingInvocations
      }
}

// MARK: - ItemsClient
class ItemsClientMock: ItemsClient, Mock {

      fileprivate var invocations: [MethodType] = []
      var methodReturnValues: [MethodProxy] = []
      var methodPerformValues: [PerformProxy] = []
      var matcher: Matcher = Matcher.default
            
            

      func getExampleItems() -> Observable<[Item]> {
          addInvocation(.getExampleItems)
          	let perform = methodPerformValue(.getExampleItems) as? () -> Void
			perform?()
          guard let value = methodReturnValue(.getExampleItems) as? Observable<[Item]> else {
			print("[FATAL] stub return value not specified for getExampleItems(). Use given.")
			fatalError("[FATAL] stub return value not specified for getExampleItems(). Use given.")
		}
		return value
      }
      
      func getItemDetails(item: Item) -> Observable<ItemDetails> {
          addInvocation(.getItemDetails__item_item(.value(item)))
          	let perform = methodPerformValue(.getItemDetails__item_item(.value(item))) as? (Item) -> Void
			perform?(item)
          guard let value = methodReturnValue(.getItemDetails__item_item(.value(item))) as? Observable<ItemDetails> else {
			print("[FATAL] stub return value not specified for getItemDetails(item: Item). Use given.")
			fatalError("[FATAL] stub return value not specified for getItemDetails(item: Item). Use given.")
		}
		return value
      }
      
      func update(item: Item, withLimit limit: Decimal, expirationDate date: Date?) -> Single<Void> {
          addInvocation(.update__item_itemwithLimit_limitexpirationDate_date(.value(item), .value(limit), .value(date)))
          	let perform = methodPerformValue(.update__item_itemwithLimit_limitexpirationDate_date(.value(item), .value(limit), .value(date))) as? (Item, Decimal, Date?) -> Void
			perform?(item, limit, date)
          guard let value = methodReturnValue(.update__item_itemwithLimit_limitexpirationDate_date(.value(item), .value(limit), .value(date))) as? Single<Void> else {
			print("[FATAL] stub return value not specified for update(item: Item, withLimit limit: Decimal, expirationDate date: Date?). Use given.")
			fatalError("[FATAL] stub return value not specified for update(item: Item, withLimit limit: Decimal, expirationDate date: Date?). Use given.")
		}
		return value
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

      struct MethodProxy {
          fileprivate var method: MethodType
          var returns: Any?

          static func getExampleItems(willReturn: Observable<[Item]>) -> MethodProxy {
              return MethodProxy(method: .getExampleItems, returns: willReturn)
          }
  
          static func getItemDetails(item: Parameter<Item>, willReturn: Observable<ItemDetails>) -> MethodProxy {
              return MethodProxy(method: .getItemDetails__item_item(item), returns: willReturn)
          }
  
          static func update(item: Parameter<Item>, withLimit limit: Parameter<Decimal>, expirationDate date: Parameter<Date?>, willReturn: Single<Void>) -> MethodProxy {
              return MethodProxy(method: .update__item_itemwithLimit_limitexpirationDate_date(item, limit, date), returns: willReturn)
          }
        }

      struct VerificationProxy {
          fileprivate var method: MethodType


          static func getExampleItems() -> VerificationProxy {
              return VerificationProxy(method: .getExampleItems)
          }
  
          static func getItemDetails(item: Parameter<Item>) -> VerificationProxy {
              return VerificationProxy(method: .getItemDetails__item_item(item))
          }
  
          static func update(item: Parameter<Item>, withLimit limit: Parameter<Decimal>, expirationDate date: Parameter<Date?>) -> VerificationProxy {
              return VerificationProxy(method: .update__item_itemwithLimit_limitexpirationDate_date(item, limit, date))
          }
        }

      struct PerformProxy {
          fileprivate var method: MethodType
          var performs: Any

          static func getExampleItems(perform: () -> Void) -> PerformProxy {
              return PerformProxy(method: .getExampleItems, performs: perform)
          }
  
          static func getItemDetails(item: Parameter<Item>, perform: (Item) -> Void) -> PerformProxy {
              return PerformProxy(method: .getItemDetails__item_item(item), performs: perform)
          }
  
          static func update(item: Parameter<Item>, withLimit limit: Parameter<Decimal>, expirationDate date: Parameter<Date?>, perform: (Item, Decimal, Date?) -> Void) -> PerformProxy {
              return PerformProxy(method: .update__item_itemwithLimit_limitexpirationDate_date(item, limit, date), performs: perform)
          }
        }

      public func matchingCalls(_ method: VerificationProxy) -> Int {
          return matchingCalls(method.method).count
      }

      public func given(_ method: MethodProxy) {
          methodReturnValues.append(method)
          methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
      }

      public func perform(_ method: PerformProxy) {
          methodPerformValues.append(method)
          methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
      }

      public func verify(_ method: VerificationProxy, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
          let method = method.method
          let invocations = matchingCalls(method)
          XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
      }

      private func addInvocation(_ call: MethodType) {
          invocations.append(call)
      }

      private func methodReturnValue(_ method: MethodType) -> Any? {
          let matched = methodReturnValues.reversed().first(where: { proxy -> Bool in
              return MethodType.compareParameters(lhs: proxy.method, rhs: method, matcher: matcher)
          })

          return matched?.returns
      }

      private func methodPerformValue(_ method: MethodType) -> Any? {
          let matched = methodPerformValues.reversed().first(where: { proxy -> Bool in
              return MethodType.compareParameters(lhs: proxy.method, rhs: method, matcher: matcher)
          })

          return matched?.performs
      }

      private func matchingCalls(_ method: MethodType) -> [MethodType] {
          let matchingInvocations = invocations.filter({ (call) -> Bool in
              return MethodType.compareParameters(lhs: call, rhs: method, matcher: matcher)
          })
          return matchingInvocations
      }
}

// MARK: - ItemsModel
class ItemsModelMock: ItemsModel, Mock {

      fileprivate var invocations: [MethodType] = []
      var methodReturnValues: [MethodProxy] = []
      var methodPerformValues: [PerformProxy] = []
      var matcher: Matcher = Matcher.default
            

      static var defaultIdentifier: Int { 
		get { 
			guard let value = ItemsModelMock.__defaultIdentifier else { 				print("[FATAL] ItemsModelMock - value for __defaultIdentifier is not set!")
				fatalError("[FATAL] ItemsModelMock - value for __defaultIdentifier is not set!")
			}
			return value 
		}
		set { ItemsModelMock.__defaultIdentifier = newValue }
	}
	private static var __defaultIdentifier: Int!      
      static var optionalIdentifier: String? { 
		get { 
			guard let value = ItemsModelMock.__optionalIdentifier else { 				print("[FATAL] ItemsModelMock - value for __optionalIdentifier is not set!")
				fatalError("[FATAL] ItemsModelMock - value for __optionalIdentifier is not set!")
			}
			return value 
		}
		set { ItemsModelMock.__optionalIdentifier = newValue }
	}
	private static var __optionalIdentifier: String?      
      var context: Any? { 
		get { 
			guard let value = __context else { 				print("[FATAL] ItemsModelMock - value for __context is not set!")
				fatalError("[FATAL] ItemsModelMock - value for __context is not set!")
			}
			return value 
		}
		set { __context = newValue }
	}
	private var __context: Any?      
      var storage: Any! { 
		get { 
			guard let value = __storage else { 				print("[FATAL] ItemsModelMock - value for __storage is not set!")
				fatalError("[FATAL] ItemsModelMock - value for __storage is not set!")
			}
			return value 
		}
		set { __storage = newValue }
	}
	private var __storage: Any!      
      var some: Any { 
		get { 
			guard let value = __some else { 				print("[FATAL] ItemsModelMock - value for __some is not set!")
				fatalError("[FATAL] ItemsModelMock - value for __some is not set!")
			}
			return value 
		}
		set { __some = newValue }
	}
	private var __some: Any!      
      var storedProperty: Any { 
		get { 
			guard let value = __storedProperty else { 				print("[FATAL] ItemsModelMock - value for __storedProperty is not set!")
				fatalError("[FATAL] ItemsModelMock - value for __storedProperty is not set!")
			}
			return value 
		}
		set { __storedProperty = newValue }
	}
	private var __storedProperty: Any!                  

      func getExampleItems() -> Observable<[Item]> {
          addInvocation(.getExampleItems)
          	let perform = methodPerformValue(.getExampleItems) as? () -> Void
			perform?()
          guard let value = methodReturnValue(.getExampleItems) as? Observable<[Item]> else {
			print("[FATAL] stub return value not specified for getExampleItems(). Use given.")
			fatalError("[FATAL] stub return value not specified for getExampleItems(). Use given.")
		}
		return value
      }
      
      func getItemDetails(item: Item) -> Observable<ItemDetails> {
          addInvocation(.getItemDetails__item_item(.value(item)))
          	let perform = methodPerformValue(.getItemDetails__item_item(.value(item))) as? (Item) -> Void
			perform?(item)
          guard let value = methodReturnValue(.getItemDetails__item_item(.value(item))) as? Observable<ItemDetails> else {
			print("[FATAL] stub return value not specified for getItemDetails(item: Item). Use given.")
			fatalError("[FATAL] stub return value not specified for getItemDetails(item: Item). Use given.")
		}
		return value
      }
      
      func getPrice(for item: Item) -> Decimal {
          addInvocation(.getPrice__for_item(.value(item)))
          	let perform = methodPerformValue(.getPrice__for_item(.value(item))) as? (Item) -> Void
			perform?(item)
          guard let value = methodReturnValue(.getPrice__for_item(.value(item))) as? Decimal else {
			print("[FATAL] stub return value not specified for getPrice(for item: Item). Use given.")
			fatalError("[FATAL] stub return value not specified for getPrice(for item: Item). Use given.")
		}
		return value
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

      struct MethodProxy {
          fileprivate var method: MethodType
          var returns: Any?

          static func getExampleItems(willReturn: Observable<[Item]>) -> MethodProxy {
              return MethodProxy(method: .getExampleItems, returns: willReturn)
          }
  
          static func getItemDetails(item: Parameter<Item>, willReturn: Observable<ItemDetails>) -> MethodProxy {
              return MethodProxy(method: .getItemDetails__item_item(item), returns: willReturn)
          }
  
          static func getPrice(for item: Parameter<Item>, willReturn: Decimal) -> MethodProxy {
              return MethodProxy(method: .getPrice__for_item(item), returns: willReturn)
          }
        }

      struct VerificationProxy {
          fileprivate var method: MethodType


          static func getExampleItems() -> VerificationProxy {
              return VerificationProxy(method: .getExampleItems)
          }
  
          static func getItemDetails(item: Parameter<Item>) -> VerificationProxy {
              return VerificationProxy(method: .getItemDetails__item_item(item))
          }
  
          static func getPrice(for item: Parameter<Item>) -> VerificationProxy {
              return VerificationProxy(method: .getPrice__for_item(item))
          }
        }

      struct PerformProxy {
          fileprivate var method: MethodType
          var performs: Any

          static func getExampleItems(perform: () -> Void) -> PerformProxy {
              return PerformProxy(method: .getExampleItems, performs: perform)
          }
  
          static func getItemDetails(item: Parameter<Item>, perform: (Item) -> Void) -> PerformProxy {
              return PerformProxy(method: .getItemDetails__item_item(item), performs: perform)
          }
  
          static func getPrice(for item: Parameter<Item>, perform: (Item) -> Void) -> PerformProxy {
              return PerformProxy(method: .getPrice__for_item(item), performs: perform)
          }
        }

      public func matchingCalls(_ method: VerificationProxy) -> Int {
          return matchingCalls(method.method).count
      }

      public func given(_ method: MethodProxy) {
          methodReturnValues.append(method)
          methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
      }

      public func perform(_ method: PerformProxy) {
          methodPerformValues.append(method)
          methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
      }

      public func verify(_ method: VerificationProxy, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
          let method = method.method
          let invocations = matchingCalls(method)
          XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
      }

      private func addInvocation(_ call: MethodType) {
          invocations.append(call)
      }

      private func methodReturnValue(_ method: MethodType) -> Any? {
          let matched = methodReturnValues.reversed().first(where: { proxy -> Bool in
              return MethodType.compareParameters(lhs: proxy.method, rhs: method, matcher: matcher)
          })

          return matched?.returns
      }

      private func methodPerformValue(_ method: MethodType) -> Any? {
          let matched = methodPerformValues.reversed().first(where: { proxy -> Bool in
              return MethodType.compareParameters(lhs: proxy.method, rhs: method, matcher: matcher)
          })

          return matched?.performs
      }

      private func matchingCalls(_ method: MethodType) -> [MethodType] {
          let matchingInvocations = invocations.filter({ (call) -> Bool in
              return MethodType.compareParameters(lhs: call, rhs: method, matcher: matcher)
          })
          return matchingInvocations
      }
}

// MARK: - NonSwiftProtocol
class NonSwiftProtocolMock: NSObject, NonSwiftProtocol, Mock {

      fileprivate var invocations: [MethodType] = []
      var methodReturnValues: [MethodProxy] = []
      var methodPerformValues: [PerformProxy] = []
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

      struct MethodProxy {
          fileprivate var method: MethodType
          var returns: Any?
      }

      struct VerificationProxy {
          fileprivate var method: MethodType


          static func returnNoting() -> VerificationProxy {
              return VerificationProxy(method: .returnNoting)
          }
  
          static func someMethod() -> VerificationProxy {
              return VerificationProxy(method: .someMethod)
          }
        }

      struct PerformProxy {
          fileprivate var method: MethodType
          var performs: Any

          static func returnNoting(perform: () -> Void) -> PerformProxy {
              return PerformProxy(method: .returnNoting, performs: perform)
          }
  
          static func someMethod(perform: () -> Void) -> PerformProxy {
              return PerformProxy(method: .someMethod, performs: perform)
          }
        }

      public func matchingCalls(_ method: VerificationProxy) -> Int {
          return matchingCalls(method.method).count
      }

      public func given(_ method: MethodProxy) {
          methodReturnValues.append(method)
          methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
      }

      public func perform(_ method: PerformProxy) {
          methodPerformValues.append(method)
          methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
      }

      public func verify(_ method: VerificationProxy, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
          let method = method.method
          let invocations = matchingCalls(method)
          XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
      }

      private func addInvocation(_ call: MethodType) {
          invocations.append(call)
      }

      private func methodReturnValue(_ method: MethodType) -> Any? {
          let matched = methodReturnValues.reversed().first(where: { proxy -> Bool in
              return MethodType.compareParameters(lhs: proxy.method, rhs: method, matcher: matcher)
          })

          return matched?.returns
      }

      private func methodPerformValue(_ method: MethodType) -> Any? {
          let matched = methodPerformValues.reversed().first(where: { proxy -> Bool in
              return MethodType.compareParameters(lhs: proxy.method, rhs: method, matcher: matcher)
          })

          return matched?.performs
      }

      private func matchingCalls(_ method: MethodType) -> [MethodType] {
          let matchingInvocations = invocations.filter({ (call) -> Bool in
              return MethodType.compareParameters(lhs: call, rhs: method, matcher: matcher)
          })
          return matchingInvocations
      }
}

// MARK: - SampleServiceType
class SampleServiceTypeMock: SampleServiceType, Mock {

      fileprivate var invocations: [MethodType] = []
      var methodReturnValues: [MethodProxy] = []
      var methodPerformValues: [PerformProxy] = []
      var matcher: Matcher = Matcher.default
            
            

      func serviceName() -> String {
          addInvocation(.serviceName)
          	let perform = methodPerformValue(.serviceName) as? () -> Void
			perform?()
          guard let value = methodReturnValue(.serviceName) as? String else {
			print("[FATAL] stub return value not specified for serviceName(). Use given.")
			fatalError("[FATAL] stub return value not specified for serviceName(). Use given.")
		}
		return value
      }
      
      func getPoint(from point: Point) -> Point {
          addInvocation(.getPoint__from_point(.value(point)))
          	let perform = methodPerformValue(.getPoint__from_point(.value(point))) as? (Point) -> Void
			perform?(point)
          guard let value = methodReturnValue(.getPoint__from_point(.value(point))) as? Point else {
			print("[FATAL] stub return value not specified for getPoint(from point: Point). Use given.")
			fatalError("[FATAL] stub return value not specified for getPoint(from point: Point). Use given.")
		}
		return value
      }
      
      func getPoint(from tuple: (Float,Float)) -> Point {
          addInvocation(.getPoint__from_tuple(.value(tuple)))
          	let perform = methodPerformValue(.getPoint__from_tuple(.value(tuple))) as? ((Float,Float)) -> Void
			perform?(tuple)
          guard let value = methodReturnValue(.getPoint__from_tuple(.value(tuple))) as? Point else {
			print("[FATAL] stub return value not specified for getPoint(from tuple: (Float,Float)). Use given.")
			fatalError("[FATAL] stub return value not specified for getPoint(from tuple: (Float,Float)). Use given.")
		}
		return value
      }
      
      func similarMethodThatDiffersOnType(_ value: Float) -> Bool {
          addInvocation(.similarMethodThatDiffersOnType__value_1(.value(value)))
          	let perform = methodPerformValue(.similarMethodThatDiffersOnType__value_1(.value(value))) as? (Float) -> Void
			perform?(value)
          guard let value = methodReturnValue(.similarMethodThatDiffersOnType__value_1(.value(value))) as? Bool else {
			print("[FATAL] stub return value not specified for similarMethodThatDiffersOnType(_ value: Float). Use given.")
			fatalError("[FATAL] stub return value not specified for similarMethodThatDiffersOnType(_ value: Float). Use given.")
		}
		return value
      }
      
      func similarMethodThatDiffersOnType(_ value: Point) -> Bool {
          addInvocation(.similarMethodThatDiffersOnType__value_2(.value(value)))
          	let perform = methodPerformValue(.similarMethodThatDiffersOnType__value_2(.value(value))) as? (Point) -> Void
			perform?(value)
          guard let value = methodReturnValue(.similarMethodThatDiffersOnType__value_2(.value(value))) as? Bool else {
			print("[FATAL] stub return value not specified for similarMethodThatDiffersOnType(_ value: Point). Use given.")
			fatalError("[FATAL] stub return value not specified for similarMethodThatDiffersOnType(_ value: Point). Use given.")
		}
		return value
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
          guard let value = methodReturnValue(.methodWithClosures__success_function_1(.value(function))) as? ClosureFabric else {
			print("[FATAL] stub return value not specified for methodWithClosures(success function: LinearFunction). Use given.")
			fatalError("[FATAL] stub return value not specified for methodWithClosures(success function: LinearFunction). Use given.")
		}
		return value
      }
      
      func methodWithClosures(success function: ((Scalar,Scalar) -> Scalar)?) -> ((Int) -> Void) {
          addInvocation(.methodWithClosures__success_function_2(.value(function)))
          	let perform = methodPerformValue(.methodWithClosures__success_function_2(.value(function))) as? (((Scalar,Scalar) -> Scalar)?) -> Void
			perform?(function)
          guard let value = methodReturnValue(.methodWithClosures__success_function_2(.value(function))) as? ((Int) -> Void) else {
			print("[FATAL] stub return value not specified for methodWithClosures(success function: ((Scalar,Scalar) -> Scalar)?). Use given.")
			fatalError("[FATAL] stub return value not specified for methodWithClosures(success function: ((Scalar,Scalar) -> Scalar)?). Use given.")
		}
		return value
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

      struct MethodProxy {
          fileprivate var method: MethodType
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
  
          static func methodWithClosures(success function: Parameter<LinearFunction>, willReturn: ClosureFabric) -> MethodProxy {
              return MethodProxy(method: .methodWithClosures__success_function_1(function), returns: willReturn)
          }
  
          static func methodWithClosures(success function: Parameter<((Scalar,Scalar) -> Scalar)?>, willReturn: ((Int) -> Void)) -> MethodProxy {
              return MethodProxy(method: .methodWithClosures__success_function_2(function), returns: willReturn)
          }
        }

      struct VerificationProxy {
          fileprivate var method: MethodType


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

      struct PerformProxy {
          fileprivate var method: MethodType
          var performs: Any

          static func serviceName(perform: () -> Void) -> PerformProxy {
              return PerformProxy(method: .serviceName, performs: perform)
          }
  
          static func getPoint(from point: Parameter<Point>, perform: (Point) -> Void) -> PerformProxy {
              return PerformProxy(method: .getPoint__from_point(point), performs: perform)
          }
  
          static func getPoint(from tuple: Parameter<(Float,Float)>, perform: ((Float,Float)) -> Void) -> PerformProxy {
              return PerformProxy(method: .getPoint__from_tuple(tuple), performs: perform)
          }
  
          static func similarMethodThatDiffersOnType(value: Parameter<Float>, perform: (Float) -> Void) -> PerformProxy {
              return PerformProxy(method: .similarMethodThatDiffersOnType__value_1(value), performs: perform)
          }
  
          static func similarMethodThatDiffersOnType(value: Parameter<Point>, perform: (Point) -> Void) -> PerformProxy {
              return PerformProxy(method: .similarMethodThatDiffersOnType__value_2(value), performs: perform)
          }
  
          static func methodWithTypedef(scalar: Parameter<Scalar>, perform: (Scalar) -> Void) -> PerformProxy {
              return PerformProxy(method: .methodWithTypedef__scalar(scalar), performs: perform)
          }
  
          static func methodWithClosures(success function: Parameter<LinearFunction>, perform: (LinearFunction) -> Void) -> PerformProxy {
              return PerformProxy(method: .methodWithClosures__success_function_1(function), performs: perform)
          }
  
          static func methodWithClosures(success function: Parameter<((Scalar,Scalar) -> Scalar)?>, perform: (((Scalar,Scalar) -> Scalar)?) -> Void) -> PerformProxy {
              return PerformProxy(method: .methodWithClosures__success_function_2(function), performs: perform)
          }
        }

      public func matchingCalls(_ method: VerificationProxy) -> Int {
          return matchingCalls(method.method).count
      }

      public func given(_ method: MethodProxy) {
          methodReturnValues.append(method)
          methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
      }

      public func perform(_ method: PerformProxy) {
          methodPerformValues.append(method)
          methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
      }

      public func verify(_ method: VerificationProxy, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
          let method = method.method
          let invocations = matchingCalls(method)
          XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
      }

      private func addInvocation(_ call: MethodType) {
          invocations.append(call)
      }

      private func methodReturnValue(_ method: MethodType) -> Any? {
          let matched = methodReturnValues.reversed().first(where: { proxy -> Bool in
              return MethodType.compareParameters(lhs: proxy.method, rhs: method, matcher: matcher)
          })

          return matched?.returns
      }

      private func methodPerformValue(_ method: MethodType) -> Any? {
          let matched = methodPerformValues.reversed().first(where: { proxy -> Bool in
              return MethodType.compareParameters(lhs: proxy.method, rhs: method, matcher: matcher)
          })

          return matched?.performs
      }

      private func matchingCalls(_ method: MethodType) -> [MethodType] {
          let matchingInvocations = invocations.filter({ (call) -> Bool in
              return MethodType.compareParameters(lhs: call, rhs: method, matcher: matcher)
          })
          return matchingInvocations
      }
}

// MARK: - SimpleServiceType
class SimpleServiceTypeMock: SimpleServiceType, Mock {

      fileprivate var invocations: [MethodType] = []
      var methodReturnValues: [MethodProxy] = []
      var methodPerformValues: [PerformProxy] = []
      var matcher: Matcher = Matcher.default
            

      var youCouldOnlyGetThis: String { 
		get { 
			guard let value = __youCouldOnlyGetThis else { 				print("[FATAL] SimpleServiceTypeMock - value for __youCouldOnlyGetThis is not set!")
				fatalError("[FATAL] SimpleServiceTypeMock - value for __youCouldOnlyGetThis is not set!")
			}
			return value 
		}
		set { __youCouldOnlyGetThis = newValue }
	}
	private var __youCouldOnlyGetThis: String!                  

      func serviceName() -> String {
          addInvocation(.serviceName)
          	let perform = methodPerformValue(.serviceName) as? () -> Void
			perform?()
          guard let value = methodReturnValue(.serviceName) as? String else {
			print("[FATAL] stub return value not specified for serviceName(). Use given.")
			fatalError("[FATAL] stub return value not specified for serviceName(). Use given.")
		}
		return value
      }
      
      fileprivate enum MethodType {

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
          fileprivate var method: MethodType
          var returns: Any?

          static func serviceName(willReturn: String) -> MethodProxy {
              return MethodProxy(method: .serviceName, returns: willReturn)
          }
        }

      struct VerificationProxy {
          fileprivate var method: MethodType


          static func serviceName() -> VerificationProxy {
              return VerificationProxy(method: .serviceName)
          }
        }

      struct PerformProxy {
          fileprivate var method: MethodType
          var performs: Any

          static func serviceName(perform: () -> Void) -> PerformProxy {
              return PerformProxy(method: .serviceName, performs: perform)
          }
        }

      public func matchingCalls(_ method: VerificationProxy) -> Int {
          return matchingCalls(method.method).count
      }

      public func given(_ method: MethodProxy) {
          methodReturnValues.append(method)
          methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
      }

      public func perform(_ method: PerformProxy) {
          methodPerformValues.append(method)
          methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
      }

      public func verify(_ method: VerificationProxy, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
          let method = method.method
          let invocations = matchingCalls(method)
          XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
      }

      private func addInvocation(_ call: MethodType) {
          invocations.append(call)
      }

      private func methodReturnValue(_ method: MethodType) -> Any? {
          let matched = methodReturnValues.reversed().first(where: { proxy -> Bool in
              return MethodType.compareParameters(lhs: proxy.method, rhs: method, matcher: matcher)
          })

          return matched?.returns
      }

      private func methodPerformValue(_ method: MethodType) -> Any? {
          let matched = methodPerformValues.reversed().first(where: { proxy -> Bool in
              return MethodType.compareParameters(lhs: proxy.method, rhs: method, matcher: matcher)
          })

          return matched?.performs
      }

      private func matchingCalls(_ method: MethodType) -> [MethodType] {
          let matchingInvocations = invocations.filter({ (call) -> Bool in
              return MethodType.compareParameters(lhs: call, rhs: method, matcher: matcher)
          })
          return matchingInvocations
      }
}

// MARK: - UserNetworkType
class UserNetworkTypeMock: UserNetworkType, Mock {

      fileprivate var invocations: [MethodType] = []
      var methodReturnValues: [MethodProxy] = []
      var methodPerformValues: [PerformProxy] = []
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

      struct MethodProxy {
          fileprivate var method: MethodType
          var returns: Any?
      }

      struct VerificationProxy {
          fileprivate var method: MethodType


          static func getUser(for id: Parameter<String>, completion: Parameter<(User?) -> Void>) -> VerificationProxy {
              return VerificationProxy(method: .getUser__for_idcompletion_completion(id, completion))
          }
  
          static func getUserEscaping(for id: Parameter<String>, completion: Parameter< (User?,Error?) -> Void>) -> VerificationProxy {
              return VerificationProxy(method: .getUserEscaping__for_idcompletion_completion(id, completion))
          }
  
          static func doSomething(prop: Parameter< () -> String>) -> VerificationProxy {
              return VerificationProxy(method: .doSomething__prop_prop(prop))
          }
  
          static func testDefaultValues(value: Parameter<String>) -> VerificationProxy {
              return VerificationProxy(method: .testDefaultValues__value_value(value))
          }
        }

      struct PerformProxy {
          fileprivate var method: MethodType
          var performs: Any

          static func getUser(for id: Parameter<String>, completion: Parameter<(User?) -> Void>, perform: (String, (User?) -> Void) -> Void) -> PerformProxy {
              return PerformProxy(method: .getUser__for_idcompletion_completion(id, completion), performs: perform)
          }
  
          static func getUserEscaping(for id: Parameter<String>, completion: Parameter< (User?,Error?) -> Void>, perform: (String, @escaping (User?,Error?) -> Void) -> Void) -> PerformProxy {
              return PerformProxy(method: .getUserEscaping__for_idcompletion_completion(id, completion), performs: perform)
          }
  
          static func doSomething(prop: Parameter< () -> String>, perform: (@autoclosure () -> String) -> Void) -> PerformProxy {
              return PerformProxy(method: .doSomething__prop_prop(prop), performs: perform)
          }
  
          static func testDefaultValues(value: Parameter<String>, perform: (String) -> Void) -> PerformProxy {
              return PerformProxy(method: .testDefaultValues__value_value(value), performs: perform)
          }
        }

      public func matchingCalls(_ method: VerificationProxy) -> Int {
          return matchingCalls(method.method).count
      }

      public func given(_ method: MethodProxy) {
          methodReturnValues.append(method)
          methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
      }

      public func perform(_ method: PerformProxy) {
          methodPerformValues.append(method)
          methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
      }

      public func verify(_ method: VerificationProxy, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
          let method = method.method
          let invocations = matchingCalls(method)
          XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
      }

      private func addInvocation(_ call: MethodType) {
          invocations.append(call)
      }

      private func methodReturnValue(_ method: MethodType) -> Any? {
          let matched = methodReturnValues.reversed().first(where: { proxy -> Bool in
              return MethodType.compareParameters(lhs: proxy.method, rhs: method, matcher: matcher)
          })

          return matched?.returns
      }

      private func methodPerformValue(_ method: MethodType) -> Any? {
          let matched = methodPerformValues.reversed().first(where: { proxy -> Bool in
              return MethodType.compareParameters(lhs: proxy.method, rhs: method, matcher: matcher)
          })

          return matched?.performs
      }

      private func matchingCalls(_ method: MethodType) -> [MethodType] {
          let matchingInvocations = invocations.filter({ (call) -> Bool in
              return MethodType.compareParameters(lhs: call, rhs: method, matcher: matcher)
          })
          return matchingInvocations
      }
}

// MARK: - UserStorageType
class UserStorageTypeMock: UserStorageType, Mock {

      fileprivate var invocations: [MethodType] = []
      var methodReturnValues: [MethodProxy] = []
      var methodPerformValues: [PerformProxy] = []
      var matcher: Matcher = Matcher.default
            
            

      func surname(for name: String) -> String {
          addInvocation(.surname__for_name(.value(name)))
          	let perform = methodPerformValue(.surname__for_name(.value(name))) as? (String) -> Void
			perform?(name)
          guard let value = methodReturnValue(.surname__for_name(.value(name))) as? String else {
			print("[FATAL] stub return value not specified for surname(for name: String). Use given.")
			fatalError("[FATAL] stub return value not specified for surname(for name: String). Use given.")
		}
		return value
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

      struct MethodProxy {
          fileprivate var method: MethodType
          var returns: Any?

          static func surname(for name: Parameter<String>, willReturn: String) -> MethodProxy {
              return MethodProxy(method: .surname__for_name(name), returns: willReturn)
          }
        }

      struct VerificationProxy {
          fileprivate var method: MethodType


          static func surname(for name: Parameter<String>) -> VerificationProxy {
              return VerificationProxy(method: .surname__for_name(name))
          }
  
          static func storeUser(name: Parameter<String>, surname: Parameter<String>) -> VerificationProxy {
              return VerificationProxy(method: .storeUser__name_namesurname_surname(name, surname))
          }
        }

      struct PerformProxy {
          fileprivate var method: MethodType
          var performs: Any

          static func surname(for name: Parameter<String>, perform: (String) -> Void) -> PerformProxy {
              return PerformProxy(method: .surname__for_name(name), performs: perform)
          }
  
          static func storeUser(name: Parameter<String>, surname: Parameter<String>, perform: (String, String) -> Void) -> PerformProxy {
              return PerformProxy(method: .storeUser__name_namesurname_surname(name, surname), performs: perform)
          }
        }

      public func matchingCalls(_ method: VerificationProxy) -> Int {
          return matchingCalls(method.method).count
      }

      public func given(_ method: MethodProxy) {
          methodReturnValues.append(method)
          methodReturnValues.sort { $0.method.intValue() < $1.method.intValue() }
      }

      public func perform(_ method: PerformProxy) {
          methodPerformValues.append(method)
          methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
      }

      public func verify(_ method: VerificationProxy, count: UInt = 1, file: StaticString = #file, line: UInt = #line) {
          let method = method.method
          let invocations = matchingCalls(method)
          XCTAssert(invocations.count == Int(count), "Expeced: \(count) invocations of `\(method)`, but was: \(invocations.count)", file: file, line: line)
      }

      private func addInvocation(_ call: MethodType) {
          invocations.append(call)
      }

      private func methodReturnValue(_ method: MethodType) -> Any? {
          let matched = methodReturnValues.reversed().first(where: { proxy -> Bool in
              return MethodType.compareParameters(lhs: proxy.method, rhs: method, matcher: matcher)
          })

          return matched?.returns
      }

      private func methodPerformValue(_ method: MethodType) -> Any? {
          let matched = methodPerformValues.reversed().first(where: { proxy -> Bool in
              return MethodType.compareParameters(lhs: proxy.method, rhs: method, matcher: matcher)
          })

          return matched?.performs
      }

      private func matchingCalls(_ method: MethodType) -> [MethodType] {
          let matchingInvocations = invocations.filter({ (call) -> Bool in
              return MethodType.compareParameters(lhs: call, rhs: method, matcher: matcher)
          })
          return matchingInvocations
      }
}

