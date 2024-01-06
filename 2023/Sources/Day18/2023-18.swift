import AdventKit
import Algorithms
import Foundation

public struct Day18: Day {

    // MARK: - Structures

    struct Command {
        var direction: Direction
        var distance: Int
        var color: String

        func actualDirection(usingHex: Bool) -> Direction {
            if usingHex {
                switch color.last {
                case "0": return .right
                case "1": return .down
                case "2": return .left
                case "3": return .up
                default: fatalError()
                }
            } else {
                return direction
            }
        }

        func actualDistance(usingHex: Bool) -> Int {
            if usingHex {
                return Int(color.dropLast(), radix: 16)!
            } else {
                return distance
            }
        }
    }

    // MARK: - Solving

    // Below the starting corners vary by input.

    public func part1() async throws -> Int {
        solve(usingHex: false, startingCorner: .southWest)
    }

    public func part2() async throws -> Int {
        solve(usingHex: true, startingCorner: .southWest)
    }

    func solve(usingHex: Bool, startingCorner: Direction) -> Int {
        var coordinate = Coordinate2D.zero
        var corner = startingCorner
        var vertices: [Coordinate2D] = [coordinate]

        Self.commands.adjacentPairs().forEach { (a, b) in
            let direction = a.actualDirection(usingHex: usingHex)
            let nextDirection = b.actualDirection(usingHex: usingHex)
            let distance = a.actualDistance(usingHex: usingHex)

            if corner.dx == direction.dx + nextDirection.dx && corner.dy == direction.dy + nextDirection.dy {
                coordinate = coordinate.step(inDirection: direction, distance: distance - 1)
                corner = corner.turnLeft()
            } else if corner.dx != direction.dx + nextDirection.dx && corner.dy != direction.dy + nextDirection.dy {
                coordinate = coordinate.step(inDirection: direction, distance: distance + 1)
                corner = corner.turnRight()
            } else {
                coordinate = coordinate.step(inDirection: direction, distance: distance)
            }

            vertices.append(coordinate)
        }

        return Int(area(vertices: vertices))
    }

    /// Using the shoelace algorithm
    func area(vertices: [Coordinate2D]) -> Double {
        let sum = vertices
            .adjacentPairs()
            .reduce(0) { partialResult, pair in
                return partialResult + pair.0.x * pair.1.y - pair.0.y * pair.1.x
            }

        return Double(sum) / 2
    }

    // MARK: - Parsing

    private static let commandRegex = #/^(L|D|U|R) (\d+) \(\#([0-9a-f]{6})\)$/#

    private static var commands: [Command] = {
        input().components(separatedBy: .newlines).map { parseCommand(string: $0) }
    }()

    private static func parseCommand(string: String) -> Command {
        let match = string.wholeMatch(of: commandRegex)!
        let direction = Direction(rawValue: String(match.1))!
        let distance = Int(match.2)!
        let color = String(match.3)
        return Command(direction: direction, distance: distance, color: color)
    }
}
