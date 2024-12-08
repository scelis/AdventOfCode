import AdventKit
import Algorithms
import Foundation

struct Day08: Day {
    func run() async throws -> (Int, Int) {
        let (locations, xRange, yRange) = parseInput()
        async let p1 = part1(antennaLocations: locations, xRange: xRange, yRange: yRange)
        async let p2 = part2(antennaLocations: locations, xRange: xRange, yRange: yRange)
        return try await (p1, p2)
    }

    func part1(
        antennaLocations locations: [Character: Set<Coordinate2D>],
        xRange: Range<Int>,
        yRange: Range<Int>
    ) async throws -> Int {
        var antinodeLocations: Set<Coordinate2D> = []
        for coordinates in locations.values {
            for pair in coordinates.combinations(ofCount: 2) {
                let dx = pair[1].x - pair[0].x
                let dy = pair[1].y - pair[0].y
                let c1 = Coordinate2D(x: pair[0].x - dx, y: pair[0].y - dy)
                let c2 = Coordinate2D(x: pair[1].x + dx, y: pair[1].y + dy)
                for coordinate in [c1, c2] {
                    if xRange.contains(coordinate.x) && yRange.contains(coordinate.y) {
                        antinodeLocations.insert(coordinate)
                    }
                }
            }
        }

        return antinodeLocations.count
    }

    func part2(
        antennaLocations locations: [Character: Set<Coordinate2D>],
        xRange: Range<Int>,
        yRange: Range<Int>
    ) async throws -> Int {
        var antinodeLocations: Set<Coordinate2D> = []
        for coordinates in locations.values {
            for pair in coordinates.combinations(ofCount: 2) {
                for sign in [-1, 1] {
                    var coordinate = pair[0]
                    while xRange.contains(coordinate.x) && yRange.contains(coordinate.y) {
                        antinodeLocations.insert(coordinate)
                        coordinate.x = coordinate.x - (pair[1].x - pair[0].x) * sign
                        coordinate.y = coordinate.y - (pair[1].y - pair[0].y) * sign
                    }
                }
            }
        }

        return antinodeLocations.count
    }

    func parseInput() -> ([Character: Set<Coordinate2D>], Range<Int>, Range<Int>) {
        let graph = inputCharacterArrays()
        var locations: [Character: Set<Coordinate2D>] = [:]
        for (y, row) in graph.enumerated() {
            for (x, character) in row.enumerated() where character != "." {
                locations[character, default: []].insert(Coordinate2D(x: x, y: y))
            }
        }

        return (locations, graph.indices, graph[0].indices)
    }
}
