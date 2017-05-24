# Mocky

Lightweight, strongly typed framework for Mockito-like unit testing experience. Becaue Swift doesn't support reflection as weel as we could build mocks in runtime, library depends on Sourcery, that scans your source code, applies your personal templates and generates Swift code for you, allowing you to use meta-programming techniques to save time.

## Current version
Master branch is still in beta, breaking changes are possible, but contecpt of wrapping method, return types and parameters in enums stays in place ;) 

## Idea

Mokcy is designed to mock protocols. For example: 

```ExampleProtocol.swift

protocol ExampleProtocol {
simpleMehtod(param: String) -> String? 
}
```
will be interpreted as: 

```ExampleProtocolMock.swift
class ExampleProtocolMock: ExampleProtocol, Mock {
var returnValues: [ReturnType] = []
var invocations = [ParameterType]()

func simpleMethod(param: String) -> String? {
addInvocation(.simpleMethod(param: .value(param)))
reutrn returnValue(.simpleMethod)
}

enum SignatureType {
case simpleMethod
}

enum ParameterType : Equatable {

case simpleMethod(items : Prameter<String>)      

static func ==(lhs: ParameterType, rhs: ParameterType) -> Bool {
switch (lhs, rhs) {
case (let .simpleMethod(lhsParams), let .simpleMethod(rhsParams)): return lhsParams == rhsParams              
default: return false    
}
}
}

enum ReturnType: AutoValue {  
case simpleMethod(returns: String?)    
}

```


## Usage 

ExampleProtocolMock can be used for stubbibg return value and veryfying invocations of methods

example test: 
```
func test_someTest() {
exampleProtocolMock.given(.simpleMethod(returns: nil))

sut.magicCall()

Verify(exampleProtocolMock, .simpleMethod(param: .value("passed parameter")))
Verify(exampleProtocolMock, .simpleMethod(param: .any))
Verify(exampleProtocolMock, .simpleMethod)
}

```

Verifying can be done for: 
- method invocation  
- method with parameters with skipped parameters by passing .any for non comparable params
- method invocation with parameters that are comparable 

## Auto generation of mocks 
For now there is a way to autogenerate mocks, you just need to create mock file, and add sourcert annotation
```
// sourcery: mock = "ExampleProtocol"
class ExampleProtocolMock: ExampleProtocol, Mock {}
```

after generation this code will be replaced with code as for example above, and for changed ExampleProtocol, any changes will be applied to generated code after new generation

Due to generation time that takes 8 - 21 seconds, it's reccomended to manually run generating script. For futher versions and .stencil template it can be automatically runned as pre build phrase


## Roadmap 

[x] stubbibg protocols in elegant way
[x] template for generating mocks 
[x] example project
[ ] think of method signature generation without name conflicts 
[ ] stubbing protocols with variables 
[ ] refactor .swifttemplate to .stencil template, to improve speed of generating (it will take less than 1 second for even projects with 1M LOC )
[ ] cover 90% of framework code with unit tests 

[![CI Status](http://img.shields.io/travis/Przemysław Wośko/Mocky.svg?style=flat)](https://travis-ci.org/Przemysław Wośko/Mocky)
[![Version](https://img.shields.io/cocoapods/v/Mocky.svg?style=flat)](http://cocoapods.org/pods/Mocky)
[![License](https://img.shields.io/cocoapods/l/Mocky.svg?style=flat)](http://cocoapods.org/pods/Mocky)
[![Platform](https://img.shields.io/cocoapods/p/Mocky.svg?style=flat)](http://cocoapods.org/pods/Mocky)

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

## License

Mocky is available under the MIT license. See the LICENSE file for more info.
