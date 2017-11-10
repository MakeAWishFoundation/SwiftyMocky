# Matcher - handling parameters that are not Equatable

In some cases there is a need to specify return value (by `Given`) for a method, which parameters are not __*Equatable*__, or check (by Verify), whether a method was called with specific attribute which is not __*Equatable*__.

If you try to perform Given or Verify for explicit parameter, whereas its type is not Equatable, **fatalError** will occur. There are two options to handle attributes types, that are not __*Equatable*__:

**1) Use only wildcard .any parameters, or adopt Equatable**

Sometimes .any is enough, or you can provide Equatable implementation.

**2) Register comparator for that type in Matcher**

Every Mock has `matcher` variable, which is `Matcher.default` singleton instance by default.

Usage of **Matcher**:

```swift
struct User {
  let id: String
  let name: String
}

// ...

override func setUp() {
  // register all comparators for custom, non equatable attributes
  Matcher.default.register(User.self) { lhs,rhs -> Bool in
      return lhs.id == rhs.id
  }
}

func testFetchUserDetails() {
  //...
  let john = User(id: "Johny123", name: "Johny")
  // now we can safely verify explicit parameter
  Verify(mockNetwork, .fetchUserDetails(for: .value(john)))
}
```

In most cases, you don't have to register comparators for Equatable and Sequence types (as long as Sequence Elememnt is Equatable)

## Matcher for generic methods in Mocks

As generic methods and mocks are breaking generic constraints, for that particular case you also have to register comparators for Equatable / Sequence types.

There are bunch of convenience registration methods, that will simplify registrations for that case.

See **Generics** section for more information.
