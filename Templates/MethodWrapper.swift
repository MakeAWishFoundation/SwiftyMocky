func replacingSelf(_ value: String, current: Current) -> String {
    return value
        // TODO: proper regex here
        // default < case >
        .replacingOccurrences(of: "<Self>", with: "<\(current.selfType)>")
        .replacingOccurrences(of: "<Self ", with: "<\(current.selfType) ")
        .replacingOccurrences(of: "<Self.", with: "<\(current.selfType).")
        .replacingOccurrences(of: "<Self,", with: "<\(current.selfType),")
        .replacingOccurrences(of: "<Self?", with: "<\(current.selfType)?")
        .replacingOccurrences(of: " Self>", with: " \(current.selfType)>")
        .replacingOccurrences(of: ",Self>", with: ",\(current.selfType)>")
        // (Self) -> Case
        .replacingOccurrences(of: "(Self)", with: "(\(current.selfType))")
        .replacingOccurrences(of: "(Self ", with: "(\(current.selfType) ")
        .replacingOccurrences(of: "(Self.", with: "(\(current.selfType).")
        .replacingOccurrences(of: "(Self,", with: "(\(current.selfType),")
        .replacingOccurrences(of: "(Self?", with: "(\(current.selfType)?")
        .replacingOccurrences(of: " Self)", with: " \(current.selfType))")
        .replacingOccurrences(of: ",Self)", with: ",\(current.selfType))")
        // literals
        .replacingOccurrences(of: "[Self]", with: "[\(current.selfType)]")
        // right
        .replacingOccurrences(of: "[Self ", with: "[\(current.selfType) ")
        .replacingOccurrences(of: "[Self.", with: "[\(current.selfType).")
        .replacingOccurrences(of: "[Self,", with: "[\(current.selfType),")
        .replacingOccurrences(of: "[Self:", with: "[\(current.selfType):")
        .replacingOccurrences(of: "[Self?", with: "[\(current.selfType)?")
        // left
        .replacingOccurrences(of: " Self]", with: " \(current.selfType)]")
        .replacingOccurrences(of: ",Self]", with: ",\(current.selfType)]")
        .replacingOccurrences(of: ":Self]", with: ":\(current.selfType)]")
        // unknown
        .replacingOccurrences(of: " Self ", with: " \(current.selfType) ")
        .replacingOccurrences(of: " Self.", with: " \(current.selfType).")
        .replacingOccurrences(of: " Self,", with: " \(current.selfType),")
        .replacingOccurrences(of: " Self:", with: " \(current.selfType):")
        .replacingOccurrences(of: " Self?", with: " \(current.selfType)?")
        .replacingOccurrences(of: ",Self ", with: ",\(current.selfType) ")
        .replacingOccurrences(of: ",Self,", with: ",\(current.selfType),")
        .replacingOccurrences(of: ",Self?", with: ",\(current.selfType)?")
}

class MethodRegistrar {
    var registered: [String: Int] = [:]
    var suffixes: [String: Int] = [:]
    var suffixesWithoutReturnType: [String: Int] = [:]

    func register(_ name: String, _ uniqueName: String, _ uniqueNameWithReturnType: String) {
        if let count = registered[name] {
            registered[name] = count + 1
            suffixes[uniqueNameWithReturnType] = count + 1
        } else {
            registered[name] = 1
            suffixes[uniqueNameWithReturnType] = 1
        }

        if let count = suffixesWithoutReturnType[uniqueName] {
            suffixesWithoutReturnType[uniqueName] = count + 1
        } else {
            suffixesWithoutReturnType[uniqueName] = 1
        }
    }

    func returnTypeMatters(uniqueName: String) -> Bool {
        let count = suffixesWithoutReturnType[uniqueName] ?? 0
        return count > 1
    }
}

class MethodWrapper {
    private var noStubDefinedMessage: String {
        let methodName = method.name.condenseWhitespace()
            .replacingOccurrences(of: "( ", with: "(")
            .replacingOccurrences(of: " )", with: ")")
        return "Stub return value not specified for \(methodName). Use given"
    }

