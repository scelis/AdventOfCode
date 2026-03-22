import AdventKit
import Algorithms
import Foundation

struct Day02: Day {
    func run(input: String) async throws -> (Int, Int) {
        let reports = input.integerArrays
        async let p1 = part1(reports: reports)
        async let p2 = part2(reports: reports)
        return try await (p1, p2)
    }

    func part1(reports: [[Int]]) async throws -> Int {
        reports
            .filter { isSafe(levels: $0) }
            .count
    }

    func part2(reports: [[Int]]) async throws -> Int {
        reports
            .filter { isSafeWithProblemDampener(levels: $0) }
            .count
    }

    func isSafe(levels: [Int]) -> Bool {
        let pairs = levels.adjacentPairs()
        return
            pairs.allSatisfy { (1...3).contains($0 - $1) } ||
            pairs.allSatisfy { ((-3)...(-1)).contains($0 - $1) }
    }

    func isSafeWithProblemDampener(levels: [Int]) -> Bool {
        levels.indices.anySatisfy { isSafe(levels: levels.removing(at: $0)) }
    }
}

