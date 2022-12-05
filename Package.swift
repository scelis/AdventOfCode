// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "AdventOfCode",
    platforms: [.macOS(.v13)],
    products: [
        .library(name: "AdventKit", targets: ["AdventKit"]),
        .executable(name: "AdventOfCode", targets: ["AdventOfCode"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms.git", from: "1.0.0"),
        .package(url: "https://github.com/pointfreeco/swift-parsing.git", from: "0.10.0"),
    ],
    targets: [
        .target(
            name: "AdventKit",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
                .product(name: "Parsing", package: "swift-parsing"),
            ]
        ),
        .target(name: "AOC2022", dependencies: ["AdventKit"], path: "Sources/2022"),
        .executableTarget(name: "AdventOfCode", dependencies: ["AOC2022"]),
        .testTarget(name: "AdventOfCodeTests", dependencies: ["AOC2022"]),
    ]
)
