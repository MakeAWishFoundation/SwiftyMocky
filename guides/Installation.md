# SwiftyMocky CLI

CLI will help you with project setup and mocks generation. Also, it supports new **Mockfile** format.

To install it:

**[Mint 🌱](https://github.com/yonaskolb/Mint)**:

```bash
> brew install mint
> mint install MakeAWishFoundation/SwiftyMocky
```

**[Marathon 🏃](https://github.com/JohnSundell/Marathon)**:

```bash
> marathon install MakeAWishFoundation/SwiftyMocky
```

> More information about **CLI** you will fund in "Command Line Interface" section. 

# SwiftyMocky Runtime installation

SwiftyMocky Runtime is available through:

## 1. [CocoaPods](http://cocoapods.org).

To install it, simply add the following line to your Podfile:

```ruby
pod "SwiftyMocky"
```

Then execute `pod install`

The integration part is described in setup page.

<a name="installation-carthage"></a>

## 2. [Carthage](https://github.com/Carthage/Carthage).

To install, add following to you Cartfile:

```ruby
github "MakeAWishFoundation/SwiftyMocky"
```

Then execute `carthage update`

For Carthage, few additional steps are required:

1. In your test target, add SwiftyMocky to linked libraries:

    ![Link binary][example-link]

2. In your test target, add new copy files phase:

    ![Link binary][example-add]

3. Select destination to frameworks, and add SwiftyMocky:

    ![Link binary][example-copy]

The integration part is described in setup page.


## 3. **[Ice Package Manager ❄️](https://github.com/jakeheis/Ice)**:

```bash
> ice add MakeAWishFoundation/SwiftyMocky
```

> It will be supported when Ice reviews PR, fallback to SwiftPM if any issues.

## 4. **[Swift Package Manager](https://swift.org/package-manager/)**:

Add **SwiftyMocky** to you **Package.swift** dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/MakeAWishFoundation/SwiftyMocky", from: "3.5.0"),
]
```

## Support for other swift versions

Download/build Sourcery binary manually, or use prebuilt sourcery versions from: `https://github.com/MakeAWishFoundation/SwiftyMocky.wiki.git`

Currentyly we support:
- 5.0
- 4.2
- 4.1

<!-- Assets -->

[example-link]: https://raw.githubusercontent.com/MakeAWishFoundation/SwiftyMocky/3.2.0/guides/assets/link-binary-with-libraries.png "Example - link binary"
[example-add]:  https://raw.githubusercontent.com/MakeAWishFoundation/SwiftyMocky/3.2.0/guides/assets/add-new-copy-files-phase.png "Example - add copy files phase"
[example-copy]: https://raw.githubusercontent.com/MakeAWishFoundation/SwiftyMocky/3.2.0/guides/assets/add-framework-tocopy-files-phase.png "Example - add SwiftyMocky to copy frameworks"
