import Foundation

/// Call site of a mock assertion, carried as a single value through the internal chain.
///
/// The magic literals have to be spelled out in the signature of the function the test
/// calls (see `Verify` in `Mock+Assertions.swift`): default arguments expand at the call
/// site of the expression they belong to, so building this type inside another default
/// argument would capture the location of the library itself, not of the test.
///
/// Member types are chosen to fit both consumers: `XCTFail(_:file:line:)` needs
/// `StaticString` and `UInt`, while `Testing.SourceLocation` takes `String` and `Int`,
/// which are obtained by interpolation and conversion.
@frozen
public struct MockyLocation: Sendable {
    public let fileID: StaticString
    public let filePath: StaticString
    public let line: UInt
    public let column: UInt

    public init(
        fileID: StaticString = #fileID,
        filePath: StaticString = #filePath,
        line: UInt = #line,
        column: UInt = #column
    ) {
        self.fileID = fileID
        self.filePath = filePath
        self.line = line
        self.column = column
    }
}
