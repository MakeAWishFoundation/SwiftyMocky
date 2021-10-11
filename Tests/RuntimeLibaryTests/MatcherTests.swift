import XCTest

@testable import SwiftyMocky

class MatcherTests: XCTestCase {

    override class func setUp() {
        SwiftyMockyTestObserver.setup()
    }

    func testMatchDictionariesWrappedAsParameters() {
        let matcher = Matcher()
        matcher.setupCorrentFileAndLine()
        matcher.register((key: String, value: Any).self) { lhs, rhs in
            guard let lhs1 = lhs.value as? String else { return false }
            guard let rhs1 = rhs.value as? String else { return false }
            return lhs.key == rhs.key && lhs1 == rhs1
        }

        let param1 = Parameter<[String: Any]>.value([
            "aaa": "1",
            "bbb": "2"
        ])
        let param2 = Parameter<[String: Any]>.value([
            "aaa": "1",
            "bbb": "2"
        ])
        let param3 = Parameter<[String: Any]>.value([
            "bbb": "2",
            "aaa": "1"
        ])

        let dictType = [String: Any].self
        guard let compare = matcher.comparator(for: dictType) else {
            return XCTFail("No comparator registered!")
        }
        let resultWhenOrdered = compare(
            ["aaa": "1", "bbb": "2"],
            ["aaa": "1", "bbb": "2"]
        )
        let resultWhenUnordered = compare(
            ["aaa": "1", "bbb": "2"],
            ["bbb": "2", "aaa": "1"]
        )
        XCTAssertTrue(resultWhenOrdered, "Ordering should not change result!")
        XCTAssertTrue(resultWhenUnordered, "Ordering should not change result!")

        let paramResultWhenOrdered = Parameter.compare(lhs: param1, rhs: param2, with: matcher)
        let paramResultWhenUnordered = Parameter.compare(lhs: param1, rhs: param3, with: matcher)

        XCTAssertTrue(paramResultWhenOrdered, "Ordering should not change result!")
        XCTAssertTrue(paramResultWhenUnordered, "Ordering should not change result!")
    }

    func testTypeErasedParameterHoldsToDefaultComparators_Equatable() {
        enum TestEnum: String {
            case aaa, bbb
        }
        let matcher = Matcher()
        matcher.setupCorrentFileAndLine()

        let param1a = Parameter<TestEnum>.value(.aaa)
        let param1b = Parameter<TestEnum>.value(.bbb)
        let param2a = Parameter<TestEnum>.value(.aaa)
        let param2b = Parameter<TestEnum>.value(.bbb)

        XCTAssertTrue(Parameter.compare(lhs: param1a, rhs: param2a, with: matcher))
        XCTAssertTrue(Parameter.compare(lhs: param1b, rhs: param2b, with: matcher))

        let erasedParam1A = param1a.typeErasedAttribute()
        let erasedParam2A = param2a.typeErasedAttribute()

        XCTAssertTrue(Parameter.compare(lhs: erasedParam1A, rhs: erasedParam2A, with: matcher))

        let genericParam1A = param1a.wrapAsGeneric()
        let genericParam2A = param2a.wrapAsGeneric()

        XCTAssertTrue(Parameter.compare(lhs: genericParam1A, rhs: genericParam2A, with: matcher))
    }

    func testTypeErasedParameterHoldsToDefaultComparators_Arrays() {
        class TestEnum {
            let value: String
            init(_ value: String) { self.value = value }
            static var aaa: TestEnum { TestEnum("aaa") }
            static var bbb: TestEnum { TestEnum("bbb") }
        }
        let matcher = Matcher()
        matcher.setupCorrentFileAndLine()
        matcher.register(TestEnum.self, match: { $0.value == $1.value })

        let param1 = Parameter<[TestEnum]>.value([.aaa, .bbb])
        let param2 = Parameter<[TestEnum]>.value([.aaa, .bbb])

        XCTAssertTrue(Parameter.compare(lhs: param1, rhs: param2, with: matcher))

        let erasedParam1 = param1.typeErasedAttribute()
        let erasedParam2 = param2.typeErasedAttribute()

        XCTAssertTrue(Parameter.compare(lhs: erasedParam1, rhs: erasedParam2, with: matcher))

        let genericParam1 = param1.wrapAsGeneric()
        let genericParam2 = param2.wrapAsGeneric()

        XCTAssertTrue(Parameter.compare(lhs: genericParam1, rhs: genericParam2, with: matcher))
    }

    func testCompareWhenGenericClosure() {
        let matcher = Matcher()
        matcher.setupCorrentFileAndLine()

        let param1 = Parameter<(String) -> Void>.value({ _ in })
        let param2 = Parameter<(String) -> Void>.any

        XCTAssertTrue(Parameter.compare(lhs: param1, rhs: param2, with: matcher))

        let genericParam1 = param1.wrapAsGeneric()
        let genericParam2 = param2.wrapAsGeneric()

        XCTAssertTrue(Parameter.compare(lhs: genericParam1, rhs: genericParam2, with: matcher))
        XCTAssertTrue(Parameter.compare(lhs: genericParam2, rhs: genericParam1, with: matcher))
        XCTAssertTrue(Parameter.compare(lhs: genericParam2, rhs: genericParam2, with: matcher))
    }
}
