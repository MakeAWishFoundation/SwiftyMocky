import Foundation
import Crayon
import PathKit

public struct ProjectPathOption: RawRepresentable, SelectableOption {
    public typealias RawValue = String

    private static var projects: [Path] = []

    public var rawValue: String
    public var title: String { return Path(rawValue).lastComponentWithoutExtension }

    public init?(rawValue: RawValue) {
        let matching = ProjectPathOption.projects.filter { $0.lastComponent.hasPrefix(rawValue) }
        guard !matching.isEmpty else {
            print(crayon.red.on("No project with that name!"))
            return nil
        }
        guard matching.count == 1 else {
            let list = matching
                .map { "\t - \($0.string)" }
                .joined(separator: "\n")
            print(crayon.red.on("Project name ambigious! Found: \n\(list)"))
            return nil
        }
        self.rawValue = matching[0].string
    }

    init(_ rawValue: RawValue) {
        self.rawValue = rawValue
    }

    static func select(project name: Path, at root: Path) throws -> Path {
        var paths = name.string.isEmpty ? root.glob("*.xcodeproj") : [name.xcproj(with: root)]
        paths = paths.map { $0.dropSlash() }

        guard !paths.isEmpty else { throw MockyError.projectNotFound }
        guard paths.count > 1 else { return paths[0] }
        ProjectPathOption.projects = paths

        print(crayon.yellow.bold.on("Several projects found! Choose xcodeproj file."))

        let options = paths.map { ProjectPathOption($0.string) }
        let selected = Path(select(from: options).rawValue)
        print(crayon.bold.on("\nSelected: \(selected.lastComponent)\n"))
        return selected
    }
}

private extension Path {
    func xcproj(with root: Path) -> Path {
        return (root + self).dropSlash()
    }
    func dropSlash() -> Path {
        return string.hasSuffix("/") ? Path(String(string.dropLast())) : self
    }
}
