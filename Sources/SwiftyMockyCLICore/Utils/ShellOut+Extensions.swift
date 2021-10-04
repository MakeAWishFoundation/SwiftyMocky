import Foundation

#if os(macOS)
class ProxyFileHandle: FileHandle {
    override func write(_ data: Data) {
        FileHandle.standardOutput.write(data)
    }

    override func closeFile() {
        // empty on purpose
    }
}
#else
class ProxyFileHandle {
    // empty for now, waiting for Foundation to have FileHandle on linux
}
#endif