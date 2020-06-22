import Foundation

extension Matcher {
    public struct ComparisonResult {
        public let matched: Int
        public let total: Int
        public let results: [ParameterComparisonResult]

        public var percentage: Float { return self.total != 0 ? (Float(matched) / Float(total)) * 100.0 : 0 }
        public var percentageString: String { return String(format: "%.2f", percentage) }
        public var isFullMatch: Bool { return matched == total && total != 0 }
        public var isMatch: Bool { return self.matched > 0 }

        public init(_ results: [ParameterComparisonResult]) {
            self.results = results
            // Add 1 to both for matching method. So methods with na params are 1/1
            self.matched = results.filter { $0.matches }.count + 1
            self.total = results.count + 1
        }

        public init(matched: Int, total: Int) {
            self.matched = matched
            self.total = total
            self.results = []
        }

        public static var match: ComparisonResult { return ComparisonResult(matched: 1, total: 1) }
        public static var none: ComparisonResult { return ComparisonResult(matched: 0, total: 0) }

        public func resultString(_ index: Int, _ selectorName: String) -> String {
            let resultsString = self.results.map { "  \($0.resultString)" }.joined(separator: "\n")
            return "\(index + 1)) \(selectorName) [\(self.percentageString)%]\n\(resultsString)"
        }
    }

    public struct ParameterComparisonResult {
        let matches: Bool
        let left: String
        let right: String
        let label: String

        public init<T,U>(_ matches: Bool, _ left: Parameter<T>, _ right: Parameter<U>, _ label: String) {
            self.matches = matches
            self.left = left.shortDescription
            self.right = right.shortDescription
            self.label = label
        }

        public var resultString: String {
            if self.matches {
                return "- (ok)   \(self.label): \(self.left) == \(self.right)"
            } else {
                return "- (fail) \(self.label): \(self.left) != \(self.right)"
            }
        }
    }
}

public enum Utils {

    public static func closestCallsMessage(
        for results: [Matcher.ComparisonResult],
        name assertionName: String
    ) -> String {
        let closestMisses = results
            .reversed()
            .filter { !$0.isFullMatch && $0.isMatch }
            .sorted { $0.percentage > $1.percentage }

        guard !closestMisses.isEmpty else { return "" }

        let message = closestMisses[..<Swift.min(closestMisses.count, 3)]
            .enumerated()
            .map { offset, element in return element.resultString(offset, assertionName) }
            .joined(separator: "\n")

        return "\nClosest calls recorded:\n\(message)"
    }
}
