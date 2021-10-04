import Foundation
import PathKit

public enum Instance {
    public internal(set) static var factory: InstanceFactory = InstanceFactoryConcrete()
}

public protocol InstanceFactory: class, AutoMockable {

    // MARK: - Generation
    func resolveGenerationCommand(root: Path) throws -> GenerationCommand
    func resolveGenerationCommand(root: Path, mockfile: Mockfile) -> GenerationCommand
}

public class InstanceFactoryConcrete: InstanceFactory {
    
    fileprivate init() { }

    // MARK: - Generation
    public func resolveGenerationCommand(root: Path) throws -> GenerationCommand {
        return try GenerationController(root: root)
    }

    public func resolveGenerationCommand(root: Path, mockfile: Mockfile) -> GenerationCommand {
        return GenerationController(root: root, mockfile: mockfile)
    }
}