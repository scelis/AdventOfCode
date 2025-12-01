import AdventKit
import Foundation

struct Day01: Day {
    enum Turn {
        case left(Int)
        case right(Int)
    }

    func run() async throws -> (Int, Int) {
        var dial = 50
        var part1 = 0
        var part2 = 0

        inputLines()
            .map { parse(line: $0) }
            .forEach { turn in
                let initial = dial

                switch turn {
                case .left(let amount): dial -= amount
                case .right(let amount): dial += amount
                }

                if dial == 0 {
                    part2 += 1
                } else if dial < 0 {
                    part2 += abs(dial / 100)
                    part2 += (initial == 0) ? 0 : 1
                    dial = ((dial % 100) + 100) % 100
                } else if dial >= 100 {
                    part2 += (dial / 100)
                    dial = dial % 100
                }

                if dial == 0 {
                    part1 += 1
                }
            }

        return (part1, part2)
    }

    func parse(line: String) -> Turn {
        let amount = Int(line.dropFirst())!
        return line.hasPrefix("L") ? .left(amount) : .right(amount)
    }
}
