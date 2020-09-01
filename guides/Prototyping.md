# **Prototyping**

It is possible to use **SwiftyMocky** not in tests, but to fake/prototype inside application (works on device).

For this reason, there is an additional library extracted from **Swiftymocky**, that does not rely on XCTest framework.

Installation and generation is exactly same as with **SwiftyMocky**. Install CLI and inegrate runtime, via one of the options below, and mark target in [Mockfile](./Mockfile.md) with `prototype: true`

## Installation

## 1. [CocoaPods](http://cocoapods.org).

To install it, simply add the following line to your Podfile:

```ruby
pod "SwiftyPrototype"
```

Then execute `pod install`

## 2. [Carthage](https://github.com/Carthage/Carthage).

To install, add following to you Cartfile:

```ruby
github "MakeAWishFoundation/SwiftyMocky"
```

Then execute `carthage update` and add `SwiftyPrototype` to your target.

### 3. **[Swift Package Manager](https://swift.org/package-manager/)**:

Add **SwiftyPrototype** to you **Package.swift** dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/MakeAWishFoundation/SwiftyMocky", from: "4.0.1"),
]
```

And add `SwiftyPrototype` to your target dependencies.
