import AdventKit
import Foundation

struct Day03: Day {
    func run(input: String) async throws -> (Int, Int) {
        let lines = input.lines
        async let p1 = part1(lines: lines)
        async let p2 = part2(lines: lines)
        return try await (p1, p2)
    }

    func part1(lines: [String]) async throws -> Int {
        return numTrees(onSlope: Coordinate2D(x: 3, y: 1), lines: lines)
    }

    func part2(lines: [String]) async throws -> Int {
        let slopes = [
            Coordinate2D(x: 1, y: 1),
            Coordinate2D(x: 3, y: 1),
            Coordinate2D(x: 5, y: 1),
            Coordinate2D(x: 7, y: 1),
            Coordinate2D(x: 1, y: 2)
        ]
        return slopes
            .map({ numTrees(onSlope: $0, lines: lines) })
            .reduce(1, *)
    }

    func numTrees(onSlope slope: Coordinate2D, lines: [String]) -> Int {
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

