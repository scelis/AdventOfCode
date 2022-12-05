import AdventKit
import Algorithms
import Foundation

class Day11: Day {
    enum Tile: Character {
        case floor = "."
        case emptySeat = "L"
        case occupiedSeat = "#"
    }

    lazy var tiles: [Coordinate2D<Int>: Tile] = {
        var dict = [Coordinate2D<Int>: Tile]()
        for (y, line) in inputLines.enumerated() {
            for (x, character) in line.enumerated() {
                dict[Coordinate2D(x: x, y: y)] = Tile(rawValue: character)
            }
        }
        return dict
    }()

    func solve(part: Int) -> Int {
        var current = tiles

        while true {
            var next = current
            var changed = false

            for (coordinate, tile) in current {
                if tile == .floor { continue }

                var sum = 0
                if part == 1 {
                    sum = CardinalDirection.allDirections
                        .map({ coordinate.step(inCardinalDirection: $0) })
                        .compactMap({ current[$0] })
                        .filter({ $0 == .occupiedSeat })
                        .count
                } else {
                    for direction in CardinalDirection.allDirections {
                        var steps = 1
                        walking: while true {
                            switch current[coordinate.step(inCardinalDirection: direction, distance: steps)] {
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

    override func part1() -> Any {
        return solve(part: 1)
    }

    override func part2() -> Any {
        return solve(part: 2)
    }
}
