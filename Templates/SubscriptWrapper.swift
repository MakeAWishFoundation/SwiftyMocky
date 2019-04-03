class SubscriptWrapper {
    let wrapped: SourceryRuntime.Subscript
    var readonly: Bool { return !wrapped.isMutable }
    var wrappedParameters: [ParameterWrapper] { return wrapped.parameters.map { ParameterWrapper($0) } }
    var casesCount: Int { return readonly ? 1 : 2 }
    var nestedType: String { return "\(TypeWrapper(wrapped.returnTypeName).nestedParameter)" }
    let associatedTypes: [String]?
    let genericTypesList: [String]
    let genericTypesModifier: String?

    private let noStubDefinedMessage = "Stub return value not specified for subscript. Use given first."

    private static var registered: [String: Int] = [:]
    private static var namesWithoutReturnType: [String: Int] = [:]
    private static var suffixes: [String: Int] = [:]
    public static func clear() -> String {
        SubscriptWrapper.registered = [:]
        SubscriptWrapper.suffixes = [:]
        return ""
    }
    static func register(_ name: String, _ uniqueName: String) {
        let count = SubscriptWrapper.registered[name] ?? 0
        SubscriptWrapper.registered[name] = count + 1
        SubscriptWrapper.suffixes[uniqueName] = count + 1
    }
    static func register(short name: String) {
        let count = SubscriptWrapper.namesWithoutReturnType[name] ?? 0
        SubscriptWrapper.namesWithoutReturnType[name] = count + 1
    }

    func register() {
        SubscriptWrapper.register(registrationName("get"),uniqueName)
        SubscriptWrapper.register(short: shortName)
        guard !readonly else { return }
        SubscriptWrapper.register(registrationName("set"),uniqueName)
    }

    init(_ wrapped: SourceryRuntime.Subscript) {
        self.wrapped = wrapped
        associatedTypes = Helpers.extractAssociatedTypes(from: wrapped)
        genericTypesList = Helpers.extractGenericsList(associatedTypes)
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
    var uniqueName: String { return "\(shortName) -> \(wrapped.returnTypeName)" }

    private func nameSuffix(_ accessor: String) -> String {
        guard let count = SubscriptWrapper.registered[registrationName(accessor)] else { return "" }
        guard count > 1 else { return "" }
        guard let index = SubscriptWrapper.suffixes[uniqueName] else { return "" }
        return "_\(index)"
    }

    // call
    func subscriptCall() -> String {
        let get = "\n\t\tget {\(getter())\n\t\t}"
        let set = readonly ? "" : "\n\t\tset {\(setter())\n\t\t}"
        return "\(uniqueName) {\(get)\(set)\n\t}"
    }
    private func getter() -> String {
        let method = ".\(subscriptCasePrefix("get"))(\(parametersForMethodCall()))"
        let noStubDefined = wrapped.returnTypeName.isOptional ? "return nil" : "onFatalFailure(\"\(noStubDefinedMessage)\"); Failure(\"noStubDefinedMessage\")"
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

    // method type
    func subscriptCasePrefix(_ accessor: String) -> String {
        return "\(registrationName(accessor))\(nameSuffix(accessor))"
    }
    func subscriptCaseName(_ accessor: String) -> String {
        return "\(subscriptCasePrefix(accessor))(\(parametersForMethodTypeDeclaration(set: accessor == "set")))"
    }
    func subscriptCases() -> String {
        return readonly ? "case \(subscriptCaseName("get"))" : "case \(subscriptCaseName("get"))\n\t\tcase \(subscriptCaseName("set"))"
    }
    func equalCase(_ accessor: String) -> String {
        var lhsParams = wrapped.parameters.map { "lhs\($0.name.capitalized)" }.joined(separator: ", ")
        var rhsParams = wrapped.parameters.map { "rhs\($0.name.capitalized)" }.joined(separator: ", ")
        var comparators = wrappedParameters.map { "\t\t\t\t\($0.comparator)" }.joined(separator: "\n")
        if accessor == "set" {
            lhsParams += ", lhsDidSet"
            rhsParams += ", rhsDidSet"
            comparators += "\n\t\t\t\treturn Parameter.compare(lhs: lhsDidSet, rhs: rhsDidSet, with: matcher)"
        } else {
            comparators += "\n\t\t\t\treturn true"
        }
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
        let returnTypeString = returnsSelf ? replaceSelf : TypeWrapper(wrapped.returnTypeName).stripped
        return "public static func `subscript`\(genericTypesModifier ?? "")(\(parametersForProxySignature()), willReturn: \(returnTypeString)...) -> SubscriptStub"
    }
    func givenConstructor() -> String {
        return "return Given(method: .\(subscriptCasePrefix("get"))(\(parametersForProxyInit())), products: willReturn.map({ StubProduct.return($0 as Any) }))"
    }

    // Verify
    func verifyConstructorName(set: Bool = false) -> String {
        let returnTypeString = returnsSelf ? replaceSelf : nestedType
        let returning = set ? "" : returningParameter(true, true)
        return "public static func `subscript`\(genericTypesModifier ?? "")(\(parametersForProxySignature())\(returning)\(set ? ", set newValue: \(returnTypeString)" : "")) -> Verify"
    }
    func verifyConstructor(set: Bool = false) -> String {
        return "return Verify(method: .\(subscriptCasePrefix(set ? "set" : "get"))(\(parametersForProxyInit(set: set))))"
    }

    // Generics
    private func getGenerics() -> [String] {
        return genericTypesList
    }

    // Helpers
    private var returnsSelf: Bool { return TypeWrapper(wrapped.returnTypeName).isSelfType }
    private var replaceSelf: String { return Current.selfType }
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
        let count = SubscriptWrapper.namesWithoutReturnType[shortName] ?? 0
        return count > 1
    }

    // params
    private func returningParameter(_ multiple: Bool, _ front: Bool) -> String {
        guard returnTypeMatters() else { return "" }
        let returning: String = "returning: \(returnTypeStripped(type: true))"
        guard multiple else { return returning }
        return front ? ", \(returning)" : "\(returning), "
    }
    private func parametersForMethodTypeDeclaration(set: Bool = false) -> String {
        let generics: [String] = getGenerics()
        let params = wrappedParameters.map { param in
            return param.isGeneric(generics) ? param.genericType : param.nestedType
            }.joined(separator: ", ")
        guard set else { return params }
        let newValue = TypeWrapper(wrapped.returnTypeName).isGeneric(generics) ? "Parameter<GenericAttribute>" : nestedType
        return "\(params), \(newValue)"
    }
    private func parametersForProxyInit(set: Bool = false) -> String {
        let generics = getGenerics()
        let newValue = TypeWrapper(wrapped.returnTypeName).isGeneric(generics) ? "newValue.wrapAsGeneric()" : "newValue"
        return wrappedParameters.map { "\($0.wrappedForProxy(generics))" }.joined(separator: ", ") + (set ? ", \(newValue)" : "")
    }
    private func parametersForProxySignature(set: Bool = false) -> String {
        return wrappedParameters.map { "\($0.labelAndName()): \($0.nestedType)" }.joined(separator: ", ") + (set ? ", set newValue: \(nestedType)" : "")
    }
    private func parametersForMethodCall(set: Bool = false) -> String {
        let generics = getGenerics()
        let params = wrappedParameters.map { $0.wrappedForCalls(generics) }.joined(separator: ", ")
        let postfix = TypeWrapper(wrapped.returnTypeName).isGeneric(generics) ? ".wrapAsGeneric()" : ""
        return !set ? params : "\(params), \(nestedType).value(newValue)\(postfix)"
    }
}
