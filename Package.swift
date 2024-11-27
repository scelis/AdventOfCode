// swift-tools-version:6.0

import Foundation
import PackageDescription

let swift5Years: [Int] = []
let swift6Years: [Int] = [2015, 2019, 2020, 2021, 2022, 2023, 2024]
let enableCompilerOptimizations = false

let package = Package(
    name: "AdventOfCode",
    platforms: [.macOS(.v14)],
    products: [
        .library(name: "AdventKit", targets: ["AdventKit"]),
        .library(name: "AdventKit2", targets: ["AdventKit2"]),
        .executable(name: "AdventOfCode", targets: ["AdventOfCode"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms.git", from: "1.2.0"),
    ],
    targets: targets()
)

func targets() -> [Target] {
    var targets: [Target] = [
        .target(
            name: "AdventKit",
            dependencies: [.product(name: "Algorithms", package: "swift-algorithms")],
            path: "AdventKit/Sources",
            swiftSettings: swiftSettings(useStrictConcurrency: false)
        ),
        .testTarget(
            name: "AdventKitTests",
            dependencies: ["AdventKit"],
            path: "AdventKit/Tests",
            swiftSettings: swiftSettings(useStrictConcurrency: false)
        ),
        .target(
            name: "AdventKit2",
            dependencies: [.product(name: "Algorithms", package: "swift-algorithms")],
            path: "AdventKit2/Sources",
            swiftSettings: swiftSettings(useStrictConcurrency: true)
        ),
        .testTarget(
            name: "AdventKit2Tests",
            dependencies: ["AdventKit2"],
            path: "AdventKit2/Tests",
            swiftSettings: swiftSettings(useStrictConcurrency: true)
        ),
        .executableTarget(
            name: "AdventOfCode",
            dependencies: (swift5Years + swift6Years).map { .target(name: "AOC\($0)") },
            path: "AdventOfCode",
            swiftSettings: swiftSettings(useStrictConcurrency: true)
        ),
    ]

    for year in swift5Years {
        targets += yearTargets(for: year, useStrictConcurrency: false)
    }

    for year in swift6Years {
        targets += yearTargets(for: year, useStrictConcurrency: true)
    }

    return targets
}

func yearTargets(
    for year: Int,
    useStrictConcurrency: Bool
) -> [Target] {
    [
        .target(
            name: "AOC\(year)",
            dependencies: [useStrictConcurrency ? "AdventKit2" : "AdventKit"],
            path: "\(year)/Sources",
            exclude: inputFiles(forYear: year),
            swiftSettings: swiftSettings(useStrictConcurrency: useStrictConcurrency)
        ),
        .testTarget(
            name: "AOC\(year)Tests",
            dependencies: [.target(name: "AOC\(year)")],
            path: "\(year)/Tests",
            swiftSettings: swiftSettings(useStrictConcurrency: useStrictConcurrency)
        )
    ]
}

func inputFiles(forYear year: Int) -> [String] {
    let sourceDirectory = URL(fileURLWithPath: #file).deletingLastPathComponent()
    return (1...25).compactMap { day in
        let fragment = "Day\(String(format: "%02d", day))/input.txt"
        let path = sourceDirectory.appending(path: "\(year)/Sources/\(fragment)").path(percentEncoded: false)
        return FileManager.default.fileExists(atPath: path) ? fragment : nil
    }
}

func swiftSettings(
    useStrictConcurrency: Bool
) -> [SwiftSetting] {
    [
        enableCompilerOptimizations ? .unsafeFlags(["-O"]) : nil,
        useStrictConcurrency ? nil : .swiftLanguageMode(.v5),
    ].compactMap { $0 }
}
