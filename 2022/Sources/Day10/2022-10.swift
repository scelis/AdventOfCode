import AdventKit
import Foundation

struct Day10: Day {
    enum Command {
        case noop
        case addx(Int)

        init(string: String) {
            let components = string.components(separatedBy: .whitespaces)
            switch components[0] {
            case "noop": self = .noop
            case "addx": self = .addx(Int(components[1])!)
            default: fatalError()
            }
        }

        var cyclesToComplete: Int {
            switch self {
            case .noop: return 1
            case .addx: return 2
            }
        }
    }

    func parseCommands() -> [Command] {
        return inputLines().map { Command(string: $0) }
    }

    func run() async throws -> (Int, String) {
        let commands = parseCommands()
        async let p1 = part1(commands: commands)
        async let p2 = part2(commands: commands)
        return try await (p1, p2)
    }

    func part1(commands: [Command]) async throws -> Int {
        var x = 1
        var cycle = 0
        var sum = 0

        for command in commands {
            for _ in 0..<command.cyclesToComplete {
                cycle += 1

                if (cycle - 20) % 40 == 0 {
                    sum += (x * cycle)
                }
            }

            if case .addx(let value) = command {
                x += value
            }
        }

        return sum
    }

    func part2(commands: [Command]) async throws -> String {
        var x = 1
        var cycle = 0
        var output = ""

        for command in commands {
            for _ in 0..<command.cyclesToComplete {
                if cycle % 40 == 0 {
                    output += "\n"
                }

                cycle += 1

                if abs(x - (cycle - 1) % 40) <= 1 {
                    output += "#"
                } else {
                    output += "."
                }
            }

            if case .addx(let value) = command {
                x += value
            }
        }

        return output
    }
}
