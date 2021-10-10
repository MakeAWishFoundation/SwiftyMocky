import Foundation
import Yams
import PathKit
import Commander

// MARK: - Mockfile Setup

class MockfileInteractor {

    var mockfile: Mockfile
    let path: Path
    let existis: Bool

    init(path: Path) throws {
        self.path = path

        if let yaml: String = try? path.read() {
            mockfile = try YAMLDecoder().decode(from: yaml)
            existis = true
        } else {
            mockfile = Mockfile(sourceryCommand: nil, contents: [:])
            existis = false
        }
    }

    init(path: Path, mockfile: Mockfile) {
        self.path = path
        self.mockfile = mockfile
        self.existis = true
    }

    func save() throws {
        try path.write(try YAMLEncoder().encode(mockfile))
    }

    func isSetup(target: ProjectTarget) -> Bool {
        return mockfile.allMocks.contains(where: { $0.targets.contains(target.name) })
    }

    func firstMockFor(target: ProjectTarget) -> String? {
        return mockfile.allMembers.first(where: {
            mockfile[dynamicMember: $0]?.targets.contains(target.name) ?? false
        })
    }

    func add(mock: MockConfiguration, for name: String) {
        mockfile[dynamicMember: name] = mock
    }

    func remove(for name: String) {
        mockfile[dynamicMember: name] = nil
    }
}
