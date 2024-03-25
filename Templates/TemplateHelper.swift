struct Current {
    var selfType: String = "Self"
    var accessModifier: String = "open"
}
// Collision management
func areThereCollisions(between methods: [MethodWrapper]) -> Bool {
    let givenSet = Set<String>(methods.map({ $0.givenConstructorName(prefix: "") }))
    guard givenSet.count == methods.count else { return true } // there would be conflicts in Given
    let verifySet = Set<String>(methods.map({ $0.verificationProxyConstructorName(prefix: "") }))
    guard verifySet.count == methods.count else { return true } // there would be conflicts in Verify
    return false
}

// herlpers
func uniques(methods: [SourceryRuntime.Method]) -> [SourceryRuntime.Method] {
    func returnTypeStripped(_ method: SourceryRuntime.Method) -> String {
        let returnTypeRaw = "\(method.returnTypeName)"
        var stripped: String = {
            guard let range = returnTypeRaw.range(of: "where") else { return returnTypeRaw }
            var stripped = returnTypeRaw
            stripped.removeSubrange((range.lowerBound)...)
            return stripped
        }()
        stripped = stripped.trimmingCharacters(in: CharacterSet(charactersIn: " "))
        return stripped
    }

    func areSameParams(_ p1: SourceryRuntime.MethodParameter, _ p2: SourceryRuntime.MethodParameter) -> Bool {
        guard p1.argumentLabel == p2.argumentLabel else { return false }
        guard p1.name == p2.name else { return false }
        guard p1.argumentLabel == p2.argumentLabel else { return false }
        guard p1.typeName.name == p2.typeName.name else { return false }
        guard p1.actualTypeName?.name == p2.actualTypeName?.name else { return false }
        return true
    }

    func areSameMethods(_ m1: SourceryRuntime.Method, _ m2: SourceryRuntime.Method) -> Bool {
        guard m1.name != m2.name else { return m1.returnTypeName == m2.returnTypeName }
        guard m1.selectorName == m2.selectorName else { return false }
        guard m1.parameters.count == m2.parameters.count else { return false }

        let p1 = m1.parameters
        let p2 = m2.parameters

        for i in 0..<p1.count {
            if !areSameParams(p1[i],p2[i]) { return false }
        }

        return m1.returnTypeName == m2.returnTypeName
    }

    return methods.reduce([], { (result, element) -> [SourceryRuntime.Method] in
        guard !result.contains(where: { areSameMethods($0,element) }) else { return result }
        return result + [element]
    })
}

func uniquesWithoutGenericConstraints(methods: [SourceryRuntime.Method]) -> [SourceryRuntime.Method] {
    func returnTypeStripped(_ method: SourceryRuntime.Method) -> String {
        let returnTypeRaw = "\(method.returnTypeName)"
        var stripped: String = {
            guard let range = returnTypeRaw.range(of: "where") else { return returnTypeRaw }
            var stripped = returnTypeRaw
            stripped.removeSubrange((range.lowerBound)...)
            return stripped
        }()
        stripped = stripped.trimmingCharacters(in: CharacterSet(charactersIn: " "))
        return stripped
    }

    func areSameParams(_ p1: SourceryRuntime.MethodParameter, _ p2: SourceryRuntime.MethodParameter) -> Bool {
        guard p1.argumentLabel == p2.argumentLabel else { return false }
        guard p1.name == p2.name else { return false }
        guard p1.argumentLabel == p2.argumentLabel else { return false }
        guard p1.typeName.name == p2.typeName.name else { return false }
        guard p1.actualTypeName?.name == p2.actualTypeName?.name else { return false }
        return true
    }

    func areSameMethods(_ m1: SourceryRuntime.Method, _ m2: SourceryRuntime.Method) -> Bool {
        guard m1.name != m2.name else { return returnTypeStripped(m1) == returnTypeStripped(m2) }
        guard m1.selectorName == m2.selectorName else { return false }
        guard m1.parameters.count == m2.parameters.count else { return false }

        let p1 = m1.parameters
        let p2 = m2.parameters

        for i in 0..<p1.count {
            if !areSameParams(p1[i],p2[i]) { return false }
        }

        return returnTypeStripped(m1) == returnTypeStripped(m2)
    }

    return methods.reduce([], { (result, element) -> [SourceryRuntime.Method] in
        guard !result.contains(where: { areSameMethods($0,element) }) else { return result }
        return result + [element]
    })
}

func uniques(variables: [SourceryRuntime.Variable]) -> [SourceryRuntime.Variable] {
    return variables.reduce([], { (result, element) -> [SourceryRuntime.Variable] in
        guard !result.contains(where: { $0.name == element.name }) else { return result }
        return result + [element]
    })
}

func wrapMethod(_ method: SourceryRuntime.Method, current: Current, methodRegistrar: MethodRegistrar) -> MethodWrapper {
    return MethodWrapper(method, current: current, methodRegistrar: methodRegistrar)
}

func wrapSubscript(_ wrapped: SourceryRuntime.Subscript, current: Current, subscriptRegistrar: SubscriptRegistrar) -> SubscriptWrapper {
    return SubscriptWrapper(wrapped, current: current, subscriptRegistrar: subscriptRegistrar)
}

func justWrap(_ variable: SourceryRuntime.Variable, current: Current) -> VariableWrapper { return wrapProperty(variable, current: current) }
func wrapProperty(_ variable: SourceryRuntime.Variable, _ scope: String = "", current: Current) -> VariableWrapper {
    return VariableWrapper(variable, scope: scope, current: current)
}

func stubProperty(_ variable: SourceryRuntime.Variable, _ scope: String, current: Current) -> String {
    let wrapper = VariableWrapper(variable, scope: scope, current: current)
    return "\(wrapper.prototype)\n\t\(wrapper.privatePrototype)"
}

func propertyTypes(_ variable: SourceryRuntime.Variable, current: Current) -> String {
    let wrapper = VariableWrapper(variable, scope: "scope", current: current)
    return "\(wrapper.propertyGet())" + (wrapper.readonly ? "" : "\n\t\t\(wrapper.propertySet())")
}

func propertyMethodTypes(_ variable: SourceryRuntime.Variable, current: Current) -> String {
    let wrapper = VariableWrapper(variable, scope: "", current: current)
    return "\(wrapper.propertyCaseGet())" + (wrapper.readonly ? "" : "\n\t\t\(wrapper.propertyCaseSet())")
}

func propertyMethodTypesIntValue(_ variable: SourceryRuntime.Variable, current: Current) -> String {
    let wrapper = VariableWrapper(variable, scope: "", current: current)
    return "\(wrapper.propertyCaseGetIntValue())" + (wrapper.readonly ? "" : "\n\t\t\t\(wrapper.propertyCaseSetIntValue())")
}

func propertyRegister(_ variable: SourceryRuntime.Variable, methodRegistrar: MethodRegistrar, current: Current) {
    let wrapper = VariableWrapper(variable, scope: "", current: current)
    methodRegistrar.register(wrapper.propertyCaseGetName,wrapper.propertyCaseGetName,wrapper.propertyCaseGetName)
    guard !wrapper.readonly else { return }
    methodRegistrar.register(wrapper.propertyCaseSetName,wrapper.propertyCaseSetName,wrapper.propertyCaseGetName)
}