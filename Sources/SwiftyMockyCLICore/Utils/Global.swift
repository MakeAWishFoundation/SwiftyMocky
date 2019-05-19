import Foundation
import PathKit

public var kSwiftyMockyCommand = Path("mocky")
public var kSourceryVersion = "Sourcery@0.16.1"
public var kDefaultSourceryCommand = Path("mint run krzysztofzablocki/\(kSourceryVersion) sourcery")

public protocol GenerationCommand: AutoMockable {

    func generate(disableCache: Bool, verbose: Bool) throws
    func generate(mockName: String, disableCache: Bool, verbose: Bool, watch: Bool) throws
    func updateAllImports() throws
    func updateImports(forMockNamed name: String) throws
}

public protocol AutoMockable {}

public enum MockyError: Swift.Error {
    case targetNotFound
    case projectNotFound
    case mockNotFound
    case internalFailure
    case writingError
    case overrideWarning
}
