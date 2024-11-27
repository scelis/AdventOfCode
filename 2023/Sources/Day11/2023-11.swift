import AdventKit2
import Algorithms
import Foundation

struct Day11: Day {
    
    // MARK: - Structures

    struct Universe {
        var map: [[Character]]
        var galaxies: Set<Coordinate2D>
        var columnsWithGalaxies: Set<Int>
        var rowsWithGalaxies: Set<Int>
    }

    // MARK: - Solving

    func run() async throws -> (Int, Int) {
        let universe = parseUniverse()
        async let p1 = part1(universe: universe)
        async let p2 = part2(universe: universe)
        return try await (p1, p2)
    }

    func part1(universe: Universe) async throws -> Int {
        sumOfShortestPaths(universe: universe, expansion: 2)
    }

    func part2(universe: Universe) async throws -> Int {
        sumOfShortestPaths(universe: universe, expansion: 1000000)
    }

    func sumOfShortestPaths(universe: Universe, expansion: Int) -> Int {
        universe.galaxies.combinations(ofCount: 2)
            .map { combo in
                var distance = 0
                for x in min(combo[0].x, combo[1].x)..<max(combo[0].x, combo[1].x) {
                    distance += universe.columnsWithGalaxies.contains(x) ? 1 : expansion
                }
                for y in min(combo[0].y, combo[1].y)..<max(combo[0].y, combo[1].y) {
                    distance += universe.rowsWithGalaxies.contains(y) ? 1 : expansion
                }
                return distance
            }
            .reduce(0, +)
    }

    // MARK: - Parsing

    func parseUniverse() -> Universe {
        let map: [[Character]] = inputLines().map({ Array($0) })
        var galaxies: Set<Coordinate2D> = []
        var columnsWithGalaxies: Set<Int> = []
        var rowsWithGalaxies: Set<Int> = []

        for y in 0..<map.count {
            for x in 0..<map[y].count {
                let character = map[y][x]
                if character == "#" {
                    galaxies.insert(Coordinate2D(x: x, y: y))
                    columnsWithGalaxies.insert(x)
                    rowsWithGalaxies.insert(y)
                }
            }
        }

        return Universe(
            map: map,
            galaxies: galaxies,
            columnsWithGalaxies: columnsWithGalaxies,
            rowsWithGalaxies: rowsWithGalaxies
        )
    }
}
