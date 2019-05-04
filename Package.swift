// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "mocky",
    products: [
        .executable(name: "mocky", targets: ["SwiftyMockyCLI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/JohnSundell/ShellOut.git", from: "2.0.0"),
        .package(url: "https://github.com/tuist/xcodeproj.git", .upToNextMajor(from: "6.5.0")),
        .package(url: "https://github.com/jianstm/Crayon", from: "0.0.1"),
        .package(url: "https://github.com/kylef/Commander", from: "0.8.0"),
        .package(url: "https://github.com/kylef/PathKit", from: "0.0.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "SwiftyMockyCLI",
            dependencies: ["SwiftyMockyCLICore"]),
        .target(
            name: "SwiftyMockyCLICore",
            dependencies: [
                "ShellOut",
                "Crayon",
                "xcodeproj",
                "Commander",
                "PathKit"
            ]),
        .testTarget(
            name: "SwiftyMockyCLICoreTests",
            dependencies: ["SwiftyMockyCLICore"]),
    ]
)
