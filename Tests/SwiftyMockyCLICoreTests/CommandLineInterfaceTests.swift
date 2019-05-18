import XCTest
import class Foundation.Bundle
import SwiftyMocky
@testable import SwiftyMockyCLICore

final class CommandLineInterfaceTests: XCTestCase {
    
    // MARK: - Properties

    static var allTests = [
        ("test_command_generate", test_command_generate),
    ]

    var sut: Application!
    var factory: InstanceFactoryMock!

    // MARK: - Lifecycle

    override func setUp() {
        super.setUp()

        sut = Application()
        factory = InstanceFactoryMock()
        Instance.factory = factory
    }

    // MARK: - Setup

    func test_factory_setup() throws {
        XCTAssert(Instance.factory === factory)
    }

    // MARK: - Generate Command Tests

    func test_command_generate() throws {
        // Given
        let command = GenerationCommandMock()
        Given(factory, .resolveGenerationCommand(root: .any, willReturn: command))

        // Then
        sut.generate(disableCache: false, verbose: true)

        // Verify
        Verify(factory, .once, .resolveGenerationCommand(root: .any))
        Verify(command, .once, .generate(disableCache: false, verbose: true))
    }

    func test_command_generate_handles_error() throws {
        // Given
        let command = GenerationCommandMock()
        Given(factory, .resolveGenerationCommand(root: .any, willReturn: command))
        Given(command, .generate(disableCache: .any, verbose: .any, willThrow: TestError()))
        let errorHandled = expectation(description: "Should handle error")
        sut.handle = { 
            XCTAssert($0 is TestError) 
            errorHandled.fulfill()
        }

        // Then
        sut.generate(disableCache: false, verbose: false)

        // Verify
        Verify(command, .once, .generate(disableCache: .any, verbose: .any))
        waitForExpectations(timeout: 0.2)
    }

    // MARK: - Helpers

    struct TestError: Error { }
}

private extension XCTestCase {

    enum ExecutionError: Error {
        case nonMatchingSystemRequirements
        case capturingOutputFailure
    }

    @discardableResult
    func executeCommand(_ arguments: [String]) throws -> String {
        guard #available(macOS 10.13, *) else { 
            throw ExecutionError.nonMatchingSystemRequirements
        }

        let binary = Bundle.productsDirectory.appendingPathComponent("swiftymocky")
        let process = Process()
        process.executableURL = binary
        process.arguments = arguments

        let pipe = Pipe()
        process.standardOutput = pipe

        try process.run()
        process.waitUntilExit()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        guard let output = String(data: data, encoding: .utf8) else {
            throw ExecutionError.capturingOutputFailure
        }

        return output
    }
}

private extension Bundle {
    static var productsDirectory: URL {
        #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
        #else
        return Bundle.main.bundleURL
        #endif
    }
}
