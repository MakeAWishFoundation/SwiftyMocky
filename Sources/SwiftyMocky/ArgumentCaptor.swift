public class ArgumentCaptor<Type> {
	/// Last captured value (if any)
	public var value: Type? {
		return allValues.last
	}
	/// All captured values
	public private(set) var allValues = [Type]()

	public init() {}

	/// Return parameter matcher which captures the argument.
	public func capture(where matches: ((Type) -> Bool)? = nil) -> Parameter<Type> {
		return .matching({ (value: Type) -> Bool in
			if let matchFunction = matches {
				let match = matchFunction(value)
				if match {
					self.allValues.append(value)
				}
				return match
			}
			self.allValues.append(value)
			return true
		})
	}
}
