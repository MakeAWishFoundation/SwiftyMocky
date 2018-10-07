# How to setup SwiftyMocky

Mocks generation is based on `mocky.yml` file.

First, create file in your project root directory with following structure:

```yaml
sources:
  include:
    - ./ExampleApp
    - ./ExampleAppTests
templates:
  - ./Pods/SwiftyMocky/Sources/Templates # Different for Carthage installation
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

> ** Please note!**
> In some cases (for example when using R.swift for assets management), there are big generated swift files involved, that can extend time of generating mocks.
> In such cases, you can exclude particular files from whole process, using `exclude` in same way as `include` in config.yml.

## Setup Sourcery (optional):

In some cases Sourcery that is downloaded with Pods installation does not match for example Swift version you are using. With cocoapods installation we ship `get_sourcery.sh` script, to override it with newer/older version of binary.

For that case refer "Known Issues" page.

## Setup for Sourcery users (alternative to mocky.yml):

We know that Sourcery is a powerful tool and you are likely to use it already. You can easily integrate SwiftyMocky with your project with keeping all already written templates working.

All you have to do is add path (note that path can be different for Carthage/manual installation) to SwiftyMocky templates in your `sourcery.yml` file:

```yaml
sources:
    - ./ExampleApp
    - ./ExampleAppTests
templates:
    - <templates path> # Path to already written Sourcery templates
    - ./Pods/SwiftyMocky/Sources/Templates # <- SwiftyMocky templates
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

You can use all arguments (like `testable`, `import`, etc.) in the same way as in `mocky.yaml`, under `args` key.

## Generate mocks:

1. **manually**: by triggering:

  `Pods/Sourcery/bin/Sourcery.app/Contents/MacOS/Sourcery --config mocky.yml`
1. **in `watch` mode**: changed methods will be reflected in mocks, after generation of mock, by triggering:

  `Pods/Sourcery/bin/Sourcery.app/Contents/MacOS/Sourcery --config mocky.yml --watch`


**Don't forget** to add `Mock.generated.swift` to your test target :)

> **Please Note!**
> Most convenient way is to put generation in some kind of script - like Rakefile below.
> Just create file named Rakefile - generation is triggered by `rake mock`
> ```ruby
> # Rakefile
> task :mock do
>   sh "Pods/Sourcery/bin/Sourcery.app/Contents/MacOS/Sourcery --config mocky.yml"
> end
>
> task :mock_watcher do
>   sh "Pods/Sourcery/bin/Sourcery.app/Contents/MacOS/Sourcery --config mocky.yml --watch"
> end
> ```

## Marking protocols to be mocked

### **1. AutoMockable annotation**

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

### **2. AutoMockable protocol**

Create dummy protocol for you project:

```swift
protocol AutoMockable { }
```

Every protocol in source directories, inheriting (directly!) from AutoMockable, will be added to `Mock.generated.swift`, like:

```swift
protocol ToBeMocked: AutoMockable {
  // ...
}
```

### **3. Manual annotation**

In some rare cases, when you don't want to use `Mock.generated.swift`, or need to add some additional code to generated mock, you can create base for mock implementation yourself. It will look something like following:

```swift
import Foundation
import SwiftyMocky
import XCTest
@testable import TestedApp

// sourcery: mock = "ToBeMocked"
class SomeCustomMock: ToBeMocked, Mock {
  Your custom code can go here

  // sourcery:inline:auto:ToBeMocked.autoMocked

  Generated code goes here...

  // sourcery:end
}
```

> __Note:__
> Please have in mind, that definition of MockyAssert used in generated mocks is placed in `Mock.generated.swift`. Even when using only manual annotations, please add this file to your target.
