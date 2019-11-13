# **Mockfile** format

Mockfile is a YAML configuration, allowing to define what gets mocked. It simplifies including and excluding sources, as well as defining what should be imported or `@testable` imported.

It  also ties generated **Mock** configuration with a specific target, allowing to lint it agains most common issues.

Every generated file have its own section, following pattern below:

```yaml
sourceryCommand: null               # 1.

mock1:                              # 2.
    sources:                        # 2.1.
        include:                    # 2.1.1
        - ./MyApp
        exclude: []                 # 2.1.2 (optional)
    output:                         # 2.2
        ./MyAppUnitTests/Mocks/Mock.generated.swift
    targets:                        # 2.3 (optional)
        - MyAppUnitTests
    testable: []                    # 2.4 (optional)
    import: []                      # 2.5 (optional)
    prototype: false                # 2.6 (optional)
    sourcery:                       # 2.7 (optional)
        - ./path/to/custom/sourcery.yml # (optional)

mock2:                              # 2.
    ...
```

1. `sourceryCommand` is by default `nil`. You can use it to select custom Sourcery version/command/binary, instead of using default one bundled with SwiftyMocky CLI via `mint`.
2. **Distinctive name** of your mock configuration. You can define as much **configurations** as you want. Each of them represents one generated file. That allows to have a separate mocks for a separate targets (you usually need that if you have more than one test target)
    1. `sources` defines what files/directories would be scanned for `AutoMockable` types.
        1. `include` list of included files/directories relative to project root
        2. `exclude` list of excluded files/directories relative to project root
    2. `output` location and name of generated mocks file. If no name specified "Mock.generated.swift" would be used
    3. `targets` list of targets names. It should match the test targets that are using generated mocks file. Used to determine if your setup is correct.
    4. `testable` list of testable modules imports. By default, if you generate mocks for `YourApp`, it should contain `YourApp`. Would be placed at the top of the generated file.
    5. `import` list of modules imports. Would be placed at the top of the generated file.
    6. `prototype` default is `false`. Set `true` if you are going to use Carthage `SwiftyPrototype` library
    7. `sourcery` list of paths to additional Sourcery configurations, if you want to execute them alongside the mock generation.

> **Note 1:** Calling `swiftymocky setup` will launch an interactive tool helping you to create and prefill the **Mockfile**. You can also use `swiftymocky init` if you want a placeholder you can fill manually.

> **Note 2:** To evaluate your **Mockfile** setup, as well as other things, run `swiftmocky doctor`.

> **Note 3:** You can use `swiftymocky autoimport` to prefill `testable` and `import` in your configurations.