import AdventKit
import Foundation

struct Day15: Day {
    enum Error: Swift.Error {
        case robotNotFound
        case unexpectedRobot
    }

    enum Tile: Character {
        case floor = "."
        case wall = "#"
        case box = "O"
        case robot = "@"
        case leftBox = "["
        case rightBox = "]"
    }

    func run() async throws -> (Int, Int) {
        async let p1 = solve(expanded: false)
        async let p2 = solve(expanded: true)
        return try await (p1, p2)
    }

    func solve(expanded: Bool) async throws -> Int {
        var (tiles, directions) = parseInput(expanded: expanded)
        var robot = try findRobot(tiles: tiles)
        for direction in directions {
            var coordinatesChecked: Set<Coordinate2D> = [robot]
            var coordinatesToMove: [Coordinate2D] = [robot]
            var coordinatesToCheck: [Coordinate2D] = [robot.step(inDirection: direction)]
            var canMove = true
            while canMove, let coordinate = coordinatesToCheck.first {
                coordinatesToCheck.removeFirst()
                guard !coordinatesChecked.contains(coordinate) else { continue }
                coordinatesChecked.insert(coordinate)
                switch tiles[coordinate] {
                case .floor:
                    break
                case .wall:
                    canMove = false
                case .box:
                    coordinatesToMove.append(coordinate)
                    coordinatesToCheck.append(coordinate.step(inDirection: direction))
                case .leftBox, .rightBox:
                    coordinatesToMove.append(coordinate)
                    if tiles[coordinate] == .leftBox {
                        coordinatesToMove.append(coordinate.step(inDirection: .right))
                        coordinatesChecked.insert(coordinate.step(inDirection: .right))
                    } else {
                        coordinatesToMove.append(coordinate.step(inDirection: .left))
                        coordinatesChecked.insert(coordinate.step(inDirection: .left))
                    }

                    if direction == .left || direction == .right {
                        coordinatesToCheck.append(coordinate.step(inDirection: direction, distance: 2))
                    } else {
                        coordinatesToCheck.append(coordinate.step(inDirection: direction))
                        if tiles[coordinate] == .leftBox {
                            coordinatesToCheck.append(coordinate.step(inDirection: .right).step(inDirection: direction))
                        } else {
                            coordinatesToCheck.append(coordinate.step(inDirection: .left).step(inDirection: direction))
                        }
                    }
                case .robot:
                    throw Error.unexpectedRobot
                }
            }

            if canMove {
                for coordinate in coordinatesToMove.reversed() {
                    let newCoordinate = coordinate.step(inDirection: direction)
                    tiles[newCoordinate.y][newCoordinate.x] = tiles[coordinate]
                    tiles[coordinate.y][coordinate.x] = .floor
                }
                robot = robot.step(inDirection: direction)
            }
        }

        return calculateAnswer(tiles: tiles)
    }

    func findRobot(tiles: [[Tile]]) throws -> Coordinate2D {
        for y in tiles.indices {
            for x in tiles[y].indices {
                if tiles[y][x] == .robot {
                    return Coordinate2D(x: x, y: y)
                }
            }
        }
        throw Error.robotNotFound
    }

    func calculateAnswer(tiles: [[Tile]]) -> Int {
        var answer = 0
        for y in tiles.indices {
            for x in tiles[y].indices {
                switch tiles[y][x] {
                case .box, .leftBox: answer += y * 100 + x
                default: break
                }
            }
        }
        return answer
    }

    func parseInput(expanded: Bool) -> ([[Tile]], [Direction]) {
        let sections = input().components(separatedBy: "\n\n")

        let tiles: [[Tile]] = sections[0].components(separatedBy: .newlines).map { line -> [Tile] in
            if expanded {
                var row: [Tile] = []
                for tile in line.compactMap(Tile.init) {
                    switch tile {
                    case .box:
                        row.append(.leftBox)
                        row.append(.rightBox)
                    case .robot:
                        row.append(.robot)
                        row.append(.floor)
                    default:
                        row.append(tile)
                        row.append(tile)
                    }
                }
                return row
            } else {
                return Array(line).compactMap(Tile.init)
            }
        }

        let directions = sections[1].compactMap { character -> Direction? in
            switch character {
            case "^": .up
            case "v": .down
            case "<": .left
            case">": .right
            default: nil
            }
        }

        return (tiles, directions)
    }
}
