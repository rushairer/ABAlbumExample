// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftConcurrencyExtensions",
    platforms: [.iOS(.v15), .macOS(.v12), .watchOS(.v8), .tvOS(.v14)],
    products: [
        .library(
            name: "SwiftConcurrencyExtensions",
            targets: ["SwiftConcurrencyExtensions"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SwiftConcurrencyExtensions",
            dependencies: []),
        .testTarget(
            name: "SwiftConcurrencyExtensionsTests",
            dependencies: ["SwiftConcurrencyExtensions"]),
    ]
)
