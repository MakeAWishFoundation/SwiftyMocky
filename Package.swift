// swift-tools-version:4.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
   name: "swiftymocky",
   products: [
       .library(name: "SwiftyMocky", targets: ["SwiftyMocky"]),
       .library(name: "SwiftyPrototype", targets: ["SwiftyPrototype"]),
   ],
   dependencies: [],
   targets: [
       .target(
           name: "SwiftyMocky",
           dependencies: ["Core"],
           path: "./Sources/Mock",
           exclude: ["Mock.swifttemplate"]
        ),
       .target(
           name: "SwiftyPrototype",
           dependencies: ["Core"],
           path: "./Sources/Prototype",
           exclude: ["Prototype.swifttemplate"]
        ),
       .target(
           name: "Core",
           path: "./Sources/Classes"
        ),
   ]
)
