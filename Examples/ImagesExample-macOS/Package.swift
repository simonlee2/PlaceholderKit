// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ImagesExample-macOS",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "ImagesExample-macOS",
            targets: ["ImagesExample-macOS"]),
    ],
    dependencies: [
        .package(url: "../../PlaceholderKit", from: "0.0.3")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "ImagesExample-macOS",
            dependencies: ["PlaceholderKit"]),
        .testTarget(
            name: "ImagesExample-macOSTests",
            dependencies: ["ImagesExample-macOS", "PlaceholderKit"]),
    ]
)
