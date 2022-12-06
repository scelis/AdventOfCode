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
            ],
            path: "AdventKit"
        ),

        .executableTarget(
            name: "AdventOfCode",
            dependencies: ["AOC2019", "AOC2020", "AOC2021", "AOC2022"],
            path: "AdventOfCode"
        ),

        .target(name: "AOC2019", dependencies: ["AdventKit"], path: "2019/Sources"),
        .testTarget(name: "AOC2019Tests", dependencies: ["AOC2019"], path: "2019/Tests"),

        .target(name: "AOC2020", dependencies: ["AdventKit"], path: "2020/Sources"),
        .testTarget(name: "AOC2020Tests", dependencies: ["AOC2020"], path: "2020/Tests"),

        .target(name: "AOC2021", dependencies: ["AdventKit"], path: "2021/Sources"),
        .testTarget(name: "AOC2021Tests", dependencies: ["AOC2021"], path: "2021/Tests"),

        .target(name: "AOC2022", dependencies: ["AdventKit"], path: "2022/Sources"),
        .testTarget(name: "AOC2022Tests", dependencies: ["AOC2022"], path: "2022/Tests"),
    ]
)
