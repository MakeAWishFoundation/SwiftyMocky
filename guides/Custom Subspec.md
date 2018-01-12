# Subspecs

SwiftyMocky is divided into two main subspecs:

## 1. Core (default)

This is default subspec, everything is set up for using SwiftyMocky (and generated mocks) in test target, that depends on XCTest framework.

Its implementation of `MockyAssert` is just simple wrapper around `XCTAssert`.

> __Note:__
> Please have in mind, that definition of MockyAssert used in generated mocks is placed in `Mock.generated.swift`. Even when using inline mocks, by manual annotations (see `Setup in project` section), please add this file to your target.

## 2. Custom

This subspec drops default dependency over XCTest framework, allowing for more flexibility, both for platforms and targets you can use SwiftyMocky in. The only difference is that it does not depend on `XCTest` and `XCTAssert` anymore.

By default, its implementation of `MockyAssert` calls plain `assert` function. However, you can specify its behaviour by setting static member of `MockyAssertion` class:

```swift
MockyAssertion.handler = { (expression: Bool, message: String, file: StaticString, line: UInt) in
    ...
}
```

> __Note:__
> Although it is created for mocking in purpose of unit testing, SwiftyMocky can be also used for fast prototyping inside your main app target, with right combination of `Given` and `Perform`. We advise to use it with caution, as it is not built in order to replace 'real' implementations.

### Carthage

For carthage users there is no additional or different framework. Only difference is what you add in **Other Swift Flags**:
    - Core: `-DMocky`
    - Custom: `-DMockyCustom`
