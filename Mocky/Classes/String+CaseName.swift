//
//  String+CaseName.swift
//  Pods
//
//  Created by przemyslaw.wosko on 19/05/2017.
//
//

import Foundation

public extension String {
    
    public init<Subject>(caseName subject: Subject){
        var raw = String(reflecting: subject)
        if let dotRange = raw.range(of: "(") {
            raw.removeSubrange(dotRange.lowerBound ..< raw.endIndex)
        }
        if let last = raw.components(separatedBy: ".").last {
            raw = last
        }
        self = raw
    }
}
