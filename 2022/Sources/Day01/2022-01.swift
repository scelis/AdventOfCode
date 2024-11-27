import AdventKit
import Foundation

struct Day01: Day {
    func run() async throws -> (Int, Int) {
        let sortedElves = input()
            .components(separatedBy: "\n\n")
            .map { $0.components(separatedBy: "\n").map({ Int($0)! }).reduce(0, +) }
            .sorted(by: >)

        async let p1 = part1(sortedElves: sortedElves)
        async let p2 = part2(sortedElves: sortedElves)
        return try await (p1, p2)
    }

    func part1(sortedElves: [Int]) async throws -> Int {
        return sortedElves.first!
    }

    func part2(sortedElves: [Int]) async throws -> Int {
        return sortedElves
            .prefix(3)
            .reduce(0, +)
    }
}
