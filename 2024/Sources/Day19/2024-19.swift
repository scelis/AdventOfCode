import AdventKit
import Foundation

struct Day19: Day {
    func run() async throws -> (Int, Int) {
        let (towels, targetPatterns) = parseInput()
        var counts: [String: Int] = [:]
        let targetCounts = targetPatterns.map { numberOfSolutions($0, towels: towels, counts: &counts) }
        let part1 = targetCounts.filter({ $0 > 0 }).count
        let part2 = targetCounts.reduce(0, +)
        return (part1, part2)
    }

    func numberOfSolutions(
        _ targetPattern: String,
        towels: Set<String>,
        counts: inout [String: Int]
    ) -> Int {
        if let number = counts[targetPattern] {
            return number
        }

        var count = 0
        for towel in towels where targetPattern.starts(with: towel) {
            let remainder = String(targetPattern[towel.endIndex...])
            if remainder.isEmpty {
                count += 1
            } else {
                count += numberOfSolutions(remainder, towels: towels, counts: &counts)
            }
        }

        counts[targetPattern] = count
        return count
    }

    func parseInput() -> (towels: Set<String>, targetPatterns: [String]) {
        let sections = input().components(separatedBy: "\n\n")
        let towels = sections[0].components(separatedBy: ", ")
        let targetPatterns = sections[1].components(separatedBy: .whitespacesAndNewlines)
        return (Set(towels), targetPatterns)
    }
}