    let method: SourceryRuntime.Method
    var accessModifier: String {
        guard !method.isStatic else { return "public static" }
        guard !returnsGenericConstrainedToSelf else { return "public" }
        guard !parametersContainsSelf else { return "public" }
        return current.accessModifier
    }
    var hasAvailability: Bool { method.attributes["available"]?.isEmpty == false }
    var isAsync: Bool {
        self.method.annotations["async"] != nil
    }

    private var registrationName: String {
        var rawName = (method.isStatic ? "sm*\(method.selectorName)" : "m*\(method.selectorName)")
        .replacingOccurrences(of: "_", with: "")
        .replacingOccurrences(of: "(", with: "__")
        .replacingOccurrences(of: ")", with: "")

        var parametersNames = method.parameters.map { "\($0.name)" }

        while let range = rawName.range(of: ":"), let name = parametersNames.first {
            parametersNames.removeFirst()
            rawName.replaceSubrange(range, with: "_\(name)")
        }

        let trimSet = CharacterSet(charactersIn: "_")

        return  rawName
        .replacingOccurrences(of: ":", with: "")
        .replacingOccurrences(of: "m*", with: "m_")
        .replacingOccurrences(of: "___", with: "__").trimmingCharacters(in: trimSet)
    }
    private var uniqueName: String {
        var rawName = (method.isStatic ? "sm_\(method.selectorName)" : "m_\(method.selectorName)")
        var parametersNames = method.parameters.map { "\($0.name)_of_\($0.typeName.name)" }

        while let range = rawName.range(of: ":"), let name = parametersNames.first {
            parametersNames.removeFirst()
            rawName.replaceSubrange(range, with: "_\(name)")
        }

        return rawName.trimmingCharacters(in: CharacterSet(charactersIn: "_"))
    }
    private var uniqueNameWithReturnType: String {
        let returnTypeRaw = "\(method.returnTypeName)"
        var returnTypeStripped: String = {
            guard let range = returnTypeRaw.range(of: "where") else { return returnTypeRaw }
            var stripped = returnTypeRaw
            stripped.removeSubrange((range.lowerBound)...)
            return stripped
        }()
        returnTypeStripped = returnTypeStripped.trimmingCharacters(in: CharacterSet(charactersIn: " "))
        return "\(uniqueName)->\(returnTypeStripped)"
    }
    private var nameSuffix: String {
        guard let count = methodRegistrar.registered[registrationName] else { return "" }
        guard count > 1 else { return "" }
        guard let index = methodRegistrar.suffixes[uniqueNameWithReturnType] else { return "" }
        return "_\(index)"
    }
    private var methodAttributes: String {
        return Helpers.extractAttributes(from: self.method.attributes, filterOutStartingWith: ["mutating", "@inlinable"])
    }
    private var methodAttributesNonObjc: String {
        return Helpers.extractAttributes(from: self.method.attributes, filterOutStartingWith: ["mutating", "@inlinable", "@objc"])
    }

