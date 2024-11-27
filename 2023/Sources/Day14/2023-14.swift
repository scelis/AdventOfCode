import AdventKit2
import Foundation

struct Day14: Day {

    // MARK: - Structures

    enum Tile: Character {
        case roundRock = "O"
        case cubeRock = "#"
        case empty = "."
    }

    // MARK: - Solving

    func run() async throws -> (Int, Int) {
        let tiles = parseTiles()
        async let p1 = part1(tiles: tiles)
        async let p2 = part2(tiles: tiles)
        return try await (p1, p2)
    }

    func part1(tiles: [[Tile]]) async throws -> Int {
        return calculateLoad(tiles: tilt(tiles: tiles, inDirection: .north))
    }

    func part2(tiles: [[Tile]]) async throws -> Int {
        var tiles = tiles
        var work: [[[Tile]]: Int] = [:]

        let runCycle = {
            for direction in [Direction.north, .west, .south, .east] {
                tiles = tilt(tiles: tiles, inDirection: direction)
            }
        }

        var cycle = 0
        while true {
            runCycle()
            cycle += 1

            if let previous = work[tiles] {
                let cyclesLeft = (1_000_000_000 - cycle) % (cycle - previous)
                for _ in 0..<cyclesLeft {
                    runCycle()
                }
                return calculateLoad(tiles: tiles)
            } else {
                work[tiles] = cycle
            }
        }
    }

    func tilt(tiles: [[Tile]], inDirection direction: Direction) -> [[Tile]] {
        var tiles = tiles
        let width = tiles[0].count
        let height = tiles.count

        let checkSlideTile: (Coordinate2D) -> () = { coordinate in
            let tile = tiles[coordinate.y][coordinate.x]
            if tile == .roundRock {
                var newCoordinate = coordinate
                while true {
                    if
                        case let nextCoordinate = newCoordinate.step(inDirection: direction),
                        let nextTile = tiles[safe: nextCoordinate.y]?[safe: nextCoordinate.x],
                        nextTile == .empty
                    {
                        newCoordinate = nextCoordinate
                    } else {
                        break
                    }
                }

                if newCoordinate != coordinate {
                    tiles[newCoordinate.y][newCoordinate.x] = .roundRock
                    tiles[coordinate.y][coordinate.x] = .empty
                }
            }
        }

        switch direction {
        case .north:
            for y in 1..<height {
                for x in 0..<width {
                    checkSlideTile(Coordinate2D(x: x, y: y))
                }
            }
        case .south:
            for y in (0..<height-1).reversed() {
                for x in 0..<width {
                    checkSlideTile(Coordinate2D(x: x, y: y))
                }
            }
        case .west:
            for x in 1..<width {
                for y in 0..<height {
                    checkSlideTile(Coordinate2D(x: x, y: y))
                }
            }
        case .east:
            for x in (0..<width-1).reversed() {
                for y in 0..<height {
                    checkSlideTile(Coordinate2D(x: x, y: y))
                }
            }
        default:
            fatalError("Unsupported")
        }

        return tiles
    }

    func calculateLoad(tiles: [[Tile]]) -> Int {
        let width = tiles[0].count
        let height = tiles.count
        var load = 0
        for y in 0..<height {
            for x in 0..<width {
                if tiles[y][x] == .roundRock {
                    load += (height - y)
                }
            }
        }
        return load
    }

    // MARK: - Parsing

    func parseTiles() -> [[Tile]] {
        inputLines().map { line in
            line.compactMap(Tile.init)
        }
    }
}
