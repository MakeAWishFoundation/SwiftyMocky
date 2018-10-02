# Generics Support

In **SwiftyMocky**, we are supporting generics for methods generation, as well as for generic constrained methods in mocked protocols.

## Protocols with generic methods

We support generic constrained methods in protocols definition, so something like below:

```swift
//sourcery: AutoMockable
public protocol HistorySectionMapperType: class {
    func map<T: DateSortable>(_ items: [T]) ->  [(key: String, items: [T])]
}
```

Will generate valid mock.

Please have in mind, that generic methods are problematic in a lot of cases, so you could experience:

1. AutoComplete issues for given, perform and verify: - use full `<MockName>.Given.` for getting autocomplete.
1. Use full `.any(Value.Type)` instead of `.any`, to avoid ambiguity.
1. Matching issues - if you are using generic parameters as `.value`, you might need to add additional comparators to `Matcher` instance. However, it should be handled for most of basic types.
1. When working with methods like `func decode<T>(_ type: T.Type, data: Data) -> T`, it will require to register comparator for every custom `T.Type` used, like `Matcher.default.register(CustomType.Type.self)` - or just use .any(Custom.self)

## Protocols with generic subscripts

We support generic subscript, but for now they need to annotated manually, like below:

```swift
//sourcery: AutoMockable
public protocol ProtocolWithGenericSubscript: class {
    //sourcery: associatedtype = "T: Sequence"
    subscript<T: Sequence>(_ items: [T]) -> Int where T.Element: Equatable { get set }
}
```

Annotations associatedtype should contain everything in <>, while where at the end gets autoparsed. That will generate a valid mock.

Please have in mind, that generic methods are problematic in a lot of cases, so you could experience. They generally match the ones of generic method above.

## Protocols with associated types

We are also supporting protocols with associated types (mock will be generated as generic class), but that requires some aditional manuall annotations:

```swift
//sourcery: AutoMockable
//sourcery: associatedtype = "T1: Sequence"
//sourcery: associatedtype = "T2: Comparable, EmptyProtocol"
protocol AVeryAssociatedProtocol {
    associatedtype T1: Sequence
    associatedtype T2: Comparable, EmptyProtocol

    func fetch(for value: T2) -> T1
}
```

Definition above will produce:

```swift
class AVeryAssociatedProtocolMock<TypeT1,TypeT2>: AVeryAssociatedProtocol, Mock where TypeT1: Sequence, TypeT2: Comparable, TypeT2: EmptyProtocol {

	typealias T1 = TypeT1
	typealias T2 = TypeT2

// ...
```
