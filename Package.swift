// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "PlaceholderKit",
    products: [
        .library(name: "PlaceholderKit", targets: ["PlaceholderKit"]),
    ],
    targets: [
        .target(name: "PlaceholderKit"),
        .testTarget(name: "PlaceholderKitTests", dependencies: ["PlaceholderKit"]),
    ]
)