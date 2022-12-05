import AdventKit
import Foundation

class Day03: Day {
    override func part1() -> Any {
        return numTrees(onSlope: Coordinate2D(x: 3, y: 1)).description
    }

    override func part2() -> Any {
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
            .description
    }

    func numTrees(onSlope slope: Coordinate2D<Int>) -> Int {
        var numTrees = 0
        let xLength = inputLines[0].count
        var current = Coordinate2D(x: 0, y: 0)
        while current.y < inputLines.count {
            if inputLines[current.y][current.x] == "#" {
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

