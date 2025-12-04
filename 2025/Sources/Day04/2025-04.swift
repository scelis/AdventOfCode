import AdventKit
import Foundation

struct Day04: Day {
    func run() async throws -> (Int, Int) {
        let neighborCounts = parseNeighborCounts()
        async let p1 = part1(neighborCounts: neighborCounts)
        async let p2 = part2(neighborCounts: neighborCounts)
        return try await (p1, p2)
    }

    func part1(neighborCounts: [Coordinate2D: Int]) async throws -> Int {
        neighborCounts
            .filter { $0.value < 4 }
            .count
    }

    func part2(neighborCounts: [Coordinate2D: Int]) async throws -> Int {
        var neighborCounts = neighborCounts
        var numRemoved = 0

        while true {
            var next = neighborCounts
            for (coordinate, count) in neighborCounts where count < 4 {
                next[coordinate] = nil
                numRemoved += 1

                for direction in Direction.cardinalAndIntercardinalDirections {
                    let step = coordinate.step(inDirection: direction)
                    if let count = next[step] {
                        next[step] = count - 1
                    }
                }
            }

            if next.count == neighborCounts.count {
                return numRemoved
            } else {
                neighborCounts = next
            }
        }
    }

    func parseNeighborCounts() -> [Coordinate2D: Int] {
        let map = inputCharacterArrays()
        var counts: [Coordinate2D: Int] = [:]
        for (y, row) in map.enumerated() {
            for (x, character) in row.enumerated() where character == "@" {
                let coordinate = Coordinate2D(x: x, y: y)
                var numNeighbors = 0
                for direction in Direction.cardinalAndIntercardinalDirections {
                    let step = coordinate.step(inDirection: direction)
                    if map[safe: step.y]?[safe: step.x] == "@" {
                        numNeighbors += 1
                    }
                }
                counts[coordinate] = numNeighbors
            }
        }
        return counts
    }
}
