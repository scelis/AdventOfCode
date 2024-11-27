import AdventKit2
import Algorithms
import Foundation

struct Day06: Day {
    var lanternFish: [Int] {
        return input().components(separatedBy: ",").map({ Int($0)! })
    }

    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        var state = lanternFish

        for _ in 0..<80 {
            var next: [Int] = []
            for i in state {
                if i == 0 {
                    next.append(6)
                    next.append(8)
                } else {
                    next.append(i - 1)
                }
            }
            state = next
        }

        return state
            .count
    }

    func part2() async throws -> Int {
        var counts: [Int: Int] = [:]
        for fish in lanternFish {
            counts[fish] = (counts[fish] ?? 0) + 1
        }

        for _ in 0..<256 {
            var next: [Int: Int] = [:]
            for (daysLeft, count) in counts {
                if daysLeft == 0 {
                    next[6] = (next[6] ?? 0) + count
                    next[8] = (next[8] ?? 0) + count
                } else {
                    next[daysLeft - 1] = (next[daysLeft - 1] ?? 0) + count
                }
            }
            counts = next
        }

        return counts
            .values
            .reduce(0, +)
    }
}
