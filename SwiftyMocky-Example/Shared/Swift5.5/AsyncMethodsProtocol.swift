import Foundation

//sourcery: AutoMockable
protocol AsyncMethodsProtocol {
    @available(iOS 15.0.0, macOS 12.0.0, tvOS 15.0.0, *)
    func loadListOfItems() async -> [String]
}
