# Mocky

**Mocky** is Lightweight, strongly typed framework for Mockito-like unit testing experience. As Swift doesn't support reflections well enough to allow building mocks in runtime, library depends on Sourcery, that scans your source code and generates Swift code for you.

## Current version

Master branch is still in beta, breaking changes are possible.

## Overview

The idea of **SwiftyMokcy** is to mock Swift protocols. The main features are:

 - easy syntax, utilizing full power of auto-complete, which makes writing test easier and faster
 - mock implementations generation
 - a way to specify what mock will return (given)
 - possibility to specify different return values for different attributes
 - verify, whether a method was called on mock or not
 - check method invocations with specified attributes

### 1. Generating mocks implementations:

One of the boilerplate part of testing and development is writing and updating **mocks** accordingly to newest changes. Mocky is capable of generating mock implementations (with configurable behavior), based on protocol definition.

During development process it is possible to use Mocky in a *watcher* mode, which will observe changes in you project files, and regenerate files on the fly.

![Generating mock][example-watcher]

By default, all protocols marked as AutoMockable (inheriting from dummy protocol `AutoMockable` or annotated with `//sourcery: AutoMockable`) are being subject of mock implementation generation. All mocks goes to `Mock.generated.swift`, which can be imported into test target.

### 2. Stubbing return values for mock metods - Given

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

### 3. Check invocations of methods - Verify

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

// check is Jon Snow was stored at least one time
Verify(mockStorage, .storeUser(name: .value("Jon"), surname: .value("Snow")))
// total storeUser should be triggered 3 times, regardless of attributes values
Verify(mockStorage, 3, .storeUser(name: .any(String.self), surname: .any(String.self)))
// two times it should be triggered with name Johny
Verify(mockStorage, 2, .storeUser(name: .value("Johny"), surname: .any(String.self)))
```

### 4. Example of usage

ItemsModelMock can be used for stubbibg return value and veryfying invocations of methods. Following example shows test that uses generated mock:

```
class ItemsViewModelTests: XCTestCase {
    var sut: ItemsViewModel!
    var itemsModelMock: ItemsModelMock!

    override func setUp() {
        // ...
    }

    override func tearDown() {
        // ...
    }

    func test_fetchItems() {
        // specify stub return values
        Given(itemsModelMock, .getExampleItems(willReturn: [1,2,3,4]))
        sut.fetchData()
        // verify sut triggered method in mock
        Verify(itemsModelMock, .getExampleItems())
    }
}
```

For more examples, check out our example project.

## Mocks generation - How to start using mocky

Mocks generation is based on `config.yml` file.

First, create file in your project root directory with following structure:

```yml
sources:
  - ./ExampleApp
  - ./ExampleAppTests
templates:
  - ./Pods/Mocky/Mocky/Templates
output:
  ./ExampleApp
args:
  testable:
    - ExampleApp
  import:
    - RxSwift
    - RxBlocking
```

+ **sources**: all directories you want to scan for protocols/files marked to be auto mocked, or inline mocked
+ **templates**: path to Mocky sourcery templates, in Pods directory
+ **output**: place where `Mock.generated.swift` will be placed
+ **testable**: specify imports for Mock.generated, that should be marked as `@testable` (usually tested app module)
+ **import**: all additional imports, external libraries etc. to be placed in Mock.generated

Generate mocks:
1. **manually**: by triggering `Pods/Sourcery/bin/sourcery --config <your config yml path> --disableCache`
1. **in `watch` mode**: changed methods will be reflected in mocks, after generation of mock, by triggering `Pods/Sourcery/bin/sourcery --config <your config yml path> --disableCache --watch`

Add `Mock.generated.swift` to your test target.

## Marking protocols to be mocked

### 1. AutoMockable annotation

Mark protocols that are meant to be mocked with sourcery annotation as following:

```swift
//sourcery: AutoMockable
protocol ToBeMocked {
  // ...
}
```

Every protocol in source directories, having this annotation, will be added to `Mock.generated.swift`

### 2. AutoMockable protocol

Create dummy protocol for you project:

```swift
protocol AutoMockable { }
```

Every protocol in source directories, inheriting (directly!) from AutoMockable, will be added to `Mock.generated.swift`, like:

```swift
protocol ToBeMocked, AutoMockable {
  // ...
}
```

### 3. Manual annotation

In some rare cases, when you don't want to use `Mock.generated.swift`, or needs to add additional code to generated mock, you can create base for mock implementation yourself. It will look something like following:

```swift
import Foundation
import Mocky
import XCTest
@testable import TestedApp

// sourcery: mock = "ToBeMocked"
class SomeCustomMock: ToBeMocked, Mock {
  Your custom code can go here

  // sourcery:inline:auto:ToBeMocked.autoMocked

  Generated code goes here

  // sourcery:end
}
```

## Roadmap

- [x] stubbibg protocols in elegant way
- [x] template for generating mocks
- [x] example project
- [x] stubbing protocols with variables ( for now, IUO and Optional types are supported)
- [x] method signature generation without name conflicts
- [ ] cover 95% of framework codebase with unit tests
- [ ] add unit tests for template
- [ ] support for tvOS, Linux and MacOS
- [ ] Carthage support

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

To trigger mocks generation, run `rake mock` from the Example directory. For watcher mode, when mocks are generated every time you change your file projects, use `rake mock_watcher` instead.

## Installation

Mocky is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod "Mocky"
```

## Author

Przemysław Wośko, przemyslaw.wosko@intive.com

## Contributors

Andrzej Michnia, amichnia@gmail.com

## License

Mocky is available under the MIT license. See the LICENSE file for more info.

<!-- Assets -->

[example-watcher]: Docs/example-watcher.gif "Example - generation"
[example-given]: Docs/example-given.gif "Example - given"
[example-verify]: Docs/example-verify.gif "Example - verify"
