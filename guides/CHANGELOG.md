# Changelog

All changes to SwiftyMocky project will be documented in this file.

-----

## __1.0.2__ / 2017

#### Added:
* Code of contribution
* Code of conduct
* Default Matcher cases for basic types

#### Fixed:
* Handling of different Swift versions, checked on:
    * Swift 3.1 Xcode 8.3 and Xcode 8.3.3
    * Swift 3.2 Xcode 9
    * Swift 4.0.x Xcode 9
* Fixed links for cocoapods.org expanded site

-----

## __1.0.1__ / 2017

#### Fixed:
* Missing Parameter case for ValueType both Sequence and Equatable, causing compile error under Swift 3.x in XCode 9
* Images not showing in expanded description on cocoapods.org
* Documentation link based on tag, not commit

-----

## __1.0.0__ / 2017

#### Added:
* Support for generics
* Support for static members
* Different Swift versions support
* Matcher convenience registrations
* More extensive documentation

#### Updated:
* Simplified Mock template
* Generated code simplified and beautified
* Renamed ...Proxy to `Given`,`Verify`,`Perform`
* Reduced generation time

#### Fixed:
* Comparing parameters
* Matcher comparing issues

-----

## __0.9.0__ / 2017

#### Added:
* basic generation flow
* basic documentation
* readme
* template
* basic swift 3.1 support

#### Updated:
* Wrapping methods into `Proxy`
* Example tests

-----

## 0.1.0 - 0.4.0 / 2017

* Initial commit
* Foundation of __SwiftyMocky__ project
* Tests and CI setup
