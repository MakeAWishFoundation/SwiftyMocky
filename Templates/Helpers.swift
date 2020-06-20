class Helpers {
    static func split(_ string: String, byFirstOccurenceOf word: String) -> (String, String) {
        guard let wordRange = string.range(of: word) else { return (string, "") }
        let selfRange = string.range(of: string)!
        let before = String(string[selfRange.lowerBound..<wordRange.lowerBound])
        let after = String(string[wordRange.upperBound..<selfRange.upperBound])
        return (before, after)
    }
    static func extractAssociatedTypes(from annotated: SourceryRuntime.Annotated) -> [String]? {
        if let types = annotated.annotations["associatedtype"] as? [String] {
            return types.reversed()
        } else if let type = annotated.annotations["associatedtype"] as? String {
            return [type]
        } else {
            return nil
        }
    }
    /// Extract all typealiases from "annotations"
    static func extractTypealiases(from annotated: SourceryRuntime.Annotated) -> [String] {
        if let types = annotated.annotations["typealias"] as? [String] {
            return types.reversed()
        } else if let type = annotated.annotations["typealias"] as? String {
            return [type]
        } else {
            return []
        }
    }
    static func extractGenericsList(_ associatedTypes: [String]?) -> [String] {
        return associatedTypes?.flatMap {
            split($0, byFirstOccurenceOf: " where ").0.replacingOccurrences(of: " ", with: "").characters.split(separator: ":").map(String.init).first
        }.map { "\($0)" } ?? []
    }
    static func extractGenericTypesModifier(_ associatedTypes: [String]?) -> String {
        let all = extractGenericsList(associatedTypes)
        guard !all.isEmpty else { return "" }
        return "<\(all.joined(separator: ","))>"
    }
    static func extractGenericTypesConstraints(_ associatedTypes: [String]?) -> String {
        guard let all = associatedTypes else { return "" }
        let constraints = all.flatMap { t -> String? in
            let splitted = split(t, byFirstOccurenceOf: " where ")
            let constraint = splitted.0.replacingOccurrences(of: " ", with: "").characters.split(separator: ":").map(String.init)
            guard constraint.count == 2 else { return nil }
            let adopts = constraint[1].characters.split(separator: ",").map(String.init)
            var mapped = adopts.map { "\(constraint[0]): \($0)" }
            if !splitted.1.isEmpty {
                mapped.append(splitted.1)
            }
            return mapped.joined(separator: ", ")
            }
            .joined(separator: ", ")
        guard !constraints.isEmpty else { return "" }
        return " where \(constraints)"
    }
    static func extractAttributes(from attributes: [String: SourceryRuntime.Attribute]) -> String {
        return attributes.map { $0.1.description }
        .filter { !["private", "internal", "public", "open", "optional"].contains($0) }
        .sorted()
        .joined(separator: " ")
    }
}
