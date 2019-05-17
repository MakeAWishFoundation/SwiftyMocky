import Foundation
import Commander

class ProxyFileHandle: FileHandle {
    override func write(_ data: Data) {
        FileHandle.standardOutput.write(data)
    }

    override func closeFile() {
        // empty on purpose
    }
}
