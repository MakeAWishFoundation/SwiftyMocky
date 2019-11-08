import Foundation
import PathKit
import XcodeProj

extension PBXProj {

    var allTargets: [PBXTarget] {
        var all = [PBXTarget]()
        all.append(contentsOf: nativeTargets)
        all.append(contentsOf: legacyTargets)
        all.append(contentsOf: aggregateTargets)
        return all
    }
    var allUnitTestTargets: [PBXTarget] {
        return allTargets.filter { $0.productType == .unitTestBundle }
    }
    var allUITestTargets: [PBXTarget] {
        return allTargets.filter { $0.productType == .uiTestBundle }
    }
}

extension PBXTarget {

    /// Local path (relative to project root) for info plist file
    ///
    /// - Returns: Project root relative Info.plist path
    func infoPlistPath() -> Path? {
        guard let config = buildConfigurationList?.buildConfigurations.first else {
            return nil
        }
        guard let path = config.buildSettings["INFOPLIST_FILE"] as? String else {
            return nil
        }

        return Path(path)
    }

    /// Local path (relative to project root) for directory enclosing info plist file
    ///
    /// - Returns: Project root relative Info.plist enclosing directory path
    func infoPlistEnclosingDirectory() -> Path? {
        guard let path = infoPlistPath() else { return nil }
        return Path(components: path.components.dropLast())
    }

    func commonSourcesEnclosingFolder() -> Path? {
        guard let sources = try? sourceFiles() else { return nil }

        let paths = sources.compactMap { file -> Path? in
            return file.relativePath()
        }

        return paths.commonPrefix()
    }

    func defaultSourcesFolder() -> Path {
        guard let path = commonSourcesEnclosingFolder() else { return Path(".") }
        return path
    }

}

extension PBXFileElement {
    func relativePath() -> Path? {
        guard let path = self.path else { return nil }

        if let parentPath = self.parent?.relativePath() {
            return parentPath + Path(path)
        } else {
            return Path(path)
        }
    }
}
