//
//  Parameter+Literals.swift
//  SwiftyMocky
//
//  Created by Andrzej Michnia on 20/09/2018.
//  Copyright © 2018 MakeAWishFoundation. All rights reserved.
//

import Foundation

// MARK: - ExpressibleByStringLiteral
extension Optional: ExpressibleByStringLiteral, ExpressibleByExtendedGraphemeClusterLiteral, ExpressibleByUnicodeScalarLiteral where Wrapped: ExpressibleByStringLiteral {
    public typealias StringLiteralType = Wrapped.StringLiteralType
    public typealias ExtendedGraphemeClusterLiteralType = Wrapped.ExtendedGraphemeClusterLiteralType
    public typealias UnicodeScalarLiteralType = Wrapped.UnicodeScalarLiteralType

    public init(stringLiteral value: StringLiteralType) {
        self = .some(Wrapped.init(stringLiteral: value))
    }

    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self = .some(Wrapped.init(extendedGraphemeClusterLiteral: value))
    }

    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self = .some(Wrapped.init(unicodeScalarLiteral: value))
    }
}

extension Parameter: ExpressibleByStringLiteral, ExpressibleByExtendedGraphemeClusterLiteral, ExpressibleByUnicodeScalarLiteral where ValueType: ExpressibleByStringLiteral {
    public typealias StringLiteralType = ValueType.StringLiteralType
    public typealias ExtendedGraphemeClusterLiteralType = ValueType.ExtendedGraphemeClusterLiteralType
    public typealias UnicodeScalarLiteralType = ValueType.UnicodeScalarLiteralType

    public init(stringLiteral value: StringLiteralType) {
        self = .value(ValueType.init(stringLiteral: value))
    }

    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self = .value(ValueType.init(extendedGraphemeClusterLiteral: value))
    }

    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self = .value(ValueType.init(unicodeScalarLiteral: value))
    }
}

// MARK: - ExpressibleByNilLiteral
extension Parameter: ExpressibleByNilLiteral where ValueType: ExpressibleByNilLiteral {
    public init(nilLiteral: ()) {
        self = .value(nil)
    }
}

// MARK: - ExpressibleByIntegerLiteral
extension Optional: ExpressibleByIntegerLiteral where Wrapped: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = Wrapped.IntegerLiteralType

    public init(integerLiteral value: IntegerLiteralType) {
        self = .some(Wrapped.init(integerLiteral: value))
    }
}

extension Parameter: ExpressibleByIntegerLiteral where ValueType: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = ValueType.IntegerLiteralType

    public init(integerLiteral value: ValueType.IntegerLiteralType) {
        self = .value(ValueType.init(integerLiteral: value))
    }
}

// MARK: - ExpressibleByBooleanLiteral
extension Optional: ExpressibleByBooleanLiteral where Wrapped: ExpressibleByBooleanLiteral {
    public typealias BooleanLiteralType = Wrapped.BooleanLiteralType

    public init(booleanLiteral value: BooleanLiteralType) {
        self = .some(Wrapped.init(booleanLiteral: value))
    }
}

extension Parameter: ExpressibleByBooleanLiteral where ValueType: ExpressibleByBooleanLiteral {
    public typealias BooleanLiteralType = ValueType.BooleanLiteralType

    public init(booleanLiteral value: BooleanLiteralType) {
        self = .value(ValueType.init(booleanLiteral: value))
    }
}

// MARK: - ExpressibleByFloatLiteral
extension Optional: ExpressibleByFloatLiteral where Wrapped: ExpressibleByFloatLiteral {
    public typealias FloatLiteralType = Wrapped.FloatLiteralType

    public init(floatLiteral value: FloatLiteralType) {
        self = .some(Wrapped.init(floatLiteral: value))
    }
}

extension Parameter: ExpressibleByFloatLiteral where ValueType: ExpressibleByFloatLiteral {
    public typealias FloatLiteralType = ValueType.FloatLiteralType

    public init(floatLiteral value: FloatLiteralType) {
        self = .value(ValueType.init(floatLiteral: value))
    }
}

// MARK: - ExpressibleByArrayLiteral
private extension ExpressibleByArrayLiteral {
    init(_ elements: [ArrayLiteralElement]) {
        let castedInit = unsafeBitCast(Self.init(arrayLiteral:), to: (([ArrayLiteralElement]) -> Self).self)
        self = castedInit(elements)  // TODO: Update once splatting is supported. https://bugs.swift.org/browse/SR-128
    }
}

extension Optional: ExpressibleByArrayLiteral where Wrapped: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = Wrapped.ArrayLiteralElement

    public init(arrayLiteral elements: ArrayLiteralElement...) {
        self = .some(Wrapped.init(elements))
    }
}

extension Parameter: ExpressibleByArrayLiteral where ValueType: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = ValueType.ArrayLiteralElement

    public init(arrayLiteral elements: ArrayLiteralElement...) {
        self = .value(ValueType.init(elements))
    }
}

// MARK: - ExpressibleByDictionaryLiteral
private extension ExpressibleByDictionaryLiteral where Key: Hashable {
    init(_ elements: [(Key, Value)]) {
        let value: [Key: Value] = Dictionary.init(uniqueKeysWithValues: elements)
        self = value as! Self  // TODO: Check if can be fixed. For some reason could not use init(arayLiteral elements: ...)
    }
}

extension Optional: ExpressibleByDictionaryLiteral where Wrapped: ExpressibleByDictionaryLiteral, Wrapped.Key: Hashable {
    public typealias Key = Wrapped.Key
    public typealias Value = Wrapped.Value

    public init(dictionaryLiteral elements: (Key, Value)...) {
        self = .some(Wrapped.init(elements))
    }
}

extension Parameter: ExpressibleByDictionaryLiteral where ValueType: ExpressibleByDictionaryLiteral, ValueType.Key: Hashable {
    public typealias Key = ValueType.Key
    public typealias Value = ValueType.Value

    public init(dictionaryLiteral elements: (Key, Value)...) {
        self = .value(ValueType.init(elements))
    }
}
