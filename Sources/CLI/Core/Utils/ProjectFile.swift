import Foundation

#if os(macOS)
import XcodeProj

extension PBXTarget: ProjectTarget { }
#endif

public protocol ProjectFile {
    
}

public protocol ProjectTarget {
    var name: String { get }
}