    var prototype: String {
        return "\(registrationName)\(nameSuffix)".replacingOccurrences(of: "`", with: "")
    }
    var parameters: [ParameterWrapper] {
        return filteredParameters.map { ParameterWrapper($0, self.getVariadicParametersNames(), current: current) }
    }
    var filteredParameters: [MethodParameter] {
        return method.parameters.filter { $0.name != "" }
    }
    var functionPrototype: String {
        let throwing: String = {
            if method.throws {
                return "throws "
            } else if method.rethrows {
                return "rethrows "
            } else {
                return ""
            }
        }()

        let staticModifier: String = "\(accessModifier) "
        let params = replacingSelf(parametersForStubSignature(), current: current)
        var attributes = self.methodAttributes
        attributes = attributes.isEmpty ? "" : "\(attributes)\n\t"
        var asyncModifier = self.isAsync ? "async " : ""

        if method.isInitializer {
            return "\(attributes)public required \(method.name) \(asyncModifier)\(throwing)"
        } else if method.returnTypeName.isVoid {
            let wherePartIfNeeded: String = {
                if method.returnTypeName.name.hasPrefix("Void") {
                    let range = method.returnTypeName.name.range(of: "Void")!
                    return "\(method.returnTypeName.name[range.upperBound...])"
                } else {
                    return !method.returnTypeName.name.isEmpty ? "\(method.returnTypeName.name) " : ""
                }
            }()
            return "\(attributes)\(staticModifier)func \(method.shortName)\(params) \(asyncModifier)\(throwing)\(wherePartIfNeeded)"
        } else if returnsGenericConstrainedToSelf {
            return "\(attributes)\(staticModifier)func \(method.shortName)\(params) \(asyncModifier)\(throwing)-> \(returnTypeReplacingSelf) "
        } else {
            return "\(attributes)\(staticModifier)func \(method.shortName)\(params) \(asyncModifier)\(throwing)-> \(method.returnTypeName.name) "
        }
    }
    var invocation: String {
        guard !method.isInitializer else { return "" }
        if filteredParameters.isEmpty {
            return "addInvocation(.\(prototype))"
        } else {
            return "addInvocation(.\(prototype)(\(parametersForMethodCall())))"
        }
    }
    var givenValue: String {
        guard !method.isInitializer else { return "" }
        guard method.throws || !method.returnTypeName.isVoid else { return "" }

        let methodType = filteredParameters.isEmpty ? ".\(prototype)" : ".\(prototype)(\(parametersForMethodCall()))"
        let returnType: String = returnsSelf ? "__Self__" : "\(TypeWrapper(method.returnTypeName, current: current).stripped)"

        if method.returnTypeName.isVoid {
            return """
            \n\t\tdo {
            \t\t    _ = try methodReturnValue(\(methodType)).casted() as Void
            \t\t}\(" ")
            """
        } else {
            let defaultValue = method.returnTypeName.isOptional ? " = nil" : ""
            return """
            \n\t\tvar __value: \(returnType)\(defaultValue)
            \t\tdo {
            \t\t    __value = try methodReturnValue(\(methodType)).casted()
            \t\t}\(" ")
            """
        }
    }
    var throwValue: String {
        guard !method.isInitializer else { return "" }
        guard method.throws || !method.returnTypeName.isVoid else { return "" }
        let safeFailure = method.isStatic ? "" : "\t\t\tonFatalFailure(\"\(noStubDefinedMessage)\")\n"
        // For Void and Returning optionals - we allow not stubbed case to happen, as we are still able to return
        let noStubHandling = method.returnTypeName.isVoid || method.returnTypeName.isOptional ? "\t\t\t// do nothing" : "\(safeFailure)\t\t\tFailure(\"\(noStubDefinedMessage)\")"
        guard method.throws else {
            return """
            catch {
            \(noStubHandling)
            \t\t}
            """
        }

        return """
        catch MockError.notStubed {
        \(noStubHandling)
        \t\t} catch {
        \t\t    throw error
        \t\t}
        """
    }
    var returnValue: String {
        guard !method.isInitializer else { return "" }
        guard !method.returnTypeName.isVoid else { return "" }

        return "\n\t\treturn __value"
    }
    var equalCase: String {
        guard !method.isInitializer else { return "" }

        if filteredParameters.isEmpty {
            return "case (.\(prototype), .\(prototype)):"
        } else {
            let lhsParams = filteredParameters.map { "let lhs\($0.name.capitalized)" }.joined(separator: ", ")
            let rhsParams = filteredParameters.map { "let rhs\($0.name.capitalized)" }.joined(separator: ", ")
            return "case (.\(prototype)(\(lhsParams)), .\(prototype)(\(rhsParams))):"
        }
    }
    func equalCases() -> String {
        var results = self.equalCase

        guard !parameters.isEmpty else {
            results += " return .match"
            return results
        }

        results += "\n\t\t\t\tvar results: [Matcher.ParameterComparisonResult] = []\n"
        results += parameters.map { "\t\t\t\t\($0.comparatorResult())" }.joined(separator: "\n")
        results += "\n\t\t\t\treturn Matcher.ComparisonResult(results)"
        return results
    }
    var intValueCase: String {
        if filteredParameters.isEmpty {
            return "case .\(prototype): return 0"
        } else {
            let params = filteredParameters.enumerated().map { offset, _ in
                return "p\(offset)"
            }
            let definitions = params.joined(separator: ", ")
            let paramsSum = params.map({ "\($0).intValue" }).joined(separator: " + ")
            return "case let .\(prototype)(\(definitions)): return \(paramsSum)"
        }
    }
    var assertionName: String {
        return "case .\(prototype): return \".\(method.selectorName)\(method.parameters.isEmpty ? "()" : "")\""
    }

