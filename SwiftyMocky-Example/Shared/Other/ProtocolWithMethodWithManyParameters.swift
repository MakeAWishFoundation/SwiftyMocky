import Foundation

protocol ProtocolWithMethodWithManyParameters: AutoMockable {
    func method(param1: Int, value: String, flagA: Bool, flagB: Bool, closure: () -> Void)
}
