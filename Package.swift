// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

#if os(macOS)
/// MacOS swiftymocky mackage
let package = Package(
   name: "swiftymocky",
   products: [
       .executable(name: "swiftymocky", targets: ["SwiftyMockyCLI"]),
       .library(name: "SwiftyMocky", targets: ["SwiftyMocky"]),
   ],
   dependencies: [
       .package(url: "https://github.com/JohnSundell/ShellOut.git", from: "2.0.0"),
       .package(url: "https://github.com/tuist/xcodeproj.git", from: "7.1.0"),
       .package(url: "https://github.com/jianstm/Crayon", from: "0.0.3"),
       .package(url: "https://github.com/kylef/Commander", from: "0.8.0"),
       .package(url: "https://github.com/kylef/PathKit", from: "1.0.0"),
       .package(url: "https://github.com/jpsim/Yams.git", from: "2.0.0"),
   ],
   targets: [
       .target(
           name: "SwiftyMocky",
           path: "./Sources/Classes"
           ),
       .target(
           name: "SwiftyMockyCLI",
           dependencies: [
               "Commander",
               "SwiftyMockyCLICore"
           ]),
       .target(
           name: "SwiftyMockyCLICore",
           dependencies: [
               "ShellOut",
               "Crayon",
               "XcodeProj",
               "PathKit",
               "Yams",
           ]),
       .testTarget(
           name: "SwiftyMockyCLICoreTests",
           dependencies: [
               "SwiftyMockyCLICore",
               "SwiftyMocky"
           ]),
   ]
)
#else
/// Linux package. For now not really usable, until sourcery would be available too
let package = Package(
    name: "swiftymocky",
    products: [
        .executable(name: "swiftymocky", targets: ["SwiftyMockyCLI"]),
        .library(name: "SwiftyMocky", targets: ["SwiftyMocky"]),
    ],
    dependencies: [
       .package(url: "https://github.com/JohnSundell/ShellOut.git", from: "2.0.0"),
       .package(url: "https://github.com/jianstm/Crayon", from: "0.0.3"),
       .package(url: "https://github.com/kylef/Commander", from: "0.8.0"),
       .package(url: "https://github.com/kylef/PathKit", from: "1.0.0"),
       .package(url: "https://github.com/jpsim/Yams.git", from: "2.0.0"),
    ],
    targets: [
        .target(
            name: "SwiftyMocky",
            path: "./Sources/Classes"),
        .target(
            name: "SwiftyMockyCLI",
            dependencies: [
                "Commander",
                "SwiftyMockyCLICore"
            ]),
        .target(
            name: "SwiftyMockyCLICore",
            dependencies: [
                "ShellOut",
                "Crayon",
                "PathKit",
                "Yams",
            ],
            exclude: [
                "Commands/MacOS",
                "Utils/MacOS",
            ]),
        .testTarget(
            name: "SwiftyMockyCLICoreTests",
            dependencies: [
                "SwiftyMockyCLICore",
                "SwiftyMocky"
            ]),
    ]
)
#endif
