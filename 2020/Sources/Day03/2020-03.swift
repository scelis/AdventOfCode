import AdventKit
import Foundation

struct Day03: Day {
    var lines: [String] = []

    init() {
        lines = inputLines()
    }

    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        return numTrees(onSlope: Coordinate2D(x: 3, y: 1))
    }

    func part2() async throws -> Int {
        let slopes = [
            Coordinate2D(x: 1, y: 1),
            Coordinate2D(x: 3, y: 1),
            Coordinate2D(x: 5, y: 1),
            Coordinate2D(x: 7, y: 1),
            Coordinate2D(x: 1, y: 2)
        ]
        return slopes
            .map({ numTrees(onSlope: $0) })
            .reduce(1, *)
    }

    func numTrees(onSlope slope: Coordinate2D) -> Int {
        var numTrees = 0
        let xLength = lines[0].count
        var current = Coordinate2D(x: 0, y: 0)
        while current.y < lines.count {
            if lines[current.y][current.x] == "#" {
                numTrees += 1
            }
            current = Coordinate2D(
                x: (current.x + slope.x) % xLength,
                y: current.y + slope.y
            )
        }
        return numTrees
    }
}