    var returnsSelf: Bool {
        guard !returnsGenericConstrainedToSelf else { return true }
        return !method.returnTypeName.isVoid && TypeWrapper(method.returnTypeName, current: current).isSelfType
    }
    var returnsGenericConstrainedToSelf: Bool {
        let defaultReturnType = "\(method.returnTypeName.name) "
        return defaultReturnType != returnTypeReplacingSelf
    }
    var returnTypeReplacingSelf: String {
        return replacingSelf("\(method.returnTypeName.name) ", current: current)
    }
    var parametersContainsSelf: Bool {
        return replacingSelf(parametersForStubSignature(), current: current) != parametersForStubSignature()
    }

    let current: Current
    let methodRegistrar: MethodRegistrar

    var replaceSelf: String {
        return current.selfType
    }

    init(_ method: SourceryRuntime.Method, current: Current, methodRegistrar: MethodRegistrar) {
        self.method = method
        self.current = current
        self.methodRegistrar = methodRegistrar
    }

    func register() {
        methodRegistrar.register(registrationName,uniqueName,uniqueNameWithReturnType)
    }

    func wrappedInMethodType() -> Bool {
        return !method.isInitializer
    }

    func returningParameter(_ multiple: Bool, _ front: Bool) -> String {
        guard methodRegistrar.returnTypeMatters(uniqueName: uniqueName) else { return "" }
        let returning: String = "returning: \(returnTypeStripped(method, type: true))"
        guard multiple else { return returning }

        return front ? ", \(returning)" : "\(returning), "
    }

    // Stub
    func stubBody() -> String {
        let body: String = {
            if method.isInitializer || !returnsSelf {
                return invocation + performCall() + givenValue + throwValue + returnValue
            } else {
                return wrappedStubPrefix()
                    + "\t\t" + invocation
                    + performCall()
                    + givenValue
                    + throwValue
                    + returnValue
                    + wrappedStubPostfix()
            }
        }()
        return replacingSelf(body, current: current)
    }

    func wrappedStubPrefix() -> String {
        guard !method.isInitializer, returnsSelf else {
            return ""
        }

        let throwing: String = {
            if method.throws {
                return "throws "
            } else if method.rethrows {
                return "rethrows "
            } else {
                return ""
            }
        }()

        return "func _wrapped<__Self__>() \(throwing)-> __Self__ {\n"
    }

    func wrappedStubPostfix() -> String {
        guard !method.isInitializer, returnsSelf else {
            return ""
        }

        let throwing: String = (method.throws || method.rethrows) ? "try ": ""

        return "\n\t\t}"
            + "\n\t\treturn \(throwing)_wrapped()"
    }

    // Method Type
    func methodTypeDeclarationWithParameters() -> String {
        if filteredParameters.isEmpty {
            return "case \(prototype)"
        } else {
            return "case \(prototype)(\(parametersForMethodTypeDeclaration(availability: hasAvailability)))"
        }
    }

    // Given
    func containsEmptyArgumentLabels() -> Bool {
        return parameters.contains(where: { $0.parameter.argumentLabel == nil })
    }

    func givenReturnTypeString() -> String {
        let returnTypeString: String = {
            guard !returnsGenericConstrainedToSelf else { return returnTypeReplacingSelf }
            guard !returnsSelf else { return replaceSelf }
            return TypeWrapper(method.returnTypeName, current: current).stripped
        }()
        return returnTypeString
    }

    func givenConstructorName(prefix: String = "") -> String {
        let returnTypeString = givenReturnTypeString()
        let (annotation, _, _) = methodInfo()
        let clauseConstraints = whereClauseExpression()

        if filteredParameters.isEmpty {
            return "\(annotation)public static func \(method.shortName)(willReturn: \(returnTypeString)...) -> \(prefix)MethodStub" + clauseConstraints
        } else {
            return "\(annotation)public static func \(method.shortName)(\(parametersForProxySignature()), willReturn: \(returnTypeString)...) -> \(prefix)MethodStub" + clauseConstraints
        }
    }

