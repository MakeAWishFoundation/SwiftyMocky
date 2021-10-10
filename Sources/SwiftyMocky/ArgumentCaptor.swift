import Foundation

public class ArgumentCaptor<ValueType> {
	/// Last captured value (if any)
	public var value: ValueType? {
		return allValues.last
	}
	/// All captured values
	public private(set) var allValues = [ValueType]()

	public init() {}

	/// Return parameter matcher which captures the argument.
	public func capture(where matches: ((ValueType) -> Bool)? = nil) -> Parameter<ValueType> {
		return .matching { (value: ValueType) -> Bool in
			if let matchFunction = matches {
				let match = matchFunction(value)
				if match {
					self.allValues.append(value)
				}
				return match
			}
			self.allValues.append(value)
			return true
		}
	}
}
