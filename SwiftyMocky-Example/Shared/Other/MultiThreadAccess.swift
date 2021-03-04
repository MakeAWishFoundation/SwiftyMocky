import Foundation

//sourcery: AutoMockable
protocol Fetcher {
    func fetchProperty(with id: String) -> String
}
