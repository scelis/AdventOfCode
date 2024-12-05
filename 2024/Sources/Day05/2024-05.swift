import AdventKit
import Foundation

struct Day05: Day {

    // MARK: Solving

    func run() async throws -> (Int, Int) {
        let orderingRules = parseOrderingRules()
        let updates = parseUpdates()
        async let p1 = part1(orderingRules: orderingRules, updates: updates)
        async let p2 = part2(orderingRules: orderingRules, updates: updates)
        return try await (p1, p2)
    }

    func part1(orderingRules: [Int: Set<Int>], updates: [[Int]]) async throws -> Int {
        updates
            .filter { arePagesInCorrectOrder(pages: $0, rules: orderingRules) }
            .map { $0[$0.count / 2] }
            .reduce(0, +)
    }

    func part2(orderingRules: [Int: Set<Int>], updates: [[Int]]) async throws -> Int {
        updates
            .filter { !arePagesInCorrectOrder(pages: $0, rules: orderingRules) }
            .map { reorderPages(pages: $0, rules: orderingRules) }
            .map { $0[$0.count / 2] }
            .reduce(0, +)
    }

    func arePagesInCorrectOrder(pages: [Int], rules: [Int: Set<Int>]) -> Bool {
        for i in (1...(pages.count - 1)).reversed() {
            guard let set = rules[pages[i]] else { continue }
            for j in (0...(i - 1)).reversed() {
                if set.contains(pages[j]) {
                    return false
                }
            }
        }

        return true
    }

    func reorderPages(pages: [Int], rules: [Int: Set<Int>]) -> [Int] {
        pages.sorted { !rules[$1, default: []].contains($0) }
    }

    // MARK: Parsing

    func parseOrderingRules() -> [Int: Set<Int>] {
        input()
            .components(separatedBy: "\n\n")[0]
            .components(separatedBy: .newlines)
            .reduce(into: [:]) { result, line in
                let pair = line.components(separatedBy: "|")
                result[Int(pair[0])!, default: []].insert(Int(pair[1])!)
            }
    }

    func parseUpdates() -> [[Int]] {
        input()
            .components(separatedBy: "\n\n")[1]
            .components(separatedBy: .newlines)
            .map { $0.components(separatedBy: ",").compactMap(Int.init) }
    }
}
