# Installation

SwiftyMocky is available through:

## 1. [CocoaPods](http://cocoapods.org).
To install it, simply add the following line to your Podfile:

```ruby
pod "SwiftyMocky"
```

Then execute `pod install`

## 2. [Carthage](https://github.com/Carthage/Carthage).
To install, add following to you Cartfile:

```ruby
github "MakeAWishFoundation/SwiftyMocky"
```

Then execute `carthage update`

For Carthage, few additional steps are required:

1. Obtain [Sourcery](https://github.com/krzysztofzablocki/Sourcery) - used to generate mocks (specify valid path in generate mock)
2. Change templates path to `Carthage/Build/iOS/SwiftyMocky.framework/`
3. In your test framework **add** to:
  - **Other Swift Flags**: `-DMocky`
  - **Framework Search Paths**: `$(SRCROOT)/Carthage/Build/iOS`

## 3. Manually.
Include Sources in your project, and setup [Sourcery](https://github.com/krzysztofzablocki/Sourcery)

> **Important!!!**
>
> Main difference between how SwiftyMocky is installed, is location of sourcery binary and templates, used to generate Mocks. Whatever you choose, make sure that correct paths are setup for mocky.yml, and sourcery call.
