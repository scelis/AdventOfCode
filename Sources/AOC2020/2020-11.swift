import AdventKit
import Algorithms
import Foundation

struct Day11: Day {
    enum Tile: Character {
        case floor = "."
        case emptySeat = "L"
        case occupiedSeat = "#"
    }

    func parseTiles(input: String) -> [Coordinate2D: Tile] {
        var dict = [Coordinate2D: Tile]()
        for (y, line) in input.lines.enumerated() {
            for (x, character) in line.enumerated() {
                dict[Coordinate2D(x: x, y: y)] = Tile(rawValue: character)
            }
        }
        return dict
    }

    func solve(tiles: [Coordinate2D: Tile], part: Int) -> Int {
        var current = tiles

        while true {
            var next = current
            var changed = false

            for (coordinate, tile) in current {
                if tile == .floor { continue }

                var sum = 0
                if part == 1 {
                    sum = Direction.cardinalAndIntercardinalDirections
                        .map({ coordinate.step(inDirection: $0) })
                        .compactMap({ current[$0] })
                        .filter({ $0 == .occupiedSeat })
                        .count
                } else {
                    for direction in Direction.cardinalAndIntercardinalDirections {
                        var steps = 1
                        walking: while true {
                            switch current[coordinate.step(inDirection: direction, distance: steps)] {
                            case .emptySeat:
                                break walking
                            case .occupiedSeat:
                                sum += 1
                                break walking
                            case .floor:
                                steps += 1
                                continue walking
                            case nil:
                                break walking
                            }
                        }
                    }
                }

                if tile == .emptySeat && sum == 0 {
                    next[coordinate] = .occupiedSeat
                    changed = true
                } else if tile == .occupiedSeat && sum >= (part == 1 ? 4 : 5) {
                    next[coordinate] = .emptySeat
                    changed = true
                }
            }

            if !changed {
                return current.values.filter({ $0 == .occupiedSeat }).count
            } else {
                current = next
            }
        }
    }

    func run(input: String) async throws -> (Int, Int) {
        let tiles = parseTiles(input: input)
        async let p1 = part1(tiles: tiles)
        async let p2 = part2(tiles: tiles)
        return try await (p1, p2)
    }

    func part1(tiles: [Coordinate2D: Tile]) async throws -> Int {
        return solve(tiles: tiles, part: 1)
    }

    func part2(tiles: [Coordinate2D: Tile]) async throws -> Int {
        return solve(tiles: tiles, part: 2)
    }
}
