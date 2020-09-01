class VariableWrapper {
    let variable: SourceryRuntime.Variable
    let scope: String
    var readonly: Bool { return variable.writeAccess.isEmpty }
    var privatePrototypeName: String { return "__p_\(variable.name)".replacingOccurrences(of: "`", with: "") }
    var casesCount: Int { return readonly ? 1 : 2 }

    var accessModifier: String {
        // TODO: Fix access levels for SwiftyPrototype
        // guard variable.type?.accessLevel != "internal" else { return "" }
        return "public "
    }
    var attributes: String {
        let value = Helpers.extractAttributes(from: self.variable.attributes)
        return value.isEmpty ? "\(accessModifier)" : "\(value)\n\t\t\(accessModifier)"
    }
    var noStubDefinedMessage: String { return "\(scope) - stub value for \(variable.name) was not defined" }

    var getter: String {
        let staticModifier = variable.isStatic ? "\(scope)." : ""
        let returnValue = variable.isOptional ? "optionalGivenGetterValue(.\(propertyCaseGetName), \"\(noStubDefinedMessage)\")" : "givenGetterValue(.\(propertyCaseGetName), \"\(noStubDefinedMessage)\")"
        return "\n\t\tget {\t\(staticModifier)invocations.append(.\(propertyCaseGetName)); return \(staticModifier)\(privatePrototypeName) ?? \(returnValue) }"
    }
    var setter: String {
        let staticModifier = variable.isStatic ? "\(scope)." : ""
        if readonly {
            return ""
        } else {
            return "\n\t\tset {\t\(staticModifier)invocations.append(.\(propertyCaseSetName)(.value(newValue))); \(variable.isStatic ? "\(scope)." : "")\(privatePrototypeName) = newValue }"
        }
    }
    var prototype: String {
        let staticModifier = variable.isStatic ? "static " : ""

        return "\(attributes)\(staticModifier)var \(variable.name): \(variable.typeName.name) {" +
            "\(getter)" +
            "\(setter)" +
        "\n\t}"
    }
    var assertionName: String {
        var result = "case .\(propertyCaseGetName): return \"[get] .\(variable.name)\""
        if !readonly {
            result += "\n\t\t\tcase .\(propertyCaseSetName): return \"[set] .\(variable.name)\""
        }
        return result
    }

    var privatePrototype: String {
        let staticModifier = variable.isStatic ? "static " : ""
        return "private \(staticModifier)var \(privatePrototypeName): (\(variable.typeName.unwrappedTypeName))?"
    }
    var nestedType: String { return "\(TypeWrapper(variable.typeName).nestedParameter)" }

    init(_ variable: SourceryRuntime.Variable, scope: String) {
        self.variable = variable
        self.scope = scope
    }

    func compareCases() -> String {
        var result =  propertyCaseGetCompare()
        if !readonly {
            result += "\n\t\t\t\(propertyCaseSetCompare())"
        }
        return result
    }

    func propertyGet() -> String {
        let staticModifier = variable.isStatic ? "Static" : ""
        return "public static var \(variable.name): \(staticModifier)Verify { return \(staticModifier)Verify(method: .\(propertyCaseGetName)) }"
    }

    func propertySet() -> String {
        let staticModifier = variable.isStatic ? "Static" : ""
        return "public static func \(variable.name)(set newValue: \(nestedType)) -> \(staticModifier)Verify { return \(staticModifier)Verify(method: .\(propertyCaseSetName)(newValue)) }"
    }

    var propertyCaseGetName: String { return "p_\(variable.name)_get".replacingOccurrences(of: "`", with: "") }
    func propertyCaseGet() -> String {
        return "case \(propertyCaseGetName)"
    }
    func propertyCaseGetCompare() -> String {
        return "case (.\(propertyCaseGetName),.\(propertyCaseGetName)): return Matcher.ComparisonResult.match"
    }
    func propertyCaseGetIntValue() -> String {
        return "case .\(propertyCaseGetName): return 0"
    }

    var propertyCaseSetName: String { return "p_\(variable.name)_set".replacingOccurrences(of: "`", with: "") }
    func propertyCaseSet() -> String {
        return "case \(propertyCaseSetName)(\(nestedType))"
    }
    func propertyCaseSetCompare() -> String {
        let lhsName = "left"
        let rhsName = "right"
        let comaprison = "Matcher.ParameterComparisonResult(\(nestedType).compare(lhs: \(lhsName), rhs: \(rhsName), with: matcher), \(lhsName), \(rhsName), \"newValue\")"
        let result = "Matcher.ComparisonResult([\(comaprison)])"
        return "case (.\(propertyCaseSetName)(let left),.\(propertyCaseSetName)(let right)): return \(result)"
    }
    func propertyCaseSetIntValue() -> String {
        return "case .\(propertyCaseSetName)(let newValue): return newValue.intValue"
    }

    // Given
    func givenConstructorName(prefix: String = "") -> String {
        return "\(attributes)static func \(variable.name)(getter defaultValue: \(TypeWrapper(variable.typeName).stripped)...) -> \(prefix)PropertyStub"
    }

    func givenConstructor(prefix: String = "") -> String {
        return "return \(prefix)Given(method: .\(propertyCaseGetName), products: defaultValue.map({ StubProduct.return($0 as Any) }))"
    }
}
