// swift-tools-version:6.2

import Foundation
import PackageDescription

let years: [Int] = [2015, 2019, 2020, 2021, 2022, 2023, 2024, 2025]
let enableCompilerOptimizations = false

let package = Package(
    name: "AdventOfCode",
    platforms: [.macOS(.v14)],
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
            swiftSettings: swiftSettings()
        ),
        .testTarget(
            name: "AdventKitTests",
            dependencies: ["AdventKit"],
            swiftSettings: swiftSettings()
        ),
    ]

    for year in years {
        targets += [
            .target(
                name: "AOC\(year)",
                dependencies: ["AdventKit"],
                swiftSettings: swiftSettings()
            ),
            .testTarget(
                name: "AOC\(year)Tests",
                dependencies: [.target(name: "AOC\(year)")],
                resources: [.copy("Resources")],
                swiftSettings: swiftSettings()
            )
        ]
    }

    return targets
}

func swiftSettings() -> [SwiftSetting] {
    [
        enableCompilerOptimizations ? .unsafeFlags(["-O"]) : nil,
    ].compactMap { $0 }
}
