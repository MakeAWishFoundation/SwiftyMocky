// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "mocky",
    products: [
        .executable(name: "swiftymocky", targets: ["SwiftyMockyCLI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/JohnSundell/ShellOut.git", from: "2.0.0"),
        .package(url: "https://github.com/tuist/xcodeproj.git", .upToNextMajor(from: "6.5.0")),
        .package(url: "https://github.com/jianstm/Crayon", from: "0.0.1"),
        .package(url: "https://github.com/kylef/Commander", from: "0.8.0"),
        .package(url: "https://github.com/kylef/PathKit", from: "0.0.1"),
        .package(url: "https://github.com/jpsim/Yams.git", from: "2.0.0"),
    ],
    targets: [
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
                "xcodeproj",
                "PathKit",
                "Yams",
            ]),
        .testTarget(
            name: "SwiftyMockyCLICoreTests",
            dependencies: ["SwiftyMockyCLICore"]),
    ]
)
