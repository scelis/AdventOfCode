// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "Advent of Code",
    platforms: [.macOS(.v13)],
    products: [
        .library(name: "AdventKit", targets: ["AdventKit"]),
        .library(name: "IntcodeComputer", targets: ["IntcodeComputer"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms.git", from: "1.0.0"),
    ],
    targets: [
        .target(name: "AdventKit", dependencies: [.product(name: "Algorithms", package: "swift-algorithms")]),
        .target(name: "IntcodeComputer", dependencies: ["AdventKit"], path: "Sources/2019/IntcodeComputer"),
        .executableTarget(name: "AOC-2019-01", dependencies: ["AdventKit"], path: "Sources/2019/Day01", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2019-02", dependencies: ["AdventKit", "IntcodeComputer"], path: "Sources/2019/Day02", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2019-03", dependencies: ["AdventKit"], path: "Sources/2019/Day03", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2019-04", dependencies: ["AdventKit"], path: "Sources/2019/Day04", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2019-05", dependencies: ["AdventKit", "IntcodeComputer"], path: "Sources/2019/Day05", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2019-06", dependencies: ["AdventKit"], path: "Sources/2019/Day06", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2019-07", dependencies: ["AdventKit", "IntcodeComputer"], path: "Sources/2019/Day07", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2019-08", dependencies: ["AdventKit"], path: "Sources/2019/Day08", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2019-09", dependencies: ["AdventKit", "IntcodeComputer"], path: "Sources/2019/Day09", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2019-10", dependencies: ["AdventKit"], path: "Sources/2019/Day10", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2019-11", dependencies: ["AdventKit", "IntcodeComputer"], path: "Sources/2019/Day11", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2019-12", dependencies: ["AdventKit"], path: "Sources/2019/Day12", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2019-13", dependencies: ["AdventKit", "IntcodeComputer"], path: "Sources/2019/Day13", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2019-14", dependencies: ["AdventKit"], path: "Sources/2019/Day14", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2019-15", dependencies: ["AdventKit", "IntcodeComputer"], path: "Sources/2019/Day15", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2019-16", dependencies: ["AdventKit"], path: "Sources/2019/Day16", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2019-17", dependencies: ["AdventKit", "IntcodeComputer"], path: "Sources/2019/Day17", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2019-18", dependencies: ["AdventKit"], path: "Sources/2019/Day18", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2019-19", dependencies: ["AdventKit"], path: "Sources/2019/Day19", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2019-20", dependencies: ["AdventKit"], path: "Sources/2019/Day20", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2019-21", dependencies: ["AdventKit"], path: "Sources/2019/Day21", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2019-22", dependencies: ["AdventKit"], path: "Sources/2019/Day22", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2019-23", dependencies: ["AdventKit"], path: "Sources/2019/Day23", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2019-24", dependencies: ["AdventKit"], path: "Sources/2019/Day24", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2019-25", dependencies: ["AdventKit"], path: "Sources/2019/Day25", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2020-01", dependencies: ["AdventKit"], path: "Sources/2020/Day01", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2020-02", dependencies: ["AdventKit"], path: "Sources/2020/Day02", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2020-03", dependencies: ["AdventKit"], path: "Sources/2020/Day03", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2020-04", dependencies: ["AdventKit"], path: "Sources/2020/Day04", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2020-05", dependencies: ["AdventKit"], path: "Sources/2020/Day05", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2020-06", dependencies: ["AdventKit"], path: "Sources/2020/Day06", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2020-07", dependencies: ["AdventKit"], path: "Sources/2020/Day07", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2020-08", dependencies: ["AdventKit"], path: "Sources/2020/Day08", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2020-09", dependencies: ["AdventKit"], path: "Sources/2020/Day09", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2020-10", dependencies: ["AdventKit"], path: "Sources/2020/Day10", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2020-11", dependencies: ["AdventKit"], path: "Sources/2020/Day11", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2020-12", dependencies: ["AdventKit"], path: "Sources/2020/Day12", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2020-13", dependencies: ["AdventKit"], path: "Sources/2020/Day13", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2020-14", dependencies: ["AdventKit"], path: "Sources/2020/Day14", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2020-15", dependencies: ["AdventKit"], path: "Sources/2020/Day15", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2020-16", dependencies: ["AdventKit"], path: "Sources/2020/Day16", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2020-17", dependencies: ["AdventKit"], path: "Sources/2020/Day17", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2020-18", dependencies: ["AdventKit"], path: "Sources/2020/Day18", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2020-19", dependencies: ["AdventKit"], path: "Sources/2020/Day19", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2020-20", dependencies: ["AdventKit"], path: "Sources/2020/Day20", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2020-21", dependencies: ["AdventKit"], path: "Sources/2020/Day21", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2020-22", dependencies: ["AdventKit"], path: "Sources/2020/Day22", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2020-23", dependencies: ["AdventKit"], path: "Sources/2020/Day23", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2020-24", dependencies: ["AdventKit"], path: "Sources/2020/Day24", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2020-25", dependencies: ["AdventKit"], path: "Sources/2020/Day25", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2021-01", dependencies: ["AdventKit"], path: "Sources/2021/Day01", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2021-02", dependencies: ["AdventKit"], path: "Sources/2021/Day02", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2021-03", dependencies: ["AdventKit"], path: "Sources/2021/Day03", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2021-04", dependencies: ["AdventKit"], path: "Sources/2021/Day04", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2021-05", dependencies: ["AdventKit"], path: "Sources/2021/Day05", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2021-06", dependencies: ["AdventKit"], path: "Sources/2021/Day06", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2022-01", dependencies: ["AdventKit"], path: "Sources/2022/Day01", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2022-02", dependencies: ["AdventKit"], path: "Sources/2022/Day02", resources: [.copy("input.txt")]),
        .executableTarget(name: "AOC-2022-03", dependencies: ["AdventKit"], path: "Sources/2022/Day03", resources: [.copy("input.txt")]),
    ]
)
