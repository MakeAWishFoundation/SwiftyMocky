import Foundation

//sourcery: AutoMockable
protocol VariadicParametersProtocol {
    func methodThatTakesVariadic(numbers: Int...) -> Int
    func methodThatTakesVariadic(label numbers: Int...) -> Int
}
