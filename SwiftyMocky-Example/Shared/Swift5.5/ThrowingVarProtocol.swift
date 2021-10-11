import Foundation

//sourcery: AutoMockable
protocol ThrowingVarProtocol {
    @available(iOS 15.0.0, macOS 12.0.0, tvOS 15.0.0, *)
    var testVariableThatThrow: Bool { get throws }
}
