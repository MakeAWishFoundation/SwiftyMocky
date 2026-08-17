import Testing
import SwiftyMockyTesting
@testable import Mocky_Example_macOS

@Suite struct MockyFailureRouteTests {

    @Test func swift_testing_wins_when_both_frameworks_are_active() {
        let route = MockyFailureRoute.route(isSwiftTestingActive: true, isXCTestCaseActive: true)

        #expect(route == .swiftTesting)
    }

    @Test func xctest_is_used_when_no_swift_testing_test_is_running() {
        let route = MockyFailureRoute.route(isSwiftTestingActive: false, isXCTestCaseActive: true)

        #expect(route == .xctest)
    }

    @Test func no_test_context_when_neither_framework_is_running() {
        let route = MockyFailureRoute.route(isSwiftTestingActive: false, isXCTestCaseActive: false)

        #expect(route == .noTestContext)
    }
}

@Suite struct MockyReportingToSwiftTestingTests {

    @Test func failed_verify_is_recorded_as_an_issue() {
        let mock = SimpleProtocolWithMethodsMock()

        withKnownIssue {
            Verify(mock, .simpleMethod())
        }
    }

    @Test func failed_verify_on_a_count_is_recorded_as_an_issue() {
        let mock = SimpleProtocolWithMethodsMock()
        mock.simpleMethod()

        withKnownIssue {
            Verify(mock, 2, .simpleMethod())
        }
    }

    @Test func satisfied_verify_records_nothing() {
        let mock = SimpleProtocolWithMethodsMock()
        mock.simpleMethod()

        Verify(mock, .simpleMethod())
    }

    @Test func mocks_work_the_same_when_verified_directly_on_the_instance() {
        let mock = SimpleProtocolWithMethodsMock()
        mock.simpleMethod()

        mock.verify(.simpleMethod())

        withKnownIssue {
            mock.verify(.simpleMethod(), count: 2)
        }
    }
}
