import Foundation
import PathKit

extension Array where Element == Path {
    func commonPrefix() -> Path? {
        guard let first = self.first else { return nil }

        return self.reduce(first, { (result, current) -> Path in
            return result.commonPrefix(with: current)
        })
    }
}

extension Path {

    func removingLastComponent() -> Path {
        return Path(components: components.dropLast())
    }

    func commonPrefix(with other: Path) -> Path {
        var common = [String]()
        var lhs = self.components
        var rhs = other.components

        while !lhs.isEmpty, !rhs.isEmpty, rhs.first == lhs.first {
            common.append(lhs.first!)
            lhs.removeFirst()
            rhs.removeFirst()
        }

        return Path(components: common)
    }
}
