// swift-tools-version:4.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

/// MacOS swiftymocky mackage
let package = Package(
   name: "swiftymocky",
   products: [
       .library(name: "SwiftyMocky", targets: ["SwiftyMocky"]),
   ],
   dependencies: [],
   targets: [
       .target(
           name: "SwiftyMocky",
           path: "./Sources/Classes"
        ),
   ]
)
