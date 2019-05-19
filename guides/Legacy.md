# Legacy

If really you don't want to use the **CLI** (😢) then you can still use SwiftyMocky with a Sourcery configuration, described below. This is the "old" way of integrating our library. 

Summing up, you need **SwiftyMocky** framework in the runtime, and **sourcery** binary with a configuration pointing to our template for the mocks generation.

## Installation

SwiftyMocky is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod "SwiftyMocky"
```

Then add **mocky.yml** and **Rakefile** (or build script phase) to your project root directory, as described in below. See full [setup][link-docs-setup] instructions.

For [Carthage](https://github.com/Carthage/Carthage) install instructions, see full [documentation][link-docs-installation].

### Generating mocks implementations:

One of the boilerplate part of testing and development is writing and updating **mocks** accordingly to newest changes. SwiftyMocky is capable of generating mock implementations (with configurable behavior), based on protocol definition.

During development process it is possible to use SwiftyMocky in a *watcher* mode, which will observe changes in you project files, and regenerate files on the fly.

![Generating mock][example-watcher]

By default, all protocols marked as AutoMockable (inheriting from dummy protocol `AutoMockable` or annotated with `//sourcery: AutoMockable`) are being subject of mock implementation generation. All mocks goes to `Mock.generated.swift`, which can be imported into test target.

# How to start using SwiftyMocky

Mocks generation is based on `mocky.yml` file.

First, create file in your project root directory with following structure:

```yml
sources:
  include:
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

+ **sources**: all directories you want to scan for protocols/files marked to be auto mocked, or inline mocked. You can use `exclude`, to prevent from scanning particular files (makes sense for big `*.generated.swift` files)
+ **templates**: path to SwiftyMocky sourcery templates, in Pods directory
+ **output**: place where `Mock.generated.swift` will be placed
+ **testable**: specify imports for Mock.generated, that should be marked as `@testable` (usually tested app module)
+ **import**: all additional imports, external libraries etc. to be placed in Mock.generated
+ **excludedSwiftLintRules**: if using swift SwiftLint.

If you are already using [Sourcery](https://github.com/krzysztofzablocki/Sourcery) with your own templates and you have configured `sourcery.yml` file, you can extend it to add support for SwiftyMocky. Click [here][link-guides-installation] for details.

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




[example-watcher]: https://raw.githubusercontent.com/MakeAWishFoundation/SwiftyMocky/1.0.0/guides/assets/example-watcher.gif "Example - generation"