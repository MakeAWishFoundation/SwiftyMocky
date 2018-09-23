//
//  SwiftyTestCase.swift
//  SwiftyMocky
//
//  Created by Andrzej Michnia on 23.09.2018.
//  Copyright © 2018 MakeAWishFoundation. All rights reserved.
//

import XCTest

/// SwiftyMocky test case. Use it to override system XCTasserts with the ones safer for SwiftyMocky. Additionally, SwiftyTestCase has some useful utils that might come handy.
open class SwiftyTestCase: XCTestCase {
    // MARK: - XCTAssert - Bool
    public func XCTAssert(_ expression: @escaping @autoclosure () throws -> Bool, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) {
        let message = message()
        wrap(message: message, file: file, line: line) {
            try! mockyAssert(try expression(), message, file: file, line: line)
        }
    }

    public func XCTAssertTrue(_ expression: @escaping @autoclosure () throws -> Bool, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) {
        let message = message()
        wrap(message: message, file: file, line: line) {
            try! mockyAssertTrue(try expression(), message, file: file, line: line)
        }
    }

    public func XCTAssertFalse(_ expression: @escaping @autoclosure () throws -> Bool, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) {
        let message = message()
        wrap(message: message, file: file, line: line) {
            try! mockyAssertFalse(try expression(), message, file: file, line: line)
        }
    }

    // MARK: - XCTAssert Nil
    public func XCTAssertNil(_ expression: @escaping @autoclosure () throws -> Any?, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) {
        let message = message()
        wrap(message: message, file: file, line: line) {
            try! mockyAssertNil(try expression(), message, file: file, line: line)
        }
    }

    public func XCTAssertNotNil(_ expression: @escaping @autoclosure () throws -> Any?, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) {
        let message = message()
        wrap(message: message, file: file, line: line) {
            try! mockyAssertNotNil(try expression(), message, file: file, line: line)
        }
    }

    // MARK: - XCTAssert - Equatable
    public func XCTAssertEqual<T>(_ expression1: @escaping @autoclosure () throws -> T, _ expression2: @escaping @autoclosure () throws -> T, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) where T : Equatable {
        let message = message()
        wrap(message: message, file: file, line: line) {
            try! mockyAssertEqual(try expression1(), try expression2(), message, file: file, line: line)
        }
    }

    public func XCTAssertEqual<T>(_ expression1: @escaping @autoclosure () throws -> T, _ expression2: @escaping @autoclosure () throws -> T, accuracy: T, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) where T : FloatingPoint {
        let message = message()
        wrap(message: message, file: file, line: line) {
            try! mockyAssertEqual(try expression1(), try expression2(), accuracy: accuracy, message, file: file, line: line)
        }
    }

    public func XCTAssertNotEqual<T>(_ expression1: @escaping @autoclosure () throws -> T, _ expression2: @escaping @autoclosure () throws -> T, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) where T : Equatable {
        let message = message()
        wrap(message: message, file: file, line: line) {
            try! mockyAssertNotEqual(try expression1(), try expression2(), message, file: file, line: line)
        }
    }

    public func XCTAssertNotEqual<T>(_ expression1: @escaping @autoclosure () throws -> T, _ expression2: @escaping @autoclosure () throws -> T, accuracy: T, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) where T : FloatingPoint {
        let message = message()
        wrap(message: message, file: file, line: line) {
            try! mockyAssertNotEqual(try expression1(), try expression2(), accuracy: accuracy, message, file: file, line: line)
        }
    }

    // MARK: - XCTassert - Comparable
    public func XCTAssertLessThan<T>(_ expression1: @escaping @autoclosure () throws -> T, _ expression2: @escaping @autoclosure () throws -> T, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) where T : Comparable {
        let message = message()
        wrap(message: message, file: file, line: line) {
            try! mockyAssertLessThan(try expression1(), try expression2(), message, file: file, line: line)
        }
    }

    public func XCTAssertLessThanOrEqual<T>(_ expression1: @escaping @autoclosure () throws -> T, _ expression2: @escaping @autoclosure () throws -> T, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) where T : Comparable {
        let message = message()
        wrap(message: message, file: file, line: line) {
            try! mockyAssertLessThanOrEqual(try expression1(), try expression2(), message, file: file, line: line)
        }
    }

    public func XCTAssertGreaterThan<T>(_ expression1: @escaping @autoclosure () throws -> T, _ expression2: @escaping @autoclosure () throws -> T, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) where T : Comparable {
        let message = message()
        wrap(message: message, file: file, line: line) {
            try! mockyAssertGreaterThan(try expression1(), try expression2(), message, file: file, line: line)
        }
    }

