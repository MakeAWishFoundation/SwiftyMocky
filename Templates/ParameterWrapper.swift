class ParameterWrapper {
    let parameter: MethodParameter

    var wrappedForCall: String {
        let typeString = "\(type.actualTypeName ?? type)"
        let isEscaping = typeString.contains("@escaping")
        let isOptional = (type.actualTypeName ?? type).isOptional
        if parameter.isClosure && !isEscaping && !isOptional {
            return "\(nestedType).any"
        } else {
            return "\(nestedType).value(\(escapedName))"
        }
    }
    var wrappedType: String {
        return "Parameter<\(TypeWrapper(type).stripped)>"
    }
    var nestedType: String {
        return "\(TypeWrapper(type).nestedParameter)"
    }
    var justType: String {
        return "\(TypeWrapper(type).replacingSelf())"
    }
    var justPerformType: String {
        return "\(TypeWrapper(type).replacingSelf())".replacingOccurrences(of: "!", with: "?")
    }
    var genericType: String {
        return "Parameter<GenericAttribute>"
    }
    var type: SourceryRuntime.TypeName {
        return parameter.typeName
    }
    var name: String {
        return parameter.name
    }
    var escapedName: String {
        return "`\(parameter.name)`"
    }
    var comparator: String {
        return "guard Parameter.compare(lhs: lhs\(parameter.name.capitalized), rhs: rhs\(parameter.name.capitalized), with: matcher) else { return false }"
    }

    init(_ parameter: SourceryRuntime.MethodParameter) {
        self.parameter = parameter
    }

    func isGeneric(_ types: [String]) -> Bool {
        return TypeWrapper(type).isGeneric(types)
    }

    func wrappedForProxy(_ generics: [String]) -> String {
        return isGeneric(generics) ? "\(escapedName).wrapAsGeneric()" : "\(escapedName)"
    }
    func wrappedForCalls(_ generics: [String]) -> String {
        return isGeneric(generics) ? "\(wrappedForCall).wrapAsGeneric()" : "\(wrappedForCall)"
    }

    func asMethodArgument() -> String {
        return "\(parameter.argumentLabel ?? "_") \(parameter.name): \(parameter.typeName)"
    }
    func labelAndName() -> String {
        let label = parameter.argumentLabel ?? "_"
        return label != "\(parameter.name)" ? "\(label) \(parameter.name)" : label
    }
    func sanitizedForEnumCaseName() -> String {
        if let label = parameter.argumentLabel {
            return "\(label)_\(parameter.name)".replacingOccurrences(of: "`", with: "")
        } else {
            return "\(parameter.name)".replacingOccurrences(of: "`", with: "")
        }
    }
}
