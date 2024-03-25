class SubscriptRegistrar {
    var registered: [String: Int] = [:]
    var namesWithoutReturnType: [String: Int] = [:]
    var suffixes: [String: Int] = [:]

    func register(_ name: String, _ uniqueName: String) {
        let count = registered[name] ?? 0
        registered[name] = count + 1
        suffixes[uniqueName] = count + 1
    }
    func register(short name: String) {
        let count = namesWithoutReturnType[name] ?? 0
        namesWithoutReturnType[name] = count + 1
    }
}

class SubscriptWrapper {
    let wrapped: SourceryRuntime.Subscript
    var readonly: Bool { return !wrapped.isMutable }
    var wrappedParameters: [ParameterWrapper] { return wrapped.parameters.map { ParameterWrapper($0, current: current) } }
    var casesCount: Int { return readonly ? 1 : 2 }
    var nestedType: String { return "\(TypeWrapper(wrapped.returnTypeName, current: current).nestedParameter)" }
    let associatedTypes: [String]?
    let genericTypesList: [String]
    let genericTypesModifier: String?
    let whereClause: String
    var hasAvailability: Bool { wrapped.attributes["available"]?.isEmpty == false }
    let current: Current
    let subscriptRegistrar: SubscriptRegistrar

    private var methodAttributes: String {
        return Helpers.extractAttributes(from: self.wrapped.attributes, filterOutStartingWith: ["mutating", "@inlinable"])
    }
    private var methodAttributesNonObjc: String {
        return Helpers.extractAttributes(from: self.wrapped.attributes, filterOutStartingWith: ["mutating", "@inlinable", "@objc"])
    }

    private let noStubDefinedMessage = "Stub return value not specified for subscript. Use given first."

    func register() {
        subscriptRegistrar.register(registrationName("get"),uniqueName)
        subscriptRegistrar.register(short: shortName)
        guard !readonly else { return }
        subscriptRegistrar.register(registrationName("set"),uniqueName)
    }

    init(_ wrapped: SourceryRuntime.Subscript, current: Current, subscriptRegistrar: SubscriptRegistrar) {
        self.wrapped = wrapped
        self.current = current
        self.subscriptRegistrar = subscriptRegistrar
        associatedTypes = Helpers.extractAssociatedTypes(from: wrapped)
        genericTypesList = Helpers.extractGenericsList(associatedTypes)
        whereClause = Helpers.extractWhereClause(from: wrapped) ?? ""
        if let types = associatedTypes {
            genericTypesModifier = "<\(types.joined(separator: ","))>"
        } else {
            genericTypesModifier = nil
        }
    }

    func registrationName(_ accessor: String) -> String {
        return "subscript_\(accessor)_\(wrappedParameters.map({ $0.sanitizedForEnumCaseName() }).joined(separator: "_"))"
    }
    var shortName: String { return "public subscript\(genericTypesModifier ?? " ")(\(wrappedParameters.map({ $0.asMethodArgument() }).joined(separator: ", ")))" }
    var uniqueName: String { return "\(shortName) -> \(wrapped.returnTypeName)\(self.whereClause)" }

    private func nameSuffix(_ accessor: String) -> String {
        guard let count = subscriptRegistrar.registered[registrationName(accessor)] else { return "" }
        guard count > 1 else { return "" }
        guard let index = subscriptRegistrar.suffixes[uniqueName] else { return "" }
        return "_\(index)"
    }

    // call
    func subscriptCall() -> String {
        let get = "\n\t\tget {\(getter())\n\t\t}"
        let set = readonly ? "" : "\n\t\tset {\(setter())\n\t\t}"
        var attributes = self.methodAttributesNonObjc
        attributes = attributes.isEmpty ? "" : "\(attributes)\n\t"
        return "\(attributes)\(uniqueName) {\(get)\(set)\n\t}"
    }
    private func getter() -> String {
        let method = ".\(subscriptCasePrefix("get"))(\(parametersForMethodCall()))"
        let optionalReturnWorkaround = "\(wrapped.returnTypeName)".hasSuffix("?")
        let noStubDefined = (optionalReturnWorkaround || wrapped.returnTypeName.isOptional) ? "return nil" : "onFatalFailure(\"\(noStubDefinedMessage)\"); Failure(\"noStubDefinedMessage\")"
        return
            "\n\t\t\taddInvocation(\(method))" +
                "\n\t\t\tdo {" +
                "\n\t\t\t\treturn try methodReturnValue(\(method)).casted()" +
                "\n\t\t\t} catch {" +
                "\n\t\t\t\t\(noStubDefined)" +
        "\n\t\t\t}"
    }
    private func setter() -> String {
        let method = ".\(subscriptCasePrefix("set"))(\(parametersForMethodCall(set: true)))"
        return "\n\t\t\taddInvocation(\(method))"
    }

