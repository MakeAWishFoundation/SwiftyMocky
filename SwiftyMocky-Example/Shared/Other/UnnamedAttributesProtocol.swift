import Foundation

//sourcery: AutoMockable
protocol UnnamedAttributesProtocol {
    func methodWithUnnamedAttributes(_: Int) -> String
    func methodWithUnnamedAndNamedAttributes(at int: Int, _: Int) -> String
}

class UnnamedAtributesProtocolImpl: UnnamedAttributesProtocol {

    func methodWithUnnamedAttributes(_ name: Int) -> String {
        return "\(name)"
    }

    func methodWithUnnamedAndNamedAttributes(at int: Int, _ other: Int) -> String {
        return "\(int).\(other)"
    }
}
