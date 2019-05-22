# **Mockfile** format

Mockfile is a YAML configuration, allowing to define what gets mocked. It simplifies including and excluding sources, as well as defining what should be imported or `@testable` imported.

It  also ties generated **Mock** configuration with a specific target, allowing to lint it agains most common issues.

Every generated file have its own section, following pattern below:

```yaml
sourcery: null
````