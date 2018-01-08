# Examples

All examples are part of example project, which contains more examples.

## Table of Contents:

1. [Example 1:](#example1) basic cases
    - [Simple protocol with methods](#example1.1)
    - [Simple protocol with methods - optional attributes](#example1.2)
    - [Simple protocol with properties](#example1.3)
    - [Protocol, that adopts other protocols](#example1.4)
2. [Example 2:](#example2) throwing
    - [Simple protocol with methods that throws](#example2.1)
3. [Example 3:](#example3) custom attributes
    - [Simple protocol with methods using tuples](#example3.1)
    - [Simple protocol with methods using custom type](#example3.2)
4. [Example 4:](#example4) static
    - [Simple protocol with static methods and properties](#example4.1)
5. [Example 5:](#example5) closures as attributes
    - [Working with non escaping closures](#example5.1)
    - [Working with escaping closures](#example5.2)
    - [Using completion block based approach](#example5.3)
6. [Example 6:](#example6) protocol with initializers requirement
7. [Example 7:](#example7) generics
    - [Protocol with generic methods](#example7.1)
    - [Protocol with associated types](#example7.2)

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

### <a name="example1.4"></a> Protocol, that adopts other protocols

By default, SwiftyMocky will generate Mock, adopting all methods/properties gathered from all protocols, so it will support

Protocol definition:

```swift
//sourcery: AutoMockable
protocol SimpleProtocolWithMethods {
    func simpleMethod()
    func simpleMehtodThatReturns() -> Int
    func simpleMehtodThatReturns(param: String) -> String
    func simpleMehtodThatReturns(optionalParam: String?) -> String?
}

//sourcery: AutoMockable
protocol SimpleProtocolWithProperties {
    var property: String { get set }
    weak var weakProperty: AnyObject! { get set }
    var propertyGetOnly: String { get }
    var propertyOptional: Int? { get set }
    var propertyImplicit: Int! { get set }
}

//sourcery: AutoMockable
protocol SimpleProtocolThatInheritsOtherProtocols: SimpleProtocolWithMethods, SimpleProtocolWithProperties {

}
```

Test - setup mock:

```swift
func test_simpleProtocol_that_inherits() {
    let mock = SimpleProtocolThatInheritsOtherProtocolsMock()

    XCTAssert(mock is SimpleProtocolWithProperties)
    XCTAssert(mock is SimpleProtocolWithMethods)
    ...
}
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

## <a name="example4"></a> Example 4:

Protocol that have static members.

### <a name="example4.1"></a> Simple protocol with static methods and properties

Protocol definition:

```swift
//sourcery: AutoMockable
protocol ProtocolWithStaticMembers {
    static var staticProperty: String { get }
    static func staticMethod(param: Int) throws -> Int
}
```

Test - usage of `Given` and `Verify` with static members.

```swift
// Static members are handled similar way - but instead of instance
// you pass its type to Verify and Given calls

// Static properties should be set with default values - same as with instance ones
ProtocolWithStaticMembersMock.staticProperty = "value"

Given(ProtocolWithStaticMembersMock.self, .staticMethod(param: .value(0), willReturn: 1))
Given(ProtocolWithStaticMembersMock.self, .staticMethod(param: .value(1), willReturn: 2))
Given(ProtocolWithStaticMembersMock.self, .staticMethod(param: .any, willThrow: SimpleTestError.failure))

XCTAssertEqual(ProtocolWithStaticMembersMock.staticProperty, "value")
XCTAssertEqual(try? ProtocolWithStaticMembersMock.staticMethod(param: 0), 1)
XCTAssertEqual(try? ProtocolWithStaticMembersMock.staticMethod(param: 1), 2)
XCTAssertThrowsError(try ProtocolWithStaticMembersMock.staticMethod(param: -3))
XCTAssertThrowsError(try ProtocolWithStaticMembersMock.staticMethod(param: 2))

Verify(ProtocolWithStaticMembersMock.self, 4, .staticMethod(param: .any))
```

## <a name="example5"></a> Example 5:

Protocol that has methods with attributes being closures.

Protocol definition:

```swift
//sourcery: AutoMockable
protocol ProtocolWithClosures {
    func methodThatTakes(closure: (Int) -> Int)
    func methodThatTakesEscaping(closure: @escaping (Int) -> Int)
    func methodThatTakesCompletionBlock(completion: (Bool,Error?) -> Void)
}
```

### <a name="example5.1"></a> Working with non escaping closures

For non escaping closures - every parameter defined as .value(...) is always treated as .any

Sample test:

```swift
let mock = ProtocolWithClosuresMock()

mock.methodThatTakes(closure: { $0 })
mock.methodThatTakes(closure: { $0 * 2 })

Verify(mock, 2, .methodThatTakes(closure: .any))
// For non escaping closures - every .value(...) is always treated as .any
Verify(mock, 2, .methodThatTakes(closure: .value({ $0 })))
```

### <a name="example5.2"></a> Working with escaping closures

There is no limitation as above for escaping closures. Still it makes little sense to compare two closures.

Sample test:

```swift
let mock = ProtocolWithClosuresMock()

mock.methodThatTakesEscaping(closure: { $0 })
mock.methodThatTakesEscaping(closure: { $0 * 2 })

// It is possible to check based on .value(...) for escaping closures
// It requires to register closure comparator to Matcher
// Nevertheless - we have not found ane good reason to do that yet :)
Matcher.default.register(((Int) -> Int).self) { (lhs, rhs) -> Bool in
    return lhs(1) == rhs(1) && lhs(2) == rhs(2)
}

Verify(mock, 2, .methodThatTakesEscaping(closure: .any))
Verify(mock, 1, .methodThatTakesEscaping(closure: .value({ $0 })))
```

### <a name="example5.3"></a> Using completion block based approach

In these cases, we usually need to execute completion block specified as method attribute. For that, we can use `Perform`, to specify closure, that will execute upon method invocation.

Sample test:

```swift
let mock = ProtocolWithClosuresMock()

let calledCompletionBlock = expectation(description: "Should call completion block")

// Perform allows to execute given closure, with all the method parameters, as soon as it is being called
Perform(mock, .methodThatTakesCompletionBlock(completion: .any, perform: { (completion) in
    completion(true,nil)
}))

mock.methodThatTakesCompletionBlock { (success, error) in
    calledCompletionBlock.fulfill()
    XCTAssertTrue(success)
    XCTAssertNil(error)
}

waitForExpectations(timeout: 0.5) { (error) in
    guard let error = error else { return }
    XCTFail("Error: \(error)")
}
```
## <a name="example6"></a> Example 6:

Protocol that has initializer requirements.

Protocol definition:

```swift
//sourcery: AutoMockable
protocol ProtocolWithInitializers {
    var param: Int { get }
    var other: String { get }

    init(param: Int, other: String)
    init(param: Int)
}
```

Sample test setup:

```swift
// You can use all required initializers
let mock1 = ProtocolWithInitializersMock(param: 1)
let mock2 = ProtocolWithInitializersMock(param: 2, other: "something")

// Please hav in mind, that they are only to satisfy protocol requirements
// there is no logic behind that, and so all properties has to be set manually anyway
mock1.param = 1
mock1.other = ""
mock2.param = 2
mock2.other = "something"
```

## <a name="example7"></a> Example 7:

SwiftyMocky has support for generic protocols:


### <a name="example7.1"></a> Protocol with generic methods

When working with generic methods, as in following protocol definition, there are some additional requirements and limitations.

Protocol definition:

```swift
//sourcery: AutoMockable
protocol ProtocolWithGenericMethods {
    func methodWithGeneric<T>(lhs: T, rhs: T) -> Bool
    func methodWithGenericConstraint<U>(param: [U]) -> U where U: Equatable
}
```

Sample test when using generic methods:

```swift
let mock = ProtocolWithGenericMethodsMock()

// For generics - you have to use .any(ValueType.Type) to avoid ambiguity
Given(mock, .methodWithGeneric(lhs: .any(Int.self), rhs: .any(Int.self), willReturn: false))
Given(mock, .methodWithGeneric(lhs: .any(String.self), rhs: .any(String.self), willReturn: true))
// In that case it is enough to specify type for only one elemen, so the type inference could do the rest
Given(mock, .methodWithGeneric(lhs: .value(1), rhs: .any, willReturn: true))

// Also, for generics default comparators for equatable and sequence types breaks - so even for
// simple types like Int or String, you have to register comparator
// Foe equatable, you can use simplified syntax:
Matcher.default.register(Int.self)
Matcher.default.register(String.self)

XCTAssertEqual(mock.methodWithGeneric(lhs: 1, rhs: 0), true)
XCTAssertEqual(mock.methodWithGeneric(lhs: 0, rhs: 1), false)
XCTAssertEqual(mock.methodWithGeneric(lhs: "0", rhs: "1"), true)

// Same applies to verify - specify type to avoid ambiguity
Verify(mock, 2, .methodWithGeneric(lhs: .any(Int.self), rhs: .any(Int.self)))
Verify(mock, 1, .methodWithGeneric(lhs: .any(String.self), rhs: .any(String.self)))
```

### <a name="example7.2"></a> Protocol with associated types

All mocks for protocols with associated types requires additional annotations - one per every associated type. The mock will be generated as generic class.

Protocol definition:

```swift
//sourcery: AutoMockable
//sourcery: associatedtype = "T: Sequence"
protocol ProtocolWithAssociatedType {
    associatedtype T: Sequence

    var sequence: T { get }

    func methodWithType(t: T) -> Bool
}
```

Sample test when using mock adopting protocol with associated types:

```swift
let mock = ProtocolWithAssociatedTypeMock<[Int]>()
mock.sequence = [1,2,3]

// For generics - default comparators for equatable and sequence types breaks - so even for
// simple types like Int or String, you have to register comparator
// Foe equatable, you can use simplified syntax:
Matcher.default.register(Int.self)

// There is autocomplete issue, so in order to get autocomplete for all available methods
// Use full <MockName>.Given. ... syntax
Given(mock, ProtocolWithAssociatedTypeMock.Given.methodWithType(t: .any, willReturn: false))
// It works slightly better, when using given directly on mock instance
mock.given(ProtocolWithAssociatedTypeMock<[Int]>.Given.methodWithType(t: .value([1,1,1]), willReturn: true))

XCTAssertTrue(mock.methodWithType(t: [1,1,1]))
XCTAssertFalse(mock.methodWithType(t: [2,2]))

// Similar here
Verify(mock, ProtocolWithAssociatedTypeMock.Verify.methodWithType(t: .value([1,1,1])))
// And also here, using method on instance works slightly better when comes to types inference
mock.verify(ProtocolWithAssociatedTypeMock<[Int]>.Verify.methodWithType(t: .value([2,2])))
```
