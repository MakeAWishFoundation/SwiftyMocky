# How to setup SwiftyMocky

Mocks generation is based on `mocky.yml` file.

First, create file in your project root directory with following structure:

```yaml
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

@objc protocols are also supported, but needs to be explicity marked with ObjcProtocol annotation:

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
