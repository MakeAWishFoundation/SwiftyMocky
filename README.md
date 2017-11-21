[![Build Status](https://travis-ci.org/MakeAWishFoundation/SwiftyMocky.svg?branch=master)](https://travis-ci.org/MakeAWishFoundation/SwiftyMocky)
[![Docs](https://cdn.rawgit.com/MakeAWishFoundation/SwiftyMocky/master/docs/badge.svg)](https://cdn.rawgit.com/MakeAWishFoundation/SwiftyMocky/master/docs/index.html)
[![License](https://img.shields.io/cocoapods/l/SwiftyMocky.svg?style=flat)](http://cocoapods.org/pods/SwiftyMocky)
[![Platform](https://img.shields.io/cocoapods/p/SwiftyMocky.svg?style=flat)](http://cocoapods.org/pods/SwiftyMocky)
[![Version](https://img.shields.io/cocoapods/v/SwiftyMocky.svg?style=flat)](http://cocoapods.org/pods/SwiftyMocky)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

# ![logo][logo] SwiftyMocky

Join our community on Slack! -> [invitation link here][link-slack]

## Overview

**SwiftyMocky** is Lightweight, strongly typed framework for Mockito-like unit testing experience. As Swift doesn't support reflections well enough to allow building mocks in runtime, library depends on [Sourcery](https://github.com/krzysztofzablocki/Sourcery), that scans your source code and generates Swift code for you.

The idea of **SwiftyMokcy** is to mock Swift protocols. The main features are:

 - easy syntax, utilizing full power of auto-complete, which makes writing test easier and faster
 - mock implementations generation
 - a way to specify what mock will return (given)
 - possibility to specify different return values for different attributes
 - verify, whether a method was called on mock or not
 - check method invocations with specified attributes

### 1. Generating mocks implementations:

One of the boilerplate part of testing and development is writing and updating **mocks** accordingly to newest changes. SwiftyMocky is capable of generating mock implementations (with configurable behavior), based on protocol definition.

During development process it is possible to use SwiftyMocky in a *watcher* mode, which will observe changes in you project files, and regenerate files on the fly.

![Generating mock][example-watcher]

By default, all protocols marked as AutoMockable (inheriting from dummy protocol `AutoMockable` or annotated with `//sourcery: AutoMockable`) are being subject of mock implementation generation. All mocks goes to `Mock.generated.swift`, which can be imported into test target.

### 2. Stubbing return values for mock methods - Given

All mocks has **given** method (accessible both as instance method or global function), with easy to use syntax, allowing to specify what should be return values for given methods (based on specified attributes).

![Generating mock][example-given]

All protocol methods are nicely put into **Given**, with matching signature. That allows to use auto-complete (just type `.`) to see all mocked protocol methods, and specify return value for them.

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

All protocol methods are nicely put into **Verify**, with matching signature. That allows to use auto-complete (just type `.`) to see all mocked protocol methods, and specify which one we want to verify.

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

### 4. All supported features

For list all supported features, check documentation [here][link-docs-features] or [guides][link-guides-features]

### 5. Example of usage

For more examples, check out our example project.

To run the example project, clone the repo, and run `pod install` from the Example directory first.

To trigger mocks generation, run `rake mock` from root directory. For watcher mode, when mocks are generated every time you change your file projects, use `rake mock_watcher` instead.

# Documentation

Full documentation is available [here][link-docs], as well as through *docs* directory.

Guides - [Table of contents][link-guides-contents]

Changelog is available [here][link-changelog]

# How to start using SwiftyMocky

Mocks generation is based on `mocky.yml` file.

First, create file in your project root directory with following structure:

```yml
sources:
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

+ **sources**: all directories you want to scan for protocols/files marked to be auto mocked, or inline mocked
+ **templates**: path to SwiftyMocky sourcery templates, in Pods directory
+ **output**: place where `Mock.generated.swift` will be placed
+ **testable**: specify imports for Mock.generated, that should be marked as `@testable` (usually tested app module)
+ **import**: all additional imports, external libraries etc. to be placed in Mock.generated
+ **excludedSwiftLintRules**: if using swift SwiftLint.

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

@objc protocols are also supported, but needs to be explicity marked with ObjcProtocol annotation:

```swift
//sourcery: AutoMockable
//sourcery: ObjcProtocol
@objc protocol NonSwiftProtocol {
  // ...
}
```

## Roadmap

- [x] stubbing protocols in elegant way
- [x] template for generating mocks
- [x] example project
- [x] stubbing protocols with variables
- [x] method signature generation without name conflicts
- [ ] cover 95% of framework codebase with unit tests
- [ ] add unit tests for template
- [ ] support for tvOS, Linux and MacOS
- [x] Carthage support

## Installation

SwiftyMocky is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod "SwiftyMocky"
```

Then add **mocky.yml** and **Rakefile** (or build script phase) to your project root directory, as described above.

For [Carthage](https://github.com/Carthage/Carthage) install instructions, see full [documentation][link-docs-installation].

## Current version

Master branch is stabilizing, breaking changes possible in version 2.0. For more information about upcoming changes - see issues and projects section.

## Authors

- Przemysław Wośko, wosko.przemyslaw@gmail.com
- Andrzej Michnia, amichnia@gmail.com

## License

SwiftyMocky is available under the MIT license. See the [LICENSE][link-license] file for more info.

<!-- Links -->

[link-slack]: https://join.slack.com/t/swiftymocky/shared_invite/enQtMjc0NzI5ODU3NTcxLTdmN2Q0NzQ3OWFmYTZlZmZkYTI3M2VmNzAzZDIzNWUwYjVhOTlmYWFiYzc2OGZkMzBkN2RkMmQ3NzQyMmIyNDU
[link-license]: https://github.com/MakeAWishFoundation/SwiftyMocky/blob/master/LICENSE
[link-guides-contents]: https://github.com/MakeAWishFoundation/SwiftyMocky/blob/master/guides/Contents.md
[link-guides-features]: https://github.com/MakeAWishFoundation/SwiftyMocky/blob/master/guides/Supported%20features.md
[link-changelog]: https://github.com/MakeAWishFoundation/SwiftyMocky/blob/master/guides/CHANGELOG.md

<!-- Links based on tag -->

[link-docs]: https://cdn.rawgit.com/MakeAWishFoundation/SwiftyMocky/f9a57ad0/docs/index.html
[link-docs-features]: https://cdn.rawgit.com/MakeAWishFoundation/SwiftyMocky/f9a57ad0/docs/supported-features.html
[link-docs-installation]: https://cdn.rawgit.com/MakeAWishFoundation/SwiftyMocky/f9a57ad0/docs/installation.html

<!-- Assets -->

[logo]: https://raw.githubusercontent.com/MakeAWishFoundation/SwiftyMocky/1.0.0/icon.png
[example-watcher]: https://raw.githubusercontent.com/MakeAWishFoundation/SwiftyMocky/1.0.0/guides/assets/example-watcher.gif "Example - generation"
[example-given]: https://raw.githubusercontent.com/MakeAWishFoundation/SwiftyMocky/1.0.0/guides/assets/example-given.gif "Example - given"
[example-verify]: https://raw.githubusercontent.com/MakeAWishFoundation/SwiftyMocky/1.0.0/guides/assets/example-verify.gif "Example - verify"
