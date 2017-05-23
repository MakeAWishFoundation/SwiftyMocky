//
//  AutoValue.swift
//  Pods
//
//  Created by przemyslaw.wosko on 23/05/2017.
//
//

import Foundation


public protocol AutoValue {}

public extension AutoValue {
    
    public var returnValue: Any? {
        get {
            let mirror = Mirror(reflecting: self)
            if let associated = mirror.children.first {
                return associated.value
            }
            assertionFailure("This case: \(self) has no value associated!")
            return nil
        }
    }
}
