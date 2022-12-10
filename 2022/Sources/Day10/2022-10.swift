import AdventKit
import Foundation

public class Day10: Day<Int, String> {
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

    private lazy var commands: [Command] = {
        return inputLines.map { Command(string: $0) }
    }()

    public override func part1() throws -> Int {
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

    public override func part2() throws -> String {
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
