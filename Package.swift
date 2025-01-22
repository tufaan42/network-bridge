// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkBridge",
    platforms: [
        .macOS(.v12),    // Minimum macOS version
        .iOS(.v15),      // Minimum iOS version
        .tvOS(.v15),     // Minimum tvOS version
        .watchOS(.v8)    // Minimum watchOS version
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "NetworkBridge",
            targets: ["NetworkBridge"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "NetworkBridge"),

    ]
)
