class TypeWrapper {
    let type: SourceryRuntime.TypeName
    let isVariadic: Bool

    var vPref: String { return isVariadic ? "[" : "" }
    var vSuff: String { return isVariadic ? "]" : "" }

    var unwrapped: String {
        return type.unwrappedTypeName
    }
    var unwrappedReplacingSelf: String {
        return replacingSelf(unwrap: true)
    }
    var stripped: String {
        if type.isImplicitlyUnwrappedOptional {
            return type.isClosure ? "\(vPref)(\(unwrappedReplacingSelf))?\(vSuff)" : "\(vPref)\(unwrappedReplacingSelf)?\(vSuff)"
        } else if type.isOptional {
            return type.isClosure ? "\(vPref)(\(unwrappedReplacingSelf))?\(vSuff)" : "\(vPref)\(unwrappedReplacingSelf)?\(vSuff)"
        } else {
            return "\(vPref)\(unwrappedReplacingSelf)\(vSuff)"
        }
    }
    var nestedParameter: String {
        if type.isImplicitlyUnwrappedOptional {
            return "Parameter<" + (type.isClosure ? "\(vPref)(\(unwrappedReplacingSelf))?\(vSuff)" : "\(vPref)\(unwrappedReplacingSelf)?\(vSuff)") + ">"
        } else if type.isOptional {
            return "Parameter<" + (type.isClosure ? "\(vPref)(\(unwrappedReplacingSelf))?\(vSuff)" : "\(vPref)\(unwrappedReplacingSelf)?\(vSuff)") + ">"
        } else {
            return "Parameter<\(vPref)\(unwrappedReplacingSelf)\(vSuff)>"
        }
    }
    var isSelfType: Bool {
        return unwrapped == "Self"
    }
    func isSelfTypeRecursive() -> Bool {
        if let tuple = type.tuple {
            for element in tuple.elements {
                guard !TypeWrapper(element.typeName).isSelfTypeRecursive() else { return true }
            }
        } else if let array = type.array {
            return TypeWrapper(array.elementTypeName).isSelfTypeRecursive()
        } else if let dictionary = type.dictionary {
            guard !TypeWrapper(dictionary.valueTypeName).isSelfTypeRecursive() else { return true }
            guard !TypeWrapper(dictionary.keyTypeName).isSelfTypeRecursive() else { return true }
        } else if let closure = type.closure {
            guard !TypeWrapper(closure.actualReturnTypeName).isSelfTypeRecursive() else { return true }
            for parameter in closure.parameters {
                guard !TypeWrapper(parameter.typeName).isSelfTypeRecursive() else { return true }
            }
        }

        return isSelfType
    }

    init(_ type: SourceryRuntime.TypeName, _ isVariadic: Bool = false) {
        self.type = type
        self.isVariadic = isVariadic
    }

    func isGeneric(_ types: [String]) -> Bool {
        guard !type.isVoid else { return false }

        return isGeneric(name: unwrapped, generics: types)
    }

    private func isGeneric(name: String, generics: [String]) -> Bool {
        let name = "(\(name.replacingOccurrences(of: " ", with: "")))"
        let modifiers = "[\\?\\!]*"
        return generics.contains(where: { generic in
            let wrapped = "([\\(]\(generic)\(modifiers)[\\)\\.])"
            let constraint = "([<,]\(generic)\(modifiers)[>,\\.])"
            let arrays = "([\\[:]\(generic)\(modifiers)[\\],\\.:])"
            let tuples = "([\\(,]\(generic)\(modifiers)[,\\.\\)])"
            let closures = "((\\-\\>)\(generic)\(modifiers)[,\\.\\)])"
            let pattern = "\(wrapped)|\(constraint)|\(arrays)|\(tuples)|\(closures)"
            guard let regex = try? NSRegularExpression(pattern: pattern) else { return false }
            return regex.firstMatch(in: name, options: [], range: NSRange(location: 0, length: (name as NSString).length)) != nil
        })
    }

    func replacingSelf(unwrap: Bool = false) -> String {
        guard isSelfTypeRecursive() else {
            return unwrap ? self.unwrapped : "\(type)"
        }

        if isSelfType {
            let optionality: String = {
                if type.isImplicitlyUnwrappedOptional {
                    return "!"
                } else if type.isOptional {
                    return "?"
                } else {
                    return ""
                }
            }()
            return unwrap ? Current.selfType : Current.selfType + optionality
        } else if let tuple = type.tuple {
            let inner = tuple.elements.map({ TypeWrapper($0.typeName).replacingSelf() }).joined(separator: ",")
            let value = "(\(inner))"
            return value
        } else if let array = type.array {
            let value = "[\(TypeWrapper(array.elementTypeName).replacingSelf())]"
            return value
        } else if let dictionary = type.dictionary {
            let value = "[" +
                "\(TypeWrapper(dictionary.valueTypeName).replacingSelf())"
                + ":" +
                "\(TypeWrapper(dictionary.keyTypeName).replacingSelf())"
                + "]"
            return value
        } else if let closure = type.closure {
            let returnType = TypeWrapper(closure.actualReturnTypeName).replacingSelf()
            let inner = closure.parameters.map({ TypeWrapper($0.typeName).replacingSelf() }).joined(separator: ",")
            let throwing = closure.throws ? "throws " : ""
            let value = "(\(inner)) \(throwing)-> \(returnType)"
            return value
        } else {
            return (unwrap ? self.unwrapped : "\(type)")
        }
    }

    func replacingSelfRespectingVariadic() -> String {
        return "\(vPref)\(replacingSelf())\(vSuff)"
    }
}
