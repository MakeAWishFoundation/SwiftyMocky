import Foundation
import PathKit

public var kSwiftyMockyCommand = Path("mocky")
public var kSourceryVersion = "1.8.0"
public var kDefaultSourceryCommand: (String) -> String = { version in "mint run krzysztofzablocki/Sourcery@\(version) sourcery"}

public protocol AutoMockable {}

public enum MockyError: Swift.Error {
    case targetNotFound
    case projectNotFound
    case mockNotFound
    case internalFailure
    case writingError
    case overrideWarning
    case versionMismatch
}
