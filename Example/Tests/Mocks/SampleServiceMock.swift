//
//  SampleServiceMock.swift
//  Mocky
//
//  Created by Andrzej Michnia on 24.09.2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import Mocky
import XCTest
@testable import Mocky_Example

// sourcery: mock = "SampleServiceType"
class SampleServiceMock: SampleServiceType, Mock {


// sourcery:inline:auto:SampleServiceMock.autoMocked

    var invocations: [MethodType] = []
    var methodReturnValues: [MethodProxy] = []
    var matcher: Matcher = Matcher.default

    //MARK : SampleServiceType


            
            
            
            
            


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
        addInvocation(.similarMethodThatDiffersOnType__value_Float(.value(value)))
        return methodReturnValue(.similarMethodThatDiffersOnType__value_Float(.value(value))) as! Bool 
    }
    
    func similarMethodThatDiffersOnType(_ value: Point) -> Bool {
        addInvocation(.similarMethodThatDiffersOnType__value_Point(.value(value)))
        return methodReturnValue(.similarMethodThatDiffersOnType__value_Point(.value(value))) as! Bool 
    }
    
    enum MethodType {

        case serviceName    
        case getPoint__from_point(Parameter<Point>)    
        case getPoint__from_tuple(Parameter<(Float,Float)>)    
        case similarMethodThatDiffersOnType__value_Float(Parameter<Float>)    
        case similarMethodThatDiffersOnType__value_Point(Parameter<Point>)    
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
                case (.similarMethodThatDiffersOnType__value_Float(let lhsValue), .similarMethodThatDiffersOnType__value_Float(let rhsValue)): 
                    guard Parameter.compare(lhs: lhsValue, rhs: rhsValue, with: matcher) else { return false } 
                    return true 
                case (.similarMethodThatDiffersOnType__value_Point(let lhsValue), .similarMethodThatDiffersOnType__value_Point(let rhsValue)): 
                    guard Parameter.compare(lhs: lhsValue, rhs: rhsValue, with: matcher) else { return false } 
                    return true 
                default: return false
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
            return MethodProxy(method: .similarMethodThatDiffersOnType__value_Float(value), returns: willReturn)
        }
        
        static func similarMethodThatDiffersOnType(value: Parameter<Point>, willReturn: Bool) -> MethodProxy {
            return MethodProxy(method: .similarMethodThatDiffersOnType__value_Point(value), returns: willReturn)
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
            return VerificationProxy(method: .similarMethodThatDiffersOnType__value_Float(value))
        }
        
        static func similarMethodThatDiffersOnType(value: Parameter<Point>) -> VerificationProxy {
            return VerificationProxy(method: .similarMethodThatDiffersOnType__value_Point(value))
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

    public func given(_ method: MethodProxy) {
        methodReturnValues.append(method)
    }
// sourcery:end
}
