import Foundation

@available(iOS 14, *) @objc
protocol ProtocolWithAttributes: AutoMockable {
    func funcA()
}

//sourcery: AutoMockable
protocol ProtocolWithAttributesB {
    @available(iOS 14, *)
    func funcB(_ dependency: ProtocolWithAttributes)

    @available(iOS 14, *)
    func funcC(_ dependency: ProtocolWithAttributes) -> Bool

    @available(iOS 12, macOS 10.14, *)
    subscript (x: Int, y: Int) -> String { get set }

    mutating func mutatingFunc(param: Int) -> String

    @discardableResult @inlinable func inlinableFunc(_ val: Int) -> Int
}