    func givenConstructorNameThrows(prefix: String = "") -> String {
        let (annotation, _, _) = methodInfo()
        let clauseConstraints = whereClauseExpression()

        let genericsArray = getGenericsConstraints(getGenericsAmongParameters(), filterSingle: false)
        let generics = genericsArray.isEmpty ? "" : "<\(genericsArray.joined(separator: ", "))>"

        if filteredParameters.isEmpty {
            return "\(annotation)public static func \(method.callName)\(generics)(willThrow: Error...) -> \(prefix)MethodStub" + clauseConstraints
        } else {
            return "\(annotation)public static func \(method.callName)\(generics)(\(parametersForProxySignature()), willThrow: Error...) -> \(prefix)MethodStub" + clauseConstraints
        }
    }

    func givenConstructor(prefix: String = "") -> String {
        if filteredParameters.isEmpty {
            return "return \(prefix)Given(method: .\(prototype), products: willReturn.map({ StubProduct.return($0 as Any) }))"
        } else {
            return "return \(prefix)Given(method: .\(prototype)(\(parametersForProxyInit())), products: willReturn.map({ StubProduct.return($0 as Any) }))"
        }
    }

    func givenConstructorThrows(prefix: String = "") -> String {
        if filteredParameters.isEmpty {
            return "return \(prefix)Given(method: .\(prototype), products: willThrow.map({ StubProduct.throw($0) }))"
        } else {
            return "return \(prefix)Given(method: .\(prototype)(\(parametersForProxyInit())), products: willThrow.map({ StubProduct.throw($0) }))"
        }
    }

    // Given willProduce
    func givenProduceConstructorName(prefix: String = "") -> String {
        let returnTypeString = givenReturnTypeString()
        let (annotation, _, _) = methodInfo()
        let produceClosure = "(Stubber<\(returnTypeString)>) -> Void"
        let clauseConstraints = whereClauseExpression()

        if filteredParameters.isEmpty {
            return "\(annotation)public static func \(method.shortName)(willProduce: \(produceClosure)) -> \(prefix)MethodStub" + clauseConstraints
        } else {
            return "\(annotation)public static func \(method.shortName)(\(parametersForProxySignature()), willProduce: \(produceClosure)) -> \(prefix)MethodStub" + clauseConstraints
        }
    }

    func givenProduceConstructorNameThrows(prefix: String = "") -> String {
        let returnTypeString = givenReturnTypeString()
        let (annotation, _, _) = methodInfo()
        let produceClosure = "(StubberThrows<\(returnTypeString)>) -> Void"
        let clauseConstraints = whereClauseExpression()

        if filteredParameters.isEmpty {
            return "\(annotation)public static func \(method.shortName)(willProduce: \(produceClosure)) -> \(prefix)MethodStub" + clauseConstraints
        } else {
            return "\(annotation)public static func \(method.shortName)(\(parametersForProxySignature()), willProduce: \(produceClosure)) -> \(prefix)MethodStub" + clauseConstraints
        }
    }

    func givenProduceConstructor(prefix: String = "") -> String {
        let returnTypeString = givenReturnTypeString()
        return """
        let willReturn: [\(returnTypeString)] = []
        \t\t\tlet given: \(prefix)Given = { \(givenConstructor(prefix: prefix)) }()
        \t\t\tlet stubber = given.stub(for: (\(returnTypeString)).self)
        \t\t\twillProduce(stubber)
        \t\t\treturn given
        """
    }

    func givenProduceConstructorThrows(prefix: String = "") -> String {
        let returnTypeString = givenReturnTypeString()
        return """
        let willThrow: [Error] = []
        \t\t\tlet given: \(prefix)Given = { \(givenConstructorThrows(prefix: prefix)) }()
        \t\t\tlet stubber = given.stubThrows(for: (\(returnTypeString)).self)
        \t\t\twillProduce(stubber)
        \t\t\treturn given
        """
    }

    // Verify
    func verificationProxyConstructorName(prefix: String = "") -> String {
        let (annotation, methodName, genericConstrains) = methodInfo()

        if filteredParameters.isEmpty {
            return "\(annotation)public static func \(methodName)(\(returningParameter(false,true))) -> \(prefix)Verify\(genericConstrains)"
        } else {
            return "\(annotation)public static func \(methodName)(\(parametersForProxySignature())\(returningParameter(true,true))) -> \(prefix)Verify\(genericConstrains)"
        }
    }

