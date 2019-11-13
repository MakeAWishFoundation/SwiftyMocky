//
//  AllLiteralsContainerProtocol.swift
//  SwiftyMocky
//
//  Created by Andrzej Michnia on 20/09/2018.
//  Copyright © 2018 MakeAWishFoundation. All rights reserved.
//

import Foundation

enum CustomString: ExpressibleByStringLiteral, Equatable {
    typealias StringLiteralType = String

    case a
    case b(String)

    init(stringLiteral value: StringLiteralType) {
        switch value {
        case "a": self = .a
        default: self = .b(value)
        }
    }
}

enum CustomInt: ExpressibleByIntegerLiteral, Equatable {
    typealias IntegerLiteralType = Int

    case zero
    case value(Int)

    init(integerLiteral value: IntegerLiteralType) {
        switch value {
        case 0: self = .zero
        default: self = .value(value)
        }
    }
}

class SomeClass: Equatable {
    static func == (lhs: SomeClass, rhs: SomeClass) -> Bool {
        return lhs.v == rhs.v
    }

    let v: Int
    init(v: Int) {
        self.v = v
    }
}

//sourcery: AutoMockable
protocol AllLiteralsContainer {
    // ExpressibleByNilLiteral

    // ExpressibleByStringLiteral
    func methodWithStringParameter(p: String) -> Int
    func methodWithOtionalStringParameter(p: String?) -> Int
    func methodWithCustomStringParameter(p: CustomString) -> Int
    func methodWithCustomOptionalStringParameter(p: CustomString?) -> Int

    // ExpressibleByIntegerLiteral
    func methodWithIntParameter(p: Int) -> Int
    func methodWithCustomOptionalIntParameter(p: CustomInt?) -> Int

    // ExpressibleByBooleanLiteral
    func methodWithBool(p: Bool?) -> Int

    // ExpressibleByFloatLiteral
    func methodWithFloat(p: Float?) -> Int
    func methodWithDouble(p: Double?) -> Int

    // ExpressibleByArrayLiteral
    func methodWithArrayOfInt(p: [Int]) -> Int
    func methodWithArrayOfOther(p: [SomeClass]) -> Int
    func methodWithSetOfInt(p: Set<Int>) -> Int
    func methodWithOptionalSetOfInt(p: Set<Int>?) -> Int

    // ExpressibleByDictionaryLiteral
    func methodWithDict(p: [String: SomeClass]) -> Int
}
