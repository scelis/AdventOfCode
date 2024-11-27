import AdventKit2
import Algorithms
import Foundation

struct Day14: Day {
    enum Tile {
        case rock
        case sand
    }

    class Cave {
        var tiles: [Coordinate2D: Tile]
        var floorY: Int?

        init(string: String, addFloor: Bool) throws {
            var tiles: [Coordinate2D: Tile] = [:]
            for line in string.components(separatedBy: .newlines) {
                let coordinateStrings = line.components(separatedBy: " -> ")
                let coordinates: [Coordinate2D] = coordinateStrings.map { string in
                    let components = string.components(separatedBy: ",").map { Int($0)! }
                    return Coordinate2D(x: components[0], y: components[1])
                }

                for pair in coordinates.adjacentPairs() {
                    tiles[pair.0] = .rock
                    tiles[pair.1] = .rock
                    var step = pair.0.step(toward: pair.1)
                    while step != pair.1 {
                        tiles[step] = .rock
                        step = step.step(toward: pair.1)
                    }
                }
            }

            self.tiles = tiles
            self.floorY = addFloor ? (tiles.keys.map { $0.y }.max()! + 2) : nil
        }

        lazy var xLocationsOfFilledTiles: Set<Int> = {
            tiles.keys.reduce(into: []) { $0.insert($1.x) }
        }()

        func run() -> Int {
            var unitsOfSand = 0
            var path = [Coordinate2D(x: 500, y: 0)]

            while let location = path.last {
                if floorY == nil && !xLocationsOfFilledTiles.contains(location.x) {
                    break
                }

                var addSand = false
                if let floorY, location.y == floorY - 1 {
                    addSand = true
                } else if tiles[location.step(inDirection: .south)] == nil {
                    path.append(location.step(inDirection: .south))
                } else if tiles[location.step(inDirection: .southWest)] == nil {
                    path.append(location.step(inDirection: .southWest))
                } else if tiles[location.step(inDirection: .southEast)] == nil {
                    path.append(location.step(inDirection: .southEast))
                } else {
                    addSand = true
                }

                if addSand {
                    tiles[location] = .sand
                    unitsOfSand += 1
                    path.removeLast()
                }
            }

            return unitsOfSand
        }
    }

    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        return try Cave(string: input(), addFloor: false).run()
    }

    func part2() async throws -> Int {
        return try Cave(string: input(), addFloor: true).run()
    }
}