    func verificationProxyConstructor(prefix: String = "") -> String {
        if filteredParameters.isEmpty {
            return "return \(prefix)Verify(method: .\(prototype))"
        } else {
            return "return \(prefix)Verify(method: .\(prototype)(\(parametersForProxyInit())))"
        }
    }

    // Perform
    func performProxyConstructorName(prefix: String = "") -> String {
        let body: String = {
            let (annotation, methodName, genericConstrains) = methodInfo()

            if filteredParameters.isEmpty {
                return "\(annotation)public static func \(methodName)(\(returningParameter(true,false))perform: @escaping \(performProxyClosureType())) -> \(prefix)Perform\(genericConstrains)"
            } else {
                return "\(annotation)public static func \(methodName)(\(parametersForProxySignature()), \(returningParameter(true,false))perform: @escaping \(performProxyClosureType())) -> \(prefix)Perform\(genericConstrains)"
            }
        }()
        return replacingSelf(body, current: current)
    }

    func performProxyConstructor(prefix: String = "") -> String {
        if filteredParameters.isEmpty {
            return "return \(prefix)Perform(method: .\(prototype), performs: perform)"
        } else {
            return "return \(prefix)Perform(method: .\(prototype)(\(parametersForProxyInit())), performs: perform)"
        }
    }

    func performProxyClosureType() -> String {
        if filteredParameters.isEmpty {
            return "() -> Void"
        } else {
            let parameters = self.parameters
                .map { "\($0.justPerformType)" }
                .joined(separator: ", ")
            return "(\(parameters)) -> Void"
        }
    }

    func performProxyClosureCall() -> String {
        if filteredParameters.isEmpty {
            return "perform?()"
        } else {
            let parameters = filteredParameters
                .map { p in
                    let wrapped = ParameterWrapper(p, self.getVariadicParametersNames(), current: current)
                    let isAutolosure = wrapped.justType.hasPrefix("@autoclosure")
                    return "\(p.inout ? "&" : "")`\(p.name)`\(isAutolosure ? "()" : "")"
                }
                .joined(separator: ", ")
            return "perform?(\(parameters))"
        }
    }

    func performCall() -> String {
        guard !method.isInitializer else { return "" }
        let type = performProxyClosureType()
        var proxy = filteredParameters.isEmpty ? "\(prototype)" : "\(prototype)(\(parametersForMethodCall()))"

        let cast = "let perform = methodPerformValue(.\(proxy)) as? \(type)"
        let call = performProxyClosureCall()

        return "\n\t\t\(cast)\n\t\t\(call)"
    }

    // Helpers
    private func parametersForMethodCall() -> String {
        let generics = getGenericsWithoutConstraints()
        return parameters.map { $0.wrappedForCalls(generics, hasAvailability) }.joined(separator: ", ")
    }

    private func parametersForMethodTypeDeclaration(availability: Bool) -> String {
        let generics = getGenericsWithoutConstraints()
        return parameters.map { param in
            if param.isGeneric(generics) { return param.genericType }
            if availability { return param.typeErasedType }
            return replacingSelf(param.nestedType, current: current)
        }.joined(separator: ", ")
    }

    private func parametersForProxySignature() -> String {
        return parameters.map { p in
            return "\(p.labelAndName()): \(replacingSelf(p.nestedType, current: current))"
        }.joined(separator: ", ")
    }

    private func parametersForStubSignature() -> String {
        func replacing(first: String, in full: String, with other: String) -> String {
            guard let range = full.range(of: first) else { return full }
            return full.replacingCharacters(in: range, with: other)
        }
        let prefix = method.shortName
        let full = method.name
        let range = full.range(of: prefix)!
        var unrefined = "\(full[range.upperBound...])"
        parameters.map { p -> (String,String) in
            return ("\(p.type)","\(p.justType)")
        }.forEach {
            unrefined = replacing(first: $0, in: unrefined, with: $1)
        }
        return unrefined
    }

    private func parametersForProxyInit() -> String {
        let generics = getGenericsWithoutConstraints()
        return parameters.map { "\($0.wrappedForProxy(generics, hasAvailability))" }.joined(separator: ", ")
    }

    private func isGeneric() -> Bool {
        return method.shortName.contains("<") && method.shortName.contains(">")
    }

