# Swift Testing

SwiftyMocky reports mock failures through `XCTestObservationCenter`, which knows nothing about
Swift Testing. A `Verify` that failed inside a `@Test` therefore reported to nobody, and the test
passed. The `SwiftyMockyTesting` library fixes that: it decides per call where a failure belongs.

| What is running when the mock fails | Where the failure goes |
|---|---|
| A Swift Testing test | `Issue.record`, at the call site of `Verify` |
| An XCTest test case | the XCTest reporting, exactly as before |
| Neither | stderr, plus `assertionFailure` |

The third row matters as much as the first two. `Test.current` is a task local: it is inherited by
child tasks and by `Task {}`, but it does not survive `DispatchQueue.async` or `Task.detached`. A
mock driven from such a context has no test to report to, and staying quiet there would turn a
failed check into a passing test.

## Using it

Link `SwiftyMockyTesting` instead of `SwiftyMocky` in the test target, and regenerate the mocks:

```swift
.testTarget(
    name: "MyLibraryTests",
    dependencies: ["MyLibrary", "SwiftyMockyTesting"]
)
```

Nothing else changes. `SwiftyMockyTesting` re-exports `SwiftyMocky`, so `Given`, `Verify`,
`Perform`, `Parameter` and the rest arrive from a single import, and generated code picks the
module up on its own:

```swift
#if canImport(SwiftyMockyTesting)
import SwiftyMockyTesting
#else
import SwiftyMocky
import XCTest
#endif
```

A target that links `SwiftyMocky` alone takes the second branch and behaves as it always has. Both
frameworks can be used side by side in one target - the decision is made per call, not per target.

## Two things to know

**`swift test` needs `--enable-swift-testing`** to run Swift Testing tests against this package,
because the package declares a `swift-tools-version` below 6.0.

**CocoaPods and Carthage keep reporting to XCTest.** There is no `SwiftyMockyTesting` podspec:
the library imports `Testing` unconditionally, which a prebuilt framework with an old deployment
target cannot do. Swift Testing support is available through Swift Package Manager.

## Why the import is unconditional

Inside `SwiftyMockyTesting`, `import Testing` is not guarded by `canImport`. A guard would let a
toolchain without Swift Testing compile the whole reporting branch away without a single
diagnostic - the exact class of silent failure this library exists to remove. A toolchain that
cannot provide `Testing` fails to build it instead, and such a target should link `SwiftyMocky`.
