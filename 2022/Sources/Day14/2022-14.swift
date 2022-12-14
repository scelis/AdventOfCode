import AdventKit
import Algorithms
import Foundation
import Parsing

public class Day14: Day<Int, Int> {
    private enum Tile {
        case rock
        case sand
    }

    private class Cave {
        var tiles: [Coordinate2D: Tile]
        var floorY: Int?

        init(string: String, addFloor: Bool) throws {
            var tiles: [Coordinate2D: Tile] = [:]
            let coordinateParser = Parse { Int.parser(); ","; Int.parser() }.map { Coordinate2D(x: $0, y: $1) }
            let coordinateArrayParser = Many { coordinateParser } separator: { " -> " }
            for line in string.components(separatedBy: .newlines) {
                let array = try coordinateArrayParser.parse(line)
                for pair in array.adjacentPairs() {
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

    public override func part1() throws -> Int {
        return try Cave(string: input, addFloor: false).run()
    }

    public override func part2() throws -> Int {
        return try Cave(string: input, addFloor: true).run()
    }
}