    private func getVariadicParametersNames() -> [String] {
        let pattern = "[\\(|,]( *[_|\\w]* )? *(\\w+) *\\: *(.+?\\.\\.\\.)"
        let str = method.name
        let range = NSRange(location: 0, length: (str as NSString).length)

        guard let regex = try? NSRegularExpression(pattern: pattern) else { return [] }

        var result: [String] = regex
            .matches(in: str, options: [], range: range)
            .compactMap { match -> String? in
                guard let nameRange = Range(match.range(at: 2), in: str) else { return nil }
                return String(str[nameRange])
            }
        return result
    }

    /// Returns list of generics used in method signature, without their constraints (like [T,U,V])
    ///
    /// - Returns: Array of strings, where each strings represent generic name
    private func getGenericsWithoutConstraints() -> [String] {
        let name = method.shortName
        guard let start = name.firstIndex(of: "<"), let end = name.firstIndex(of: ">") else { return [] }

        var genPart = name[start...end]
        genPart.removeFirst()
        genPart.removeLast()

        let parts = genPart.replacingOccurrences(of: " ", with: "").split(separator: ",").map(String.init)
        return parts.map { stripGenPart(part: $0) }
    }

    /// Returns list of generic constraintes from method signature. Does only contain stuff between '<' and '>'
    ///
    /// - Returns: Array of strings, like ["T: Codable", "U: Whatever"]
    private func getGenericsConstraints(_ generics: [String], filterSingle: Bool = true) -> [String] {
        let name = method.shortName
        guard let start = name.firstIndex(of: "<"), let end = name.firstIndex(of: ">") else { return [] }

        var genPart = name[start...end]
        genPart.removeFirst()
        genPart.removeLast()

        let parts = genPart.replacingOccurrences(of: " ", with: "").split(separator: ",").map(String.init)
        return parts.filter {
            let components = $0.components(separatedBy: ":")
            return (components.count == 2 || !filterSingle) && generics.contains(components[0])
        }
    }

    private func getGenericsAmongParameters() -> [String] {
        return getGenericsWithoutConstraints().filter {
            for param in self.parameters {
                if param.isGeneric([$0]) { return true }
            }
            return false
        }
    }

    private func wrapGenerics(_ generics: [String]) -> String {
        guard !generics.isEmpty else { return "" }
        return "<\(generics.joined(separator:","))>"
    }

    private func stripGenPart(part: String) -> String {
        return part.split(separator: ":").map(String.init).first!
    }

    private func returnTypeStripped(_ method: SourceryRuntime.Method, type: Bool = false) -> String {
        let returnTypeRaw = "\(method.returnTypeName)"
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

    private func whereClauseConstraints() -> [String] {
        let returnTypeRaw = method.returnTypeName.name
        guard let range = returnTypeRaw.range(of: "where") else { return [] }
        var whereClause = returnTypeRaw
        whereClause.removeSubrange(...(range.upperBound))
        return whereClause
            .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            .components(separatedBy: ",")
    }

    private func whereClauseExpression() -> String {
        let constraints = whereClauseConstraints()
        if constraints.isEmpty {
            return ""
        }
        return " where " + constraints.joined(separator: ", ")
    }

    private func methodInfo() -> (annotation: String, methodName: String, genericConstrains: String) {
        let generics = getGenericsAmongParameters()
        let methodName = methodRegistrar.returnTypeMatters(uniqueName: uniqueName) ? method.shortName : "\(method.callName)\(wrapGenerics(generics))"
        let constraints: String = {
            let constraints: [String]
            if methodRegistrar.returnTypeMatters(uniqueName: uniqueName) {
                constraints = whereClauseConstraints()
            } else {
                constraints = getGenericsConstraints(generics)
            }
            guard !constraints.isEmpty else { return "" }

            return " where \(constraints.joined(separator: ", "))"
        }()
        var attributes = self.methodAttributesNonObjc
        attributes = attributes.condenseWhitespace()
        attributes = attributes.isEmpty ? "" : "\(attributes)\n\t\t"
        return (attributes, methodName, constraints)
    }
}

extension String {
    func condenseWhitespace() -> String {
        let components = self.components(separatedBy: .whitespacesAndNewlines)
        return components.filter { !$0.isEmpty }.joined(separator: " ")
    }
}
