import AdventKit
import Algorithms
import Foundation

struct Day02: Day {
    enum Command {
        case forward(Int)
        case up(Int)
        case down(Int)

        init(string: String) {
            let pair = string.components(separatedBy: .whitespacesAndNewlines)
            let num = Int(pair[1])!
            switch pair[0] {
            case "forward": self = .forward(num)
            case "down": self = .down(num)
            case "up": self = .up(num)
            default: fatalError()
            }
        }
    }

    struct Position {
        var horizontal = 0
        var depth = 0
        var aim = 0

        func apply1(command: Command) -> Position {
            var position = self

            switch command {
            case .forward(let amount):
                position.horizontal += amount
            case .down(let amount):
                position.depth += amount
            case .up(let amount):
                position.depth -= amount
            }

            return position
        }

        func apply2(command: Command) -> Position {
            var position = self

            switch command {
            case .forward(let amount):
                position.horizontal += amount
                position.depth += position.aim * amount
            case .down(let amount):
                position.aim += amount
            case .up(let amount):
                position.aim -= amount
            }

            return position
        }
    }

    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        let finalPosition = input()
            .components(separatedBy: .newlines)
            .map { Command(string: $0) }
            .reduce(Position()) { $0.apply1(command: $1) }

        return finalPosition.depth * finalPosition.horizontal
    }

    func part2() async throws -> Int {
        let finalPosition = input()
            .components(separatedBy: .newlines)
            .map { Command(string: $0) }
            .reduce(Position()) { $0.apply2(command: $1) }

        return finalPosition.depth * finalPosition.horizontal
    }
}
