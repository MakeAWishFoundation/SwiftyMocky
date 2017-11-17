# SwiftyMocky

## Overview

**SwiftyMocky** is Lightweight, strongly typed framework for Mockito-like unit testing experience. As Swift doesn't support reflections well enough to allow building mocks in runtime, library depends on [Sourcery](https://github.com/krzysztofzablocki/Sourcery), that scans your source code and generates Swift code for you.

The idea of **SwiftyMokcy** is to mock Swift protocols. The main features are:

 - easy syntax, utilizing full power of auto-complete, which makes writing test easier and faster
 - mock implementations generation
 - a way to specify what mock will return (given)
 - possibility to specify different return values for different attributes
 - verify, whether a method was called on mock or not
 - check method invocations with specified attributes

### **1. Generating mocks implementations:**

One of the boilerplate part of testing and development is writing and updating **mocks** accordingly to newest changes. SwiftyMocky is capable of generating mock implementations (with configurable behavior), based on protocol definition.

During development process it is possible to use SwiftyMocky in a *watcher* mode, which will observe changes in you project files, and regenerate files on the fly.

![Generating mock][example-watcher]

By default, all protocols marked as AutoMockable (inheriting from dummy protocol `AutoMockable` or annotated with `//sourcery: AutoMockable`) are being subject of mock implementation generation. All mocks goes to `Mock.generated.swift`, which can be imported into test target.

### **2. Stubbing return values for mock methods - Given**

All mocks has **given** method (accessible both as instance method or global function), with easy to use syntax, allowing to specify what should be return values for given methods (based on specified attributes).

![Generating mock][example-given]

All protocol methods are nicely put into **MethodProxy**, with matching signature. That allows to use auto-complete (just type `.`) to see all mocked protocol methods, and specify return value for them.

All method attributes are wrapped as **Parameter** enum, allowing to choose between `any` and `value`, giving great flexibility to mock behaviour. Please consider following:

```swift
Given(mock, .surname(for name: .value("Johnny"), willReturn: "Bravo"))
Given(mock, .surname(for name: .any(String.self), willReturn: "Kowalsky"))

print(mock.surname(for: "Johny")) // Bravo
print(mock.surname(for: "Mathew")) // Kowalsky
print(mock.surname(for: "Joanna")) // Kowalsky
```

### **3. Check invocations of methods - Verify**

All mocks has **verify** method (accessible both as instance method or global function), with easy to use syntax, allowing to verify, whether a method was called on mock, and how many times. It also provides convenient way to specify, whether method attributes matters (and which ones).

![Generating mock][example-verify]

All protocol methods are nicely put into **VerificationProxy**, with matching signature. That allows to use auto-complete (just type `.`) to see all mocked protocol methods, and specify which one we want to verify.

All method attributes are wrapped as **Parameter** enum, allowing to choose between `any` and `value`, giving great flexibility to tests. Please consider following:

```swift
// inject mock to sut. Every time sut saves user data, it should trigger storage storeUser method
sut.usersStorage = mockStorage
sut.saveUser(name: "Johny", surname: "Bravo")
sut.saveUser(name: "Johny", surname: "Cage")
sut.saveUser(name: "Jon", surname: "Snow")

// check if Jon Snow was stored at least one time
Verify(mockStorage, .storeUser(name: .value("Jon"), surname: .value("Snow")))
// storeUser method should be triggered 3 times in total, regardless of attributes values
Verify(mockStorage, 3, .storeUser(name: .any, surname: .any))
// storeUser method should be triggered 2 times with name Johny
Verify(mockStorage, 2, .storeUser(name: .value("Johny"), surname: .any))
```

## Current version

Master branch is still in beta, breaking changes are possible.

## Authors

- Przemysław Wośko, wosko.przemyslaw@gmail.com
- Andrzej Michnia, amichnia@gmail.com

## License

SwiftyMocky is available under the MIT license. See the LICENSE file for more info.

<!-- Assets -->

[example-watcher]: ../guides/assets/example-watcher.gif "Example - generation"
[example-given]: ../guides/assets/example-given.gif "Example - given"
[example-verify]: ../guides/assets/example-verify.gif "Example - verify"
