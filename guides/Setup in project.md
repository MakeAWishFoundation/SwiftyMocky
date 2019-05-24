# How to setup SwiftyMocky

First, install **CLI** as described in "Command Line Interface" section.

Then, you can use:

```bash
> swiftymocky setup # For automatic setup (preferred)
```

or

```bash
> swiftymocky init # Just generate placeholder for Mockfile you can fill manually
```

> It is also worth to look into "Mockfile" section.

## Generate mocks:

[Annotate your protocols](#mock-annotate) that are going to be mocked, making them adopt `AutoMockable` protocol, or adding annotation comment above their definition in the source code.

Mocks are generated from your project root directory, based on configuration inside **Mockfile**.

```bash
> swiftymocky doctor    # validate your setup
> swiftymocky generate  # generate mocks
```

**Don't forget** to add generated files like `Mock.generated.swift` to your test target :)

<a name="mock-annotate"></a>

## Marking protocols to be mocked

### **1. AutoMockable protocol**

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

### **2. AutoMockable annotation**

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
