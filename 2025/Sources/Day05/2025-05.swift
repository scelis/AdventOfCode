import AdventKit
import Foundation

struct Day05: Day {
    func run() async throws -> (Int, Int) {
        let (ranges, ids) = parseInput()
        let indexSet = ranges.reduce(into: IndexSet()) { $0.insert(integersIn: $1) }
        let part1 = ids.reduce(0) { $0 + (indexSet.contains($1) ? 1 : 0) }
        let part2 = indexSet.count
        return (part1, part2)
    }

    func parseInput() -> (ranges: [ClosedRange<Int>], ids: [Int]) {
        let parts = input().components(separatedBy: "\n\n")

        let ranges = parts[0]
            .components(separatedBy: .newlines)
            .map { line in
                let pair = line.components(separatedBy: "-").compactMap(Int.init)
                return pair[0]...pair[1]
            }

        let ids = parts[1]
            .components(separatedBy: .newlines)
            .compactMap(Int.init)

        return (ranges: ranges, ids: ids)
    }
}