    var assertionName: String {
        return readonly ? assertionName("get") : "\(assertionName("get"))\n\t\t\t\(assertionName("set"))"
    }
    private func assertionName(_ accessor: String) -> String {
        return "case .\(subscriptCasePrefix(accessor)): return " +
            "\"[\(accessor)] `subscript`\(genericTypesModifier ?? "")[\(parametersForAssertionName())]\""
    }

    // method type
    func subscriptCasePrefix(_ accessor: String) -> String {
        return "\(registrationName(accessor))\(nameSuffix(accessor))"
    }
    func subscriptCaseName(_ accessor: String, availability: Bool = false) -> String {
        return "\(subscriptCasePrefix(accessor))(\(parametersForMethodTypeDeclaration(availability: availability, set: accessor == "set")))"
    }
    func subscriptCases() -> String {
        if readonly {
            return "case \(subscriptCaseName("get", availability: hasAvailability))"
        } else {
            return "case \(subscriptCaseName("get", availability: hasAvailability))\n\t\tcase \(subscriptCaseName("set", availability: hasAvailability))"
        }
    }
    func equalCase(_ accessor: String) -> String {
        var lhsParams = wrapped.parameters.map { "lhs\($0.name.capitalized)" }.joined(separator: ", ")
        var rhsParams = wrapped.parameters.map { "rhs\($0.name.capitalized)" }.joined(separator: ", ")
        var comparators = "\t\t\t\tvar results: [Matcher.ParameterComparisonResult] = []\n"
        comparators += wrappedParameters.map { "\t\t\t\t\($0.comparatorResult())" }.joined(separator: "\n")

        if accessor == "set" {
            lhsParams += ", lhsDidSet"
            rhsParams += ", rhsDidSet"
            comparators += "\n\t\t\t\tresults.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDidSet, rhs: rhsDidSet, with: matcher), lhsDidSet, rhsDidSet, \"newValue\"))"
        }

        comparators += "\n\t\t\t\treturn Matcher.ComparisonResult(results)"

        // comparatorResult()
        return "case (let .\(subscriptCasePrefix(accessor))(\(lhsParams)), let .\(subscriptCasePrefix(accessor))(\(rhsParams))):\n" + comparators
    }
    func equalCases() -> String {
        return readonly ? equalCase("get") : "\(equalCase("get"))\n\t\t\t\(equalCase("set"))"
    }
    func intValueCase() -> String {
        return readonly ? intValueCase("get") : "\(intValueCase("get"))\n\t\t\t\(intValueCase("set"))"
    }
    func intValueCase(_ accessor: String) -> String {
        let params = wrappedParameters.enumerated().map { offset, _ in
            return "p\(offset)"
        }
        let definitions = params.joined(separator: ", ") + (accessor == "set" ? ", _" : "")
        let paramsSum = params.map({ "\($0).intValue" }).joined(separator: " + ")
        return "case let .\(subscriptCasePrefix(accessor))(\(definitions)): return \(paramsSum)"
    }

    // Given
    func givenConstructorName() -> String {
        let returnTypeString = returnsSelf ? replaceSelf : TypeWrapper(wrapped.returnTypeName, current: current).stripped
        var attributes = self.methodAttributesNonObjc
        attributes = attributes.isEmpty ? "" : "\(attributes)\n\t\t"
        return "\(attributes)public static func `subscript`\(genericTypesModifier ?? "")(\(parametersForProxySignature()), willReturn: \(returnTypeString)...) -> SubscriptStub"
    }
    func givenConstructor() -> String {
        return "return Given(method: .\(subscriptCasePrefix("get"))(\(parametersForProxyInit())), products: willReturn.map({ StubProduct.return($0 as Any) }))"
    }

