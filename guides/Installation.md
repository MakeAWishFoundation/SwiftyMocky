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

## Support for other swift versions

Download/build Sourcery binary manually, or use prebuilt sourcery versions from: `https://github.com/MakeAWishFoundation/SwiftyMocky.wiki.git`

Currentyly we support:
- 3.1
- 4.0
- 4.0.2

**Usage from root project dir:**

```shell
sh get_sourcery.sh 4.0.2
```

**get_sourcery.sh**

```shell
[[ $# > 0 ]] && VERSION="$1" || VERSION="4.0.2"
[[ $# > 1 ]] && OUTPUT="$2" || OUTPUT="./Pods/Sourcery/bin"

echo "CLONE SOURCERY FOR $VERSION INTO $OUTPUT"
rm -r -f "$OUTPUT"
git clone -b "swift/$VERSION" --single-branch --depth 1 https://github.com/MakeAWishFoundation/SwiftyMocky.wiki.git "$OUTPUT"
```
