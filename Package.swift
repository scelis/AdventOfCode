// swift-tools-version:5.9

import Foundation
import PackageDescription

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
    targets: [
        .target(
            name: "AdventKit",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
            ],
            path: "AdventKit/Sources"
        ),
        .testTarget(name: "AdventKitTests", dependencies: ["AdventKit"], path: "AdventKit/Tests"),

        .target(name: "AOC2015", dependencies: ["AdventKit"], path: "2015/Sources", exclude: inputFiles(for: 2015)),
        .testTarget(name: "AOC2015Tests", dependencies: ["AOC2015"], path: "2015/Tests"),

        .target(name: "AOC2019", dependencies: ["AdventKit"], path: "2019/Sources", exclude: inputFiles(for: 2019)),
        .testTarget(name: "AOC2019Tests", dependencies: ["AOC2019"], path: "2019/Tests"),

        .target(name: "AOC2020", dependencies: ["AdventKit"], path: "2020/Sources", exclude: inputFiles(for: 2020)),
        .testTarget(name: "AOC2020Tests", dependencies: ["AOC2020"], path: "2020/Tests"),

        .target(name: "AOC2021", dependencies: ["AdventKit"], path: "2021/Sources", exclude: inputFiles(for: 2021)),
        .testTarget(name: "AOC2021Tests", dependencies: ["AOC2021"], path: "2021/Tests"),

        .target(name: "AOC2022", dependencies: ["AdventKit"], path: "2022/Sources", exclude: inputFiles(for: 2022)),
        .testTarget(name: "AOC2022Tests", dependencies: ["AOC2022"], path: "2022/Tests"),

        .target(name: "AOC2023", dependencies: ["AdventKit"], path: "2023/Sources", exclude: inputFiles(for: 2023)),
        .testTarget(name: "AOC2023Tests", dependencies: ["AOC2023"], path: "2023/Tests"),

        .executableTarget(
            name: "AdventOfCode",
            dependencies: ["AOC2015", "AOC2019", "AOC2020", "AOC2021", "AOC2022", "AOC2023"],
            path: "AdventOfCode"
        ),
    ]
)

func inputFiles(for year: Int) -> [String] {
    let sourceDirectory = URL(fileURLWithPath: #file).deletingLastPathComponent()
    return (1...25).compactMap { day in
        let fragment = "Day\(String(format: "%02d", day))/input.txt"
        let path = sourceDirectory.appending(path: "\(year)/Sources/\(fragment)").path(percentEncoded: false)
        return FileManager.default.fileExists(atPath: path) ? fragment : nil
    }
}
