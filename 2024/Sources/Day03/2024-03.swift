import AdventKit
import Foundation

struct Day03: Day {
    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        let regex = #/mul\((\d+),(\d+)\)/#
        return input()
            .matches(of: regex)
            .reduce(0) { $0 + Int($1.1)! * Int($1.2)! }
    }

    func part2() async throws -> Int {
        let regex = #/(mul\((\d+),(\d+)\))|(do\(\))|(don't\(\))/#
        var isEnabled = true
        var total = 0

        for match in input().matches(of: regex) {
            if match.0 == "do()" {
                isEnabled = true
            } else if match.0 == "don't()" {
                isEnabled = false
            } else if isEnabled {
                total += Int(match.2!)! * Int(match.3!)!
            }
        }

        return total
    }
}
