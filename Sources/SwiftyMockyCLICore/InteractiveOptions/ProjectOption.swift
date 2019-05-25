import Foundation
import Crayon
import PathKit

public struct ProjectPathOption: RawRepresentable, SelectableOption {
    public typealias RawValue = String

    private static var projects: [Path] = []

    public var rawValue: String
    public var title: String {
        if rawValue == ProjectPathOption.projects.first?.string {
            let formatted = crayon.underline.on("\(Path(rawValue).lastComponentWithoutExtension)")
            return "\(formatted)"
        }
        return Path(rawValue).lastComponentWithoutExtension
    }

    public init?(rawValue: RawValue) {
        guard !ProjectPathOption.projects.isEmpty else { return nil }
        guard !rawValue.isEmpty else {
            self.rawValue = ProjectPathOption.projects.first!.string
            return
        }

        let matching = ProjectPathOption.projects.filter { $0.lastComponent.hasPrefix(rawValue) }
        guard !matching.isEmpty else {
            Message.warning("No project with that name!")
            return nil
        }
        guard matching.count == 1 else {
            Message.warning("Project name ambigious! Found:")
            Message.indent()
            matching.forEach { path in
                Message.infoPoint("\(path)")
            }
            Message.unindent()
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

        Message.warning("Several projects found! Choose xcodeproj file.")

        let options = paths.map { ProjectPathOption($0.string) }
        let selected = Path(select(from: options).rawValue)

        Message.empty()
        Message.subheader("Selected: \(selected.lastComponent)\n")
        
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
