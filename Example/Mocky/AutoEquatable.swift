//
//  AutoEquatable.swift
//  Mocky
//
//  Created by przemyslaw.wosko on 19/05/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation


// Dummy protocol, thats servs as markup for Stencil to generate Equatable conformance
// Everything that is Equatable should be marked with AutoEquatable, implementation is stored in AutoEquatable.generated.swift 
// This also allows to compare values passed as parameters in unit testing verify process
protocol AutoEquatable {}
