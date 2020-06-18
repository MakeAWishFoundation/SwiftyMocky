import Foundation

/// Allows matching count, verifying whether given count is right or not
public protocol Countable {
    /// Returns whether given count matches countable case.
    ///
    /// - Parameter count: Given count
    /// - Returns: true, if it is within boundaries, false otherwise
    func matches(_ count: Int) -> Bool
}

extension UInt: Countable {
    /// Returns whether given count matches countable case.
    ///
    /// - Parameter count: Given count
    /// - Returns: true, if it is within boundaries, false otherwise
    public func matches(_ count: Int) -> Bool {
        return Int(self) == count
    }
}

extension Int: Countable {
    /// Returns whether given count matches countable case.
    ///
    /// - Parameter count: Given count
    /// - Returns: true, if it is within boundaries, false otherwise
    public func matches(_ count: Int) -> Bool {
        return self == count
    }
}
