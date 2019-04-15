//
//  ArgumentCaptor.swift
//  Pods
//
//  Created by TimeDelta on 15/04/2019.
//
//

public class ArgumentCaptor<Type> {
	/// Last captured value (if any)
	public var value: Type? {
		return allValues.last
	}
	/// All captured values
	public private(set) var allValues = [Type]()

	public init() {}

	/// Return parameter matcher which captures the argument.
	public func capture() -> Parameter<Type> {
		return .matching({ (value: Type) -> Bool in
			self.allValues.append(value)
			return true
		})
	}
}
