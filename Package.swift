// swift-tools-version:6.0

import Foundation
import PackageDescription

let years: [Int] = [2015, 2019, 2020, 2021, 2022, 2023, 2024]
let enableCompilerOptimizations = false

let package = Package(
    name: "AdventOfCode",
    platforms: [.macOS(.v14)],
    products: [
        .library(name: "AdventKit", targets: ["AdventKit"]),
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
            swiftSettings: swiftSettings()
        ),
        .testTarget(
            name: "AdventKitTests",
            dependencies: ["AdventKit"],
            path: "AdventKit/Tests",
            swiftSettings: swiftSettings()
        ),
        .executableTarget(
            name: "AdventOfCode",
            dependencies: years.map { .target(name: "AOC\($0)") },
            path: "AdventOfCode",
            swiftSettings: swiftSettings()
        ),
    ]

    for year in years {
        targets += [
            .target(
                name: "AOC\(year)",
                dependencies: ["AdventKit"],
                path: "\(year)/Sources",
                exclude: inputFiles(forYear: year),
                swiftSettings: swiftSettings()
            ),
            .testTarget(
                name: "AOC\(year)Tests",
                dependencies: [.target(name: "AOC\(year)")],
                path: "\(year)/Tests",
                swiftSettings: swiftSettings()
            )
        ]
    }

    return targets
}

func inputFiles(forYear year: Int) -> [String] {
    let sourceDirectory = URL(fileURLWithPath: #file).deletingLastPathComponent()
    return (1...25).compactMap { day in
        let fragment = "Day\(String(format: "%02d", day))/input.txt"
        let path = sourceDirectory.appending(path: "\(year)/Sources/\(fragment)").path(percentEncoded: false)
        return FileManager.default.fileExists(atPath: path) ? fragment : nil
    }
}

func swiftSettings() -> [SwiftSetting] {
    [
        enableCompilerOptimizations ? .unsafeFlags(["-O"]) : nil,
    ].compactMap { $0 }
}
