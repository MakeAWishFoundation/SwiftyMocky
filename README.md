# Mocky

Lightweight, strongly typed framework for Mockito-like unit testing experience. Becaue Swift doesn't support reflection as well as we could build mocks in runtime, library depends on Sourcery, that scans your source code and generates Swift code for you.

## Current version
Master branch is still in beta, breaking changes are possible.

## Idea

Mokcy is designed to mock protocols. For example: 

``` 
protocol ItemsModel: class {
    func getExampleItems() -> Observable<[Item]>
    func getItemDetails(item: Item) -> Observable<ItemDetails>
}
```
for this protocol, generated mock looks like: 

```
// sourcery: mock = "ItemsModel"
class ItemsModelMock: ItemsModel, Mock {
// sourcery:inline:auto:ItemsModelMock.autoMocked
    //swiftlint:disable force_cast

    var invocations = [MethodType]()
    var methodReturnValues: [MethodProxy] = []

    //MARK : ItemsModel  

    func getExampleItems() -> Observable<[Item]> {
        addInvocation(.getExampleItems)
        return methodReturnValue(.getExampleItems) as! Observable<[Item]> 
    }
    
    func getItemDetails(item: Item) -> Observable<ItemDetails> {
        addInvocation(.getItemDetails(item: .value(item)))
        return methodReturnValue(.getItemDetails(item: .value(item))) as! Observable<ItemDetails> 
    }
    
    enum MethodType: Equatable {

        case getExampleItems    
        case getItemDetails(item : Parameter<Item>)     
    
        static func ==(lhs: MethodType, rhs: MethodType) -> Bool {
            switch (lhs, rhs) {

                case (.getExampleItems, .getExampleItems): return true                
                case (let .getItemDetails(lhsParams), let .getItemDetails(rhsParams)): return lhsParams == rhsParams                 
                default: return false   
            }
        }
    }

    struct MethodProxy {
        var method: MethodType 
        var returns: Any? 

        static func getExampleItems(willReturn: Observable<[Item]>) -> MethodProxy {
            return MethodProxy(method: .getExampleItems, returns: willReturn)
        }
        
        static func getItemDetails(item: Parameter<Item>, willReturn: Observable<ItemDetails>) -> MethodProxy {
            return MethodProxy(method: .getItemDetails(item: item), returns: willReturn)
        }
         
    }

    private func methodReturnValue(_ method: MethodType) -> Any? {
        let all = methodReturnValues.filter({ proxy -> Bool in
            return proxy.method == method
        })

        return all.last?.returns
    }
// sourcery:end
}
```

## Usage 

ItemsModelMock can be used for stubbibg return value and veryfying invocations of methods

example test that uses generated mock: 
```
class ItemsViewModelTests: XCTestCase {
    
    var sut: ItemsViewModel!
    var itemsModelMock: ItemsModelMock!
    
    override func setUp() {
        super.setUp()
        itemsModelMock = ItemsModelMock()
        sut = ItemsViewModel(itemsModel: itemsModelMock)
    }
    
    override func tearDown() {
        itemsModelMock = nil
        sut = nil
        super.tearDown()
    }
    
    func test_fetchItems() {
        itemsModelMock.given(.getExampleItems(willReturn: Observable.just([]) ))
        sut.fetchData()
        Verify(itemsModelMock, .getExampleItems)
    }
}
```

For more examples, check out our example project. 

## Mocks generation 

There are some ways to generate mocks: 
1) in `watch` mode 
Changed methods will be reflected in mocks, after generation of mock, 
For now there is a way to autogenerate mocks, you just need to create mock file, and add sourcert annotation
2) mocks generated manually 
3) build script


## Roadmap 

- [x] stubbibg protocols in elegant way
- [x] template for generating mocks 
- [x] example project
- [x] stubbing protocols with variables ( for now, IUO and Optional types are supported) 
- [ ] method signature generation without name conflicts 
- [ ] cover 95% of framework codebase with unit tests 
- [ ] refactor .swifttemplate to .stencil template, to improve performance of generation
- [ ] add unit tests for template
- [ ] support for tvOS, Linux and MacOS
- [ ] Swift Package Manager support 
- [ ] Carthage support 

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements



## Installation

Mocky is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Mocky"
```

## Author

Przemysław Wośko, przemyslaw.wosko@intive.com

## Contributors 

Andrzej Michnia, andrzej.michnia@intive.com

## License

Mocky is available under the MIT license. See the LICENSE file for more info.
