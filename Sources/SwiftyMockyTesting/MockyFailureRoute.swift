/// Where a mock failure has to be reported.
///
/// The decision is a pure function of two observable facts, deliberately separated from the
/// adapters that act on it: only this way all three outcomes can be covered by tests,
/// including `noTestContext`, which cannot be reached from the outside.
public enum MockyFailureRoute: Equatable {
    /// A Swift Testing test is running: the failure becomes a recorded `Issue`.
    case swiftTesting
    /// XCTest is executing a test case: the failure goes through the XCTest reporting.
    case xctest
    /// Neither framework is running. Reaching this is itself a defect worth shouting about,
    /// because a check that reported to nobody is not a passing check.
    case noTestContext

    public static func route(
        isSwiftTestingActive: Bool,
        isXCTestCaseActive: Bool
    ) -> MockyFailureRoute {
        if isSwiftTestingActive {
            return .swiftTesting
        }

        if isXCTestCaseActive {
            return .xctest
        }

        return .noTestContext
    }
}
