import AdventKit
import Foundation

struct Day10: Day {
    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        let map = parseInput()
        var work: [Coordinate2D: Set<Coordinate2D>] = [:]
        var numPeaks = 0
        for y in map.indices {
            for x in map[y].indices {
                if map[y][x] == 0 {
                    numPeaks += findPeaksReachableFrom(coordinate: Coordinate2D(x: x, y: y), inMap: map, work: &work).count
                }
            }
        }
        return numPeaks
    }

    func part2() async throws -> Int {
        let map = parseInput()
        var work: [Coordinate2D: Int] = [:]
        var score = 0
        for y in map.indices {
            for x in map[y].indices {
                if map[y][x] == 0 {
                    score += calculateRating(ofCoordinate: Coordinate2D(x: x, y: y), inMap: map, work: &work)
                }
            }
        }
        return score
    }

    func findPeaksReachableFrom(
        coordinate: Coordinate2D,
        inMap map: [[Int]],
        work: inout [Coordinate2D: Set<Coordinate2D>]
    ) -> Set<Coordinate2D> {
        if let set = work[coordinate] {
            return set
        }

        var peaks: Set<Coordinate2D> = []
        if map[coordinate] == 9 {
            peaks.insert(coordinate)
        } else {
            for neighbor in coordinate.neighboringCoordinates() where map[safe: neighbor] == map[coordinate] + 1 {
                peaks.formUnion(findPeaksReachableFrom(coordinate: neighbor, inMap: map, work: &work))
            }
        }
        work[coordinate] = peaks
        return peaks
    }

    func calculateRating(
        ofCoordinate coordinate: Coordinate2D,
        inMap map: [[Int]],
        work: inout [Coordinate2D: Int]
    ) -> Int {
        if let score = work[coordinate] {
            return score
        }

        let score: Int
        if map[coordinate] == 9 {
            score = 1
        } else {
            score = coordinate
                .neighboringCoordinates()
                .filter { map[safe: $0] == map[coordinate] + 1 }
                .map { calculateRating(ofCoordinate: $0, inMap: map, work: &work) }
                .reduce(0, +)
        }

        work[coordinate] = score
        return score
    }

    func parseInput() -> [[Int]] {
        inputLines().map { line -> [Int] in
            Array(line).map { char -> Int in
                Int(String(char))!
            }
        }
    }
}
