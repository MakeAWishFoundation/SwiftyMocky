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

    public func given(_ method: MethodProxy) {
        methodReturnValues.append(method)
    }
// sourcery:end
}