    public func XCTAssertGreaterThanOrEqual<T>(_ expression1: @escaping @autoclosure () throws -> T, _ expression2: @escaping @autoclosure () throws -> T, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) where T : Comparable {
        let message = message()
        wrap(message: message, file: file, line: line) {
            try! mockyAssertGreaterThanOrEqual(try expression1(), try expression2(), message, file: file, line: line)
        }
    }

    // MARK: - XCTAssert - Throwing
    public func XCTAssertNoThrow<T>(_ expression: @escaping @autoclosure () throws -> T, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) {
        let message = message()
        wrap(message: message, file: file, line: line) {
            try! mockyAssertNoThrow(try expression(), message, file: file, line: line)
        }
    }

    public func XCTAssertThrowsError<T>(_ expression: @escaping @autoclosure () throws -> T, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line, _ errorHandler: (Error) -> Void = { _ in }) {
        let message = message()
        wrap(message: message, file: file, line: line) {
            try! mockyAssertThrowsError(try expression(), message, file: file, line: line)
        }
    }

    // MARK: - Additional Error handling convenience
    public func XCTAssertThrowsError<T, E: Error>(_ expression: @escaping @autoclosure () throws -> T, of error: E.Type, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) {
        let message = message()
        wrap(message: message, file: file, line: line) {
            try! mockyAssertThrowsError(try expression(), of: E.self, message, file: file, line: line)
        }
    }

    public func XCTAssertThrowsError<T, E>(_ expression: @escaping @autoclosure () throws -> T, error: E, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) where E: Error, E: Equatable {
        let message = message()
        wrap(message: message, file: file, line: line) {
            try! mockyAssertThrowsError(try expression(), error: error, message, file: file, line: line)
        }
    }

    // MARK: - XCTAssert - Deprecated
    @available(*, unavailable, renamed: "XCTAssertNotEqual")
    public func XCTAssertNotEqualWithAccuracy<T>(_ expression1: @escaping @autoclosure () throws -> T, _ expression2: @escaping @autoclosure () throws -> T, _ accuracy: T, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) where T : FloatingPoint {
        fatalError("unimplemented")
    }

    @available(*, unavailable, renamed: "XCTAssertEqual")
    public func XCTAssertEqualWithAccuracy<T>(_ expression1: @escaping @autoclosure () throws -> T, _ expression2: @escaping @autoclosure () throws -> T, accuracy: T, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) where T : FloatingPoint {
        fatalError("unimplemented")
    }

    // MARK: - Helpers - recovering from fatalError
    private func wrap(message: String, file: StaticString, line: UInt, testcase: @escaping () -> Void) {
        var wasFatal = false
        var fatalMessage = message
        let semaphore = DispatchSemaphore(value: 0)

        FatalErrorUtil.set { message -> Never in
            wasFatal = true
            fatalMessage = message
            semaphore.signal()
            self.blockForEverAndOneDayMore() // Prevent continue - as we cannot recover from fatal error
        }

        // Dispatch test case to background queue
        if #available(OSXApplicationExtension 10.10, *) {
            DispatchQueue.global(qos: .userInitiated).async {
                testcase()
                semaphore.signal()
            }
        } else {
            DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.background).async {
                testcase()
                semaphore.signal()
            }
        }

        _ = semaphore.wait(timeout: DispatchTime.now() + DispatchTimeInterval.seconds(2))

        FatalErrorUtil.restore()
        if wasFatal {
            XCTFail(fatalMessage, file: file, line: line)
        }
    }

    private func blockForEverAndOneDayMore() -> Never {
        repeat {
            RunLoop.current.run()
        } while (true)
    }
}

// MARK: - Wrapping Default XCAsserts
// MARK: - Boolean
private func mockyAssert(_ expression: @autoclosure () throws -> Bool, _ message: String, file: StaticString, line: UInt) throws {
    XCTAssert(expression, message, file: file, line: line)
}

private func mockyAssertTrue(_ expression: @autoclosure () throws -> Bool, _ message: String, file: StaticString, line: UInt) throws {
    XCTAssertTrue(expression, message, file: file, line: line)
}

private func mockyAssertFalse(_ expression: @autoclosure () throws -> Bool, _ message: String, file: StaticString, line: UInt) throws {
    XCTAssertFalse(expression, message, file: file, line: line)
}

// MARK: - Optionality
private func mockyAssertNil(_ expression: @autoclosure () throws -> Any?, _ message: String, file: StaticString, line: UInt) throws {
    XCTAssertNil(expression, message, file: file, line: line)
}

private func mockyAssertNotNil(_ expression: @autoclosure () throws -> Any?, _ message: String, file: StaticString, line: UInt) throws {
    XCTAssertNotNil(expression, message, file: file, line: line)
}

// MARK: - Equatable
private func mockyAssertEqual<T>(_ expression1: @autoclosure () throws -> T, _ expression2: @autoclosure () throws -> T, _ message: String, file: StaticString, line: UInt) throws where T : Equatable {
    XCTAssertEqual(expression1, expression2, message, file: file, line: line)
}

private func mockyAssertEqual<T>(_ expression1: @autoclosure () throws -> T, _ expression2: @autoclosure () throws -> T, accuracy: T, _ message: String, file: StaticString, line: UInt) throws where T : FloatingPoint {
    XCTAssertEqual(expression1, expression2, accuracy: accuracy, message, file: file, line: line)
}

private func mockyAssertNotEqual<T>(_ expression1: @autoclosure () throws -> T, _ expression2: @autoclosure () throws -> T, _ message: String, file: StaticString, line: UInt) throws where T : Equatable {
    XCTAssertNotEqual(expression1, expression2, message, file: file, line: line)
}

private func mockyAssertNotEqual<T>(_ expression1: @autoclosure () throws -> T, _ expression2: @autoclosure () throws -> T, accuracy: T, _ message: String, file: StaticString, line: UInt) throws where T : FloatingPoint {
    XCTAssertNotEqual(expression1, expression2, accuracy: accuracy, message, file: file, line: line)
}

// MARK: - Comparable
private func mockyAssertLessThan<T>(_ expression1: @autoclosure () throws -> T, _ expression2: @autoclosure () throws -> T, _ message: String, file: StaticString, line: UInt) throws where T : Comparable {
    XCTAssertLessThan(expression1, expression2, message, file: file, line: line)
}

private func mockyAssertLessThanOrEqual<T>(_ expression1: @autoclosure () throws -> T, _ expression2: @autoclosure () throws -> T, _ message: String, file: StaticString, line: UInt) throws where T : Comparable {
    XCTAssertLessThanOrEqual(expression1, expression2, message, file: file, line: line)
}

private func mockyAssertGreaterThan<T>(_ expression1: @autoclosure () throws -> T, _ expression2: @autoclosure () throws -> T, _ message: String, file: StaticString, line: UInt) throws where T : Comparable {
    XCTAssertGreaterThan(expression1, expression2, message, file: file, line: line)
}

private func mockyAssertGreaterThanOrEqual<T>(_ expression1: @autoclosure () throws -> T, _ expression2: @autoclosure () throws -> T, _ message: String, file: StaticString, line: UInt) throws where T : Comparable {
    XCTAssertGreaterThanOrEqual(expression1, expression2, message, file: file, line: line)
}

// MARK: - Throwing
private func mockyAssertNoThrow<T>(_ expression: @autoclosure () throws -> T, _ message: String, file: StaticString, line: UInt) throws {
    XCTAssertNoThrow(expression, message, file: file, line: line)
}

private func mockyAssertThrowsError<T>(_ expression: @autoclosure () throws -> T, _ message: String, file: StaticString, line: UInt, _ errorHandler: (Error) -> Void = { _ in }) throws {
    XCTAssertThrowsError(expression, message, file: file, line: line, errorHandler)
}

// MARK: - Additional Convenience
private func mockyAssertThrowsError<T, E: Error>(_ expression: @autoclosure () throws -> T, of error: E.Type, _ message: String, file: StaticString, line: UInt) throws {
    let throwMessage = message.isEmpty ? "Expected \(T.self) thrown" : message
    XCTAssertThrowsError(expression, throwMessage, file: file, line: line) { errorThrown in
        let typeMessage = message.isEmpty ? "Expected \(T.self), got \(String(describing: errorThrown))" : message
        XCTAssertTrue(errorThrown is E, typeMessage, file: file, line: line)
    }
}

private func mockyAssertThrowsError<T, E>(_ expression: @autoclosure () throws -> T, error: E, _ message: String, file: StaticString, line: UInt) throws where E: Error, E: Equatable {
    let throwMessage = message.isEmpty ? "Expected \(error) thrown" : message
    XCTAssertThrowsError(expression, throwMessage, file: file, line: line) { errorThrown in
        let typeMessage = message.isEmpty ? "Expected \(error), got \(String(describing: errorThrown))" : message
        XCTAssertTrue((errorThrown as? E) == error, typeMessage, file: file, line: line)
    }
}
