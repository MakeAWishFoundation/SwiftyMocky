func swiftLintRules(_ arguments: [String: Any]) -> [String] {
    return stringArray(fromArguments: arguments, forKey: "excludedSwiftLintRules").map { rule in
        return "//swiftlint:disable \(rule)"
    }
}

func projectImports(_ arguments: [String: Any]) -> [String] {
    return imports(arguments) + testableImports(arguments)
}

func imports(_ arguments: [String: Any]) -> [String] {
    return stringArray(fromArguments: arguments, forKey: "import")
        .map { return "import \($0)" }
}

func testableImports(_ arguments: [String: Any]) -> [String] {
    return stringArray(fromArguments: arguments, forKey: "testable")
        .map { return "@testable import \($0)" }
}

/// [Internal] Get value from dictionary
/// - Parameters:
///   - fromArguments: dictionary
///   - forKey: dictionary key
/// - Returns: array of strings, if key not found, returns empty array.
/// - Note: If sourcery arguments containts only one element, then single value is stored, otherwise array of elements. This method always gets array of elements.
func stringArray(fromArguments arguments: [String: Any], forKey key: String) -> [String] {

    if let argument = arguments[key] as? String {
        return [argument]
    } else if let manyArguments = arguments[key] as? [String] {
        return manyArguments
    } else {
        return []
    }
}
