# Supported features

## Generation:

All supported ways of generating mocks. Handling mockable types:

- [x] generating inline mocks
- [x] generate in Mocked.generated based on AutoMockable protocol
- [x] generate in Mocked.generated based on AutoMockable annotation
- [ ] skip protocols that cannot be generated with warning
- [x] support protocol inheritance
- [x] support objc protocols (with special protocol/annotation)
- [x] support generic protocols - see **Generics** section for more information **!!!**

## Stubbing:

Support for stubbing protocol members:

- [x] stubbing initializers **only for protocol conformance - they have empty implementation!**
- [ ] stubbing deinitializers
- [x] stubbing instance methods
    - [x] with return value
    - [ ] with return as Swift.Never
    - [x] that throws
    - [x] that rethrows
- [x] stubbing static methods
- [x] stubbing generic methods
    - [x] constrained to protocol conformance
    - [x] with 'T.Type' attributes
    - [x] constrained to Self type
- [x] stubbing variables (with get, set)
    - [x] instance variables
    - [x] static variables
    - [x] optional
    - [x] implicitly unwrapped optional
- [x] stubbing subscripts - **for generic subscripts manual annotation needed**
- [x] handling associated types - **done by annotations**
- [x] handling conformances in associated types
- [x] wrapping method attributes as Parameter
    - [x] basic types
    - [x] closures
    - [x] @escaping closures
    - [x] typealiases

## Given

Usage of Given to specify return value and error thrown for stubbed methods:

- [x] constraint to attributes matching `.any`
- [x] constraint to attributes matching explicit `.value(ValueType)` where:
    - [x] ValueType is Equatable
    - [x] ValueType is Sequences of Equatable elements
    - [x] ValueType is not Equatable - **when registered comparator in Matcher**
    - [x] ValueType is Equatable is `@escaping` closure - **when registered comparator in Matcher**
    - [x] **!!!** ValueType is not `@escaping` closure - **always handled as** `.any`
- [x] return value for instance stub
- [x] error thrown for instance stub
- [ ] error thrown for instance stubs that rethrows
- [x] return value for static stubs
- [x] error thrown for static stubs
- [ ] error thrown for static stubs, that rethrows

## Perform

Usage of Perform to execute closure, when stubbed method is called:

- [x] perform closure attributes matching stub attributes
- [x] constraint to attributes matching `.any`
- [x] constraint to attributes matching explicit `.value(ValueType)` where:
    - [x] ValueType is Equatable
    - [x] ValueType is Sequences of Equatable elements
    - [x] ValueType is not Equatable - **when registered comparator in Matcher**
    - [x] ValueType is Equatable is `@escaping` closure - **when registered comparator in Matcher**
    - [x] **!!!** ValueType is not `@escaping` closure - **always handled as** `.any`
- [x] expect perform closure for static stubs

## Verify

Usage of Verify to check, whether specific stubbed method was called on Mock

- [x] constraint to attributes matching `.any`
- [x] constraint to attributes matching explicit `.value(ValueType)` where:
    - [x] ValueType is Equatable
    - [x] ValueType is Sequences of Equatable elements
    - [x] ValueType is not Equatable - **when registered comparator in Matcher**
    - [x] ValueType is Equatable is `@escaping` closure - **when registered comparator in Matcher**
    - [x] **!!!** ValueType is not `@escaping` closure - **always handled as** `.any`
- [x] verify if called at least once
- [x] verify if called exactly number of times
- [x] verify for static methods
