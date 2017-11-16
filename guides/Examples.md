# Examples

All examples are part of example project, which contains more examples.

## Table of Contents:

1. [Example 1:](#example1) basic cases
    - [Simple protocol with methods](#example1.1)
    - [Simple protocol with methods - optional attributes](#example1.2)
    - [Simple protocol with properties](#example1.3)
2. [Example 2:](#example2) throwing
    - [Simple protocol with methods that throws](#example2.1)
3. [Example 3:](#example3) custom attributes
    - [Simple protocol with methods using tuples](#example3.1)
    - [Simple protocol with methods using custom type](#example3.2)

## <a name="example1"></a> Example 1:

Simple protocols with example of setting up and verifying methods and properties.

### <a name="example1.1"></a> Simple protocol with methods

Protocol definition:

```swift
//sourcery: AutoMockable
protocol SimpleProtocolWithMethods {
    func simpleMethod()
    func simpleMehtodThatReturns() -> Int
    func simpleMehtodThatReturns(param: String) -> String
    func simpleMehtodThatReturns(optionalParam: String?) -> String?
}
```

Test - usage of `Given` to specify stubbed methods return values, based on passed attributes, and `Verify` to check invocations count:

```swift
let mock = SimpleProtocolWithMethodsMock()

Verify(mock, 0, .simpleMehtodThatReturns(param: .any)) // Should be 0

// Regardless of registrations order, first will check most explicit given values
Given(mock, .simpleMehtodThatReturns(param: .value("a"), willReturn: "A"))
Given(mock, .simpleMehtodThatReturns(param: .value("b"), willReturn: "B"))
Given(mock, .simpleMehtodThatReturns(param: .any, willReturn: "default"))

XCTAssertEqual(mock.simpleMehtodThatReturns(param: "any parameter"), "default")
XCTAssertEqual(mock.simpleMehtodThatReturns(param: "a"), "A")
XCTAssertEqual(mock.simpleMehtodThatReturns(param: "b"), "B")
XCTAssertEqual(mock.simpleMehtodThatReturns(param: "any parameter"), "default")

mock.simpleMethod()
mock.simpleMethod()

Verify(mock, .simpleMethod()) // Should be 1+
Verify(mock, 4, .simpleMehtodThatReturns(param: .any)) // Total method invocations count should be 4
Verify(mock, 2, .simpleMehtodThatReturns(param: .value("any parameter"))) // Should be called twice wth "any parameter"
Verify(mock, 1, .simpleMehtodThatReturns(param: .value("a")))
Verify(mock, 1, .simpleMehtodThatReturns(param: .value("b")))
```

### <a name="example1.2"></a> Simple protocol with methods - optional attributes

When handling optional attributes, it requires to register types in Matcher, in order to perform proper check of attributes values (for now - will simplify that in 2.0). As long as you are using Parameter.value - you should register its type.

Protocol definition:

```swift
//sourcery: AutoMockable
protocol SimpleProtocolWithMethods {
    func simpleMethod()
    func simpleMehtodThatReturns() -> Int
    func simpleMehtodThatReturns(param: String) -> String
    func simpleMehtodThatReturns(optionalParam: String?) -> String?
}
```

Test - usage of `Given` and `Verify` constrained by optional parameter value:

```swift
let mock = SimpleProtocolWithMethodsMock()

// As String? is not recognized as Equatable, we need to register comparator on matcher
mock.matcher.register((Optional<String>).self) { $0 == $1 } // Could use Matcher.default instead, as it is default matcher for all mocks

Verify(mock, 0, .simpleMehtodThatReturns(optionalParam: .any)) // Should be 0

// When same level of explicity - last given is matched first
Given(mock, .simpleMehtodThatReturns(optionalParam: .value(nil), willReturn: nil))
XCTAssertEqual(mock.simpleMehtodThatReturns(optionalParam: nil), nil)
Given(mock, .simpleMehtodThatReturns(optionalParam: .value("some"), willReturn: "not nil"))
Given(mock, .simpleMehtodThatReturns(optionalParam: .value(nil), willReturn: "is nil"))

XCTAssertNotEqual(mock.simpleMehtodThatReturns(optionalParam: nil), nil)
XCTAssertEqual(mock.simpleMehtodThatReturns(optionalParam: nil), "is nil")
XCTAssertEqual(mock.simpleMehtodThatReturns(optionalParam: "some"), "not nil")

Verify(mock, 4, .simpleMehtodThatReturns(optionalParam: .any))
Verify(mock, 3, .simpleMehtodThatReturns(optionalParam: .value(nil)))
```

### <a name="example1.3"></a> Simple protocol with properties

As it is impossible to auto-generate default values for properties, for all properties that are not optional (or are implicitely unwrapped) default values should be set manually, before usage. Otherwise, fatalError will occur.

By default, we auto generate both getters and setters for methods (regardless of its get/set attributes).

Protocol definition:

```swift
//sourcery: AutoMockable
protocol SimpleProtocolWithProperties {
    var property: String { get set }
    weak var weakProperty: AnyObject! { get set }
    var propertyGetOnly: String { get }
    var propertyOptional: Int? { get set }
    var propertyImplicit: Int! { get set }
}
```

Test - setup mock:

```swift
let mock = SimpleProtocolWithPropertiesMock()

// We should set all initial values for non optional parameters and implicitly unwrapped optional parameters
mock.property = "some property"
mock.propertyGetOnly = "get only ;)"
mock.propertyImplicit = 1

XCTAssertEqual(mock.property, "some property")
XCTAssertEqual(mock.propertyGetOnly, "get only ;)")
XCTAssertEqual(mock.propertyOptional, nil)
XCTAssertEqual(mock.propertyImplicit, 1)

mock.propertyOptional = 2
XCTAssertEqual(mock.propertyOptional, 2)
```

## <a name="example2"></a> Example 2:

Simple protocol that declares methods that throws. For rethrowing methods valid signatures are generated, but there is no possibility to specify thrown error value.

### <a name="example2.1"></a> Simple protocol with methods that throws

Protocol definition:

```swift
//sourcery: AutoMockable
protocol ProtocolWithThrowingMethods {
    func methodThatThrows() throws
    func methodThatReturnsAndThrows(param: Int) throws -> Bool
}
```

Test - usage of `Given` to specify stubbed methods return values and throws errors:

```swift
let mock = ProtocolWithThrowingMethodsMock()

Given(mock, .methodThatReturnsAndThrows(param: .value(200), willReturn: true))
Given(mock, .methodThatReturnsAndThrows(param: .value(404), willThrow: SimpleTestError.failure))
Given(mock, .methodThatReturnsAndThrows(param: .any, willThrow: SimpleTestError.other))

XCTAssertNoThrow(try mock.methodThatReturnsAndThrows(param: 200), "Should not throw")
XCTAssertThrowsError(try mock.methodThatReturnsAndThrows(param: 404))
XCTAssertThrowsError(try mock.methodThatReturnsAndThrows(param: 123))

Verify(mock, 3, .methodThatReturnsAndThrows(param: .any))
```

## <a name="example3"></a> Example 3:

Simple protocol that declares methods that uses more sophisticated data, that plain strings or integers.

### <a name="example3.1"></a> Simple protocol with methods using tuples

Protocol definition:

```swift
//sourcery: AutoMockable
protocol ProtocolWithTuples {
    func methodThatTakesTuple(tuple: (String,Int)) -> Int
}
```

Test - usage of `Given` to specify stubbed methods return values and throws errors:

```swift
let mock = ProtocolWithTuplesMock()

// When using only .any - no matcher registering needed
Given(mock, .methodThatTakesTuple(tuple: .any, willReturn: 0))
XCTAssertEqual(mock.methodThatTakesTuple(tuple: ("first",1)), 0)

// When using custom attributes or tuples as .value(...) - registering comparator in Matcher is required!
Matcher.default.register((String,Int).self) { (lhs, rhs) -> Bool in
    return lhs.0 == rhs.0 && lhs.1 == rhs.1
}

Given(mock, .methodThatTakesTuple(tuple: .value(("first",1)), willReturn: 1))
Given(mock, .methodThatTakesTuple(tuple: .value(("second",2)), willReturn: 2))
XCTAssertEqual(mock.methodThatTakesTuple(tuple: ("first",1)), 1)
XCTAssertEqual(mock.methodThatTakesTuple(tuple: ("second",2)), 2)
XCTAssertEqual(mock.methodThatTakesTuple(tuple: ("first",0)), 0)

Verify(mock, 4, .methodThatTakesTuple(tuple: .any))
Verify(mock, 2, .methodThatTakesTuple(tuple: .value(("first",1))))
```

### <a name="example3.2"></a> Simple protocol with methods using custom type

Protocol and object definition:

```swift
struct UserObject {
    let name: String
    let surname: String
    let age: Int
}

//sourcery: AutoMockable
protocol ProtocolWithCustomAttributes {
    func methodThatTakesUser(user: UserObject) throws
    func methodThatTakesArrayOfUsers(array: [UserObject]) -> Int
}
```

Test - usage of `Given` to specify stubbed methods return values and throws errors:


```swift
let mock = ProtocolWithCustomAttributesMock()

// Register comparing user object
// We can use registration for Array of elements, which will compare value by value
// Also, providing by default comparator for element type
Matcher.default.register([UserObject].self) { (lhs: UserObject, rhs: UserObject) -> Bool in
    guard lhs.name == rhs.name else { return false }
    guard lhs.surname == rhs.surname else { return false }
    guard lhs.age == rhs.age else { return false }
    return true
}

let user1 = UserObject(name: "Karl", surname: "Gustav", age: 90)
let user2 = UserObject(name: "Dan", surname: "Dannerson", age: 13)
Given(mock, .methodThatTakesUser(user: .value(user2), willThrow: UserVerifyError.tooYoung))
Given(mock, .methodThatTakesArrayOfUsers(array: .any, willReturn: 0))
Given(mock, .methodThatTakesArrayOfUsers(array: .value([user1, user2]), willReturn: 2))

XCTAssertNoThrow(try mock.methodThatTakesUser(user: user1), "Should not throw")
XCTAssertThrowsError(try mock.methodThatTakesUser(user: user2))
XCTAssertEqual(mock.methodThatTakesArrayOfUsers(array: [user1, user2]), 2)
XCTAssertEqual(mock.methodThatTakesArrayOfUsers(array: [user1, user2, user1]), 0)
XCTAssertEqual(mock.methodThatTakesArrayOfUsers(array: [user2, user1]), 0)
```