    // Verify
    func verifyConstructorName(set: Bool = false) -> String {
        let returnTypeString = returnsSelf ? replaceSelf : nestedType
        let returning = set ? "" : returningParameter(true, true)
        var attributes = self.methodAttributesNonObjc
        attributes = attributes.isEmpty ? "" : "\(attributes)\n\t\t"
        return "\(attributes)public static func `subscript`\(genericTypesModifier ?? "")(\(parametersForProxySignature())\(returning)\(set ? ", set newValue: \(returnTypeString)" : "")) -> Verify"
    }
    func verifyConstructor(set: Bool = false) -> String {
        return "return Verify(method: .\(subscriptCasePrefix(set ? "set" : "get"))(\(parametersForProxyInit(set: set))))"
    }

    // Generics
    private func getGenerics() -> [String] {
        return genericTypesList
    }

    // Helpers
    private var returnsSelf: Bool { return TypeWrapper(wrapped.returnTypeName, current: current).isSelfType }
    private var replaceSelf: String { return current.selfType }
    private func returnTypeStripped(type: Bool = false) -> String {
        let returnTypeRaw = "\(wrapped.returnTypeName)"
        var stripped: String = {
            guard let range = returnTypeRaw.range(of: "where") else { return returnTypeRaw }
            var stripped = returnTypeRaw
            stripped.removeSubrange((range.lowerBound)...)
            return stripped
        }()
        stripped = stripped.trimmingCharacters(in: CharacterSet(charactersIn: " "))
        guard type else { return stripped }
        return "(\(stripped)).Type"
    }
    private func returnTypeMatters() -> Bool {
        let count = subscriptRegistrar.namesWithoutReturnType[shortName] ?? 0
        return count > 1
    }

    // params
    private func returningParameter(_ multiple: Bool, _ front: Bool) -> String {
        guard returnTypeMatters() else { return "" }
        let returning: String = "returning: \(returnTypeStripped(type: true))"
        guard multiple else { return returning }
        return front ? ", \(returning)" : "\(returning), "
    }
    private func parametersForMethodTypeDeclaration(availability: Bool = false, set: Bool = false) -> String {
        let generics: [String] = getGenerics()
        let params = wrappedParameters.map { param in
            if param.isGeneric(generics) { return param.genericType }
            if availability { return param.typeErasedType }
            return param.nestedType
        }.joined(separator: ", ")
        guard set else { return params }
        let newValue = TypeWrapper(wrapped.returnTypeName, current: current).isGeneric(generics) ? "Parameter<GenericAttribute>" : nestedType
        return "\(params), \(newValue)"
    }
    private func parametersForProxyInit(set: Bool = false) -> String {
        let generics = getGenerics()
        let newValue = TypeWrapper(wrapped.returnTypeName, current: current).isGeneric(generics) ? "newValue.wrapAsGeneric()" : "newValue"
        return wrappedParameters.map { "\($0.wrappedForProxy(generics, hasAvailability))" }.joined(separator: ", ") + (set ? ", \(newValue)" : "")
    }
    private func parametersForProxySignature(set: Bool = false) -> String {
        return wrappedParameters.map { "\($0.labelAndName()): \($0.nestedType)" }.joined(separator: ", ") + (set ? ", set newValue: \(nestedType)" : "")
    }
    private func parametersForAssertionName() -> String {
        return wrappedParameters.map { "\($0.labelAndName())" }.joined(separator: ", ")
    }
    private func parametersForMethodCall(set: Bool = false) -> String {
        let generics = getGenerics()
        let params = wrappedParameters.map { $0.wrappedForCalls(generics, hasAvailability) }.joined(separator: ", ")
        let postfix = TypeWrapper(wrapped.returnTypeName, current: current).isGeneric(generics) ? ".wrapAsGeneric()" : ""
        return !set ? params : "\(params), \(nestedType).value(newValue)\(postfix)"
    }
}