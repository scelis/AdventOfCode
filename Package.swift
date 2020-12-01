// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "AdventOfCode",
    platforms: [.macOS("10.15")],
    products: [
        .library(name: "AdventKit", targets: ["AdventKit"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "AdventKit", dependencies: []),
        .target(name: "AOC-2020-01", dependencies: ["AdventKit"], path: "Sources/2020/Day01", resources: [.copy("input.txt")]),
        .target(name: "AOC-2020-02", dependencies: ["AdventKit"], path: "Sources/2020/Day02", resources: [.copy("input.txt")]),
        .target(name: "AOC-2020-03", dependencies: ["AdventKit"], path: "Sources/2020/Day03", resources: [.copy("input.txt")]),
        .target(name: "AOC-2020-04", dependencies: ["AdventKit"], path: "Sources/2020/Day04", resources: [.copy("input.txt")]),
        .target(name: "AOC-2020-05", dependencies: ["AdventKit"], path: "Sources/2020/Day05", resources: [.copy("input.txt")]),
        .target(name: "AOC-2020-06", dependencies: ["AdventKit"], path: "Sources/2020/Day06", resources: [.copy("input.txt")]),
        .target(name: "AOC-2020-07", dependencies: ["AdventKit"], path: "Sources/2020/Day07", resources: [.copy("input.txt")]),
        .target(name: "AOC-2020-08", dependencies: ["AdventKit"], path: "Sources/2020/Day08", resources: [.copy("input.txt")]),
        .target(name: "AOC-2020-09", dependencies: ["AdventKit"], path: "Sources/2020/Day09", resources: [.copy("input.txt")]),
        .target(name: "AOC-2020-10", dependencies: ["AdventKit"], path: "Sources/2020/Day10", resources: [.copy("input.txt")]),
        .target(name: "AOC-2020-11", dependencies: ["AdventKit"], path: "Sources/2020/Day11", resources: [.copy("input.txt")]),
        .target(name: "AOC-2020-12", dependencies: ["AdventKit"], path: "Sources/2020/Day12", resources: [.copy("input.txt")]),
        .target(name: "AOC-2020-13", dependencies: ["AdventKit"], path: "Sources/2020/Day13", resources: [.copy("input.txt")]),
        .target(name: "AOC-2020-14", dependencies: ["AdventKit"], path: "Sources/2020/Day14", resources: [.copy("input.txt")]),
        .target(name: "AOC-2020-15", dependencies: ["AdventKit"], path: "Sources/2020/Day15", resources: [.copy("input.txt")]),
        .target(name: "AOC-2020-16", dependencies: ["AdventKit"], path: "Sources/2020/Day16", resources: [.copy("input.txt")]),
        .target(name: "AOC-2020-17", dependencies: ["AdventKit"], path: "Sources/2020/Day17", resources: [.copy("input.txt")]),
        .target(name: "AOC-2020-18", dependencies: ["AdventKit"], path: "Sources/2020/Day18", resources: [.copy("input.txt")]),
        .target(name: "AOC-2020-19", dependencies: ["AdventKit"], path: "Sources/2020/Day19", resources: [.copy("input.txt")]),
        .target(name: "AOC-2020-20", dependencies: ["AdventKit"], path: "Sources/2020/Day20", resources: [.copy("input.txt")]),
        .target(name: "AOC-2020-21", dependencies: ["AdventKit"], path: "Sources/2020/Day21", resources: [.copy("input.txt")]),
        .target(name: "AOC-2020-22", dependencies: ["AdventKit"], path: "Sources/2020/Day22", resources: [.copy("input.txt")]),
        .target(name: "AOC-2020-23", dependencies: ["AdventKit"], path: "Sources/2020/Day23", resources: [.copy("input.txt")]),
        .target(name: "AOC-2020-24", dependencies: ["AdventKit"], path: "Sources/2020/Day24", resources: [.copy("input.txt")]),
        .target(name: "AOC-2020-25", dependencies: ["AdventKit"], path: "Sources/2020/Day25", resources: [.copy("input.txt")]),
    ]
)
