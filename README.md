behaviour[![Build Status](https://travis-ci.org/MakeAWishFoundation/SwiftyMocky.svg?branch=master)](https://travis-ci.org/MakeAWishFoundation/SwiftyMocky)
[![Docs](https://cdn.rawgit.com/MakeAWishFoundation/SwiftyMocky/master/docs/badge.svg)](https://cdn.rawgit.com/MakeAWishFoundation/SwiftyMocky/master/docs/index.html)
[![License](https://img.shields.io/cocoapods/l/SwiftyMocky.svg?style=flat)](http://cocoapods.org/pods/SwiftyMocky)
[![Platform](https://img.shields.io/cocoapods/p/SwiftyMocky.svg?style=flat)](http://cocoapods.org/pods/SwiftyMocky)
[![Version](https://img.shields.io/cocoapods/v/SwiftyMocky.svg?style=flat)](http://cocoapods.org/pods/SwiftyMocky)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

# ![logo][logo] SwiftyMocky

Join our community on Slack! -> [invitation link here][link-slack]

Check out [guides][link-guides-contents], or full [documentation][link-docs]

## Overview

**SwiftyMocky** is Lightweight, strongly typed framework for Mockito-like unit testing experience. As Swift doesn't support reflections well enough to allow building mocks in runtime, library depends on [Sourcery](https://github.com/krzysztofzablocki/Sourcery), that scans your source code and generates Swift code for you.

The idea of **SwiftyMocky** is to mock Swift protocols. The main features are:

 - easy syntax, utilising full power of auto-complete, which makes writing test easier and faster
 - **we DO support generics**
 - mock implementations generation
 - a way to specify what mock will return (given)
 - possibility to specify different return values for different attributes
 - record stubbed return values sequence
 - verify, whether a method was called on mock or not
 - check method invocations with specified attributes
 - it works with real device

## Installation

SwiftyMocky is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod "SwiftyMocky"
```

Then add **mocky.yml** and **Rakefile** (or build script phase) to your project root directory, as described in below. See full [setup][link-docs-setup] instructions.

For [Carthage](https://github.com/Carthage/Carthage) install instructions, see full [documentation][link-docs-installation].

### Generating mocks implementations:

One of the boilerplate part of testing and development is writing and updating **mocks** accordingly to newest changes. SwiftyMocky is capable of generating mock implementations (with configurable behavior), based on protocol definition.

During development process it is possible to use SwiftyMocky in a *watcher* mode, which will observe changes in you project files, and regenerate files on the fly.

![Generating mock][example-watcher]

By default, all protocols marked as AutoMockable (inheriting from dummy protocol `AutoMockable` or annotated with `//sourcery: AutoMockable`) are being subject of mock implementation generation. All mocks goes to `Mock.generated.swift`, which can be imported into test target.

# How to start using SwiftyMocky

Mocks generation is based on `mocky.yml` file.

First, create file in your project root directory with following structure:

```yml
sources:
  include:
    - ./ExampleApp
    - ./ExampleAppTests
templates:
  - ./Pods/SwiftyMocky/Sources/Templates
output:
  ./ExampleApp
args:
  testable:
    - ExampleApp
  import:
    - RxSwift
    - RxBlocking
  excludedSwiftLintRules:
    - force_cast
    - function_body_length
    - line_length
    - vertical_whitespace
```

+ **sources**: all directories you want to scan for protocols/files marked to be auto mocked, or inline mocked. You can use `exclude`, to prevent from scanning particular files (makes sense for big `*.generated.swift` files)
+ **templates**: path to SwiftyMocky sourcery templates, in Pods directory
+ **output**: place where `Mock.generated.swift` will be placed
+ **testable**: specify imports for Mock.generated, that should be marked as `@testable` (usually tested app module)
+ **import**: all additional imports, external libraries etc. to be placed in Mock.generated
+ **excludedSwiftLintRules**: if using swift SwiftLint.

If you are already using [Sourcery](https://github.com/krzysztofzablocki/Sourcery) with your own templates and you have configured `sourcery.yml` file, you can extend it to add support for SwiftyMocky. Click [here][link-guides-installation] for details.

## Generate mocks:

1. **manually**: by triggering:

  `Pods/Sourcery/bin/sourcery --config mocky.yml`
1. **in `watch` mode**: changed methods will be reflected in mocks, after generation of mock, by triggering:

  `Pods/Sourcery/bin/sourcery --config mocky.yml --watch`

> **!!! In case of incompatibile swift module versions error** - check Known issues section in guides or docs

**Don't forget** to add `Mock.generated.swift` to your test target :)

> **Please Note!**
> Most convenient way is to put generation in some kind of script - like Rakefile below.
> Just create file named Rakefile - generation is triggered by `rake mock`
> ```ruby
> # Rakefile
> task :mock do
>   sh "Pods/Sourcery/bin/sourcery --config mocky.yml"
> end
>
> task :mock_watcher do
>   sh "Pods/Sourcery/bin/sourcery --config mocky.yml --watch"
> end
> ```

## Marking protocols to be mocked

Mark protocols that are meant to be mocked with sourcery annotation as following:

```swift
//sourcery: AutoMockable
protocol ToBeMocked {
  // ...
}
```

Every protocol in source directories, having this annotation, will be added to `Mock.generated.swift`

@objc protocols are also supported, but needs to be explicitly marked with ObjcProtocol annotation:

```swift
//sourcery: AutoMockable
//sourcery: ObjcProtocol
@objc protocol NonSwiftProtocol {
  // ...
}
```

### Stubbing return values for mock methods - **Given**

All mocks has **given** method (accessible both as instance method or global function), with easy to use syntax, allowing to specify what should be return values for given methods (based on specified attributes).

![Generating mock][example-given]

All protocol methods are nicely put into **Given**, with matching signature. That allows to use auto-complete (just type `.`) to see all mocked protocol methods, and specify return value for them.

All method attributes are wrapped as **Parameter** enum, allowing to choose between `any` and `value`, giving great flexibility to mock behaviour. Please consider following:

```swift
Given(mock, .surname(for name: .value("Johnny"), willReturn: "Bravo"))
Given(mock, .surname(for name: .any, willReturn: "Kowalsky"))

print(mock.surname(for: "Johny"))   // Bravo
print(mock.surname(for: "Mathew"))  // Kowalsky
print(mock.surname(for: "Joanna"))  // Kowalsky
```

In verions 3.0 we introduced sequences and policies for better control of mock behvaiour.

```swift
Given(mock, .surname(for name: .any, willReturn: "Bravo", "Kowalsky", "Nguyen"))

print(mock.surname(for: "Johny"))   // Bravo
print(mock.surname(for: "Johny"))   // Kowalsky
print(mock.surname(for: "Johny"))   // Nguyen
print(mock.surname(for: "Johny"))   // and again Bravo
// ...
```

For more details please see full [documentation][link-docs].

### Check invocations of methods, subscripts and properties - **Verify**

All mocks has **verify** method (accessible both as instance method or global function), with easy to use syntax, allowing to verify, whether a method was called on mock, and how many times. It also provides convenient way to specify, whether method attributes matters (and which ones).

![Generating mock][example-verify]

All protocol methods are nicely put into **Verify**, with matching signature. That allows to use auto-complete (just type `.`) to see all mocked protocol methods, and specify which one we want to verify.

All method attributes are wrapped as **Parameter** enum, allowing to choose between `any`, `value` and `matching`, giving great flexibility to tests. Please consider following:

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
// storeUser method should be triggered at least 2 times with name longer than 3
Verify(mockStorage, .moreOrEqual(to: 2), .storeUser(name: .matching({ $0.count > 3 }}), surname: .any))
```

For **Verify**, you can use **Count** to specify how many times you expect something to be triggered. **Count** can be defined as explicit value, like `1`,`2`,... or in more descriptive and flexible way, like `.never`, `more(than: 1)`, etc.

From SwiftyMocky 3.0, it is possible to use `Given` and perform `Verify` on properties as well, with respect to whether it is get or set:

```swift
mock.name = "Danny"
mock.name = "Joanna"

print(mock.name)

// Verify getter:
Verify(mock, 1, .name)
// Verify setter:
Verify(mock, 2, .name(set: .any))
Verify(mock, 1, .name(set: .value("Danny")))
Verify(mock, .never, .name(set: .value("Bishop")))
```

The old `VerifyProperty` is now deprecated. We also deprecated using setters for readonly properties, in favour of using `Given`.

### All supported features

For list all supported features, check documentation [here][link-docs-features] or [guides][link-guides-features]

### Example of usage

For more examples, check out our example project, or examples section in [guides][link-guides-examples].

To run the example project, clone the repo, and run `pod install` from the Example directory first.

To trigger mocks generation, run `rake mock` from root directory. For watcher mode, when mocks are generated every time you change your file projects, use `rake mock_watcher` instead.

# Documentation

Full documentation is available [here][link-docs], as well as through *docs* directory.

Guides - [Table of contents][link-guides-contents]

Changelog is available [here][link-changelog]

## Roadmap

- [x] stubbing protocols in elegant way
- [x] template for generating mocks
- [x] example project
- [x] stubbing protocols with variables
- [x] method signature generation without name conflicts
- [ ] cover 95% of framework codebase with unit tests
- [x] cover 95% of framework codebase with documentation
- [ ] add unit tests for template
- [x] support for tvOS, Linux and MacOS
- [x] Carthage support
- [x] Subscripts support
- [x] Stub return values as sequences
- [ ] Simple tool simplifying configuration process

## Current version

As we value stability, there should be no breaking changes in version 3.1.0. Nevertheless, we explicitly marked some parts as deprecated, as they will be removed in version 3.2.x. The main reason is because we want to simplify and unify mocking experience.

## Authors

- Przemysław Wośko, wosko.przemyslaw@gmail.com
- Andrzej Michnia, amichnia@gmail.com

## License

SwiftyMocky is available under the MIT license. See the [LICENSE][link-license] file for more info.

<!-- Links -->

[link-slack]: https://join.slack.com/t/swiftymocky/shared_invite/enQtMjkwNDE1NjY5MjA3LTU2YjA4YTI3NDE5MzNkZTU4MzlmMzkwYmUzNzRiNWRlN2U5NmUyMDNkN2U0NGE2ZDkxYTU4NGViYzIxYjc5ZmE
[link-license]: ./LICENSE
[link-guides-installation]: ./guides/Setup%20in%20project.md
[link-guides-setup]: ./guides/Installation.md
[link-guides-contents]: ./guides/Contents.md
[link-guides-features]: ./guides/Supported%20features.md
[link-guides-examples]: ./guides/Examples.md
[link-changelog]: ./guides/CHANGELOG.md

<!-- Links based on tag -->

[link-docs]: https://cdn.rawgit.com/MakeAWishFoundation/SwiftyMocky/3.0.0/docs/index.html
[link-docs-features]: https://cdn.rawgit.com/MakeAWishFoundation/SwiftyMocky/3.0.0/docs/supported-features.html
[link-docs-installation]: https://cdn.rawgit.com/MakeAWishFoundation/SwiftyMocky/3.0.0/docs/installation.html
[link-docs-setup]: https://cdn.rawgit.com/MakeAWishFoundation/SwiftyMocky/3.0.0/docs/setup-in-project.html

<!-- Assets -->

[logo]: https://raw.githubusercontent.com/MakeAWishFoundation/SwiftyMocky/1.0.0/icon.png
[example-watcher]: https://raw.githubusercontent.com/MakeAWishFoundation/SwiftyMocky/1.0.0/guides/assets/example-watcher.gif "Example - generation"
[example-given]: https://raw.githubusercontent.com/MakeAWishFoundation/SwiftyMocky/1.0.0/guides/assets/example-given.gif "Example - given"
[example-verify]: https://raw.githubusercontent.com/MakeAWishFoundation/SwiftyMocky/1.0.0/guides/assets/example-verify.gif "Example - verify"
