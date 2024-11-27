import AdventKit
import Algorithms
import Foundation

struct Day13: Day {

    // MARK: Solving

    func run() async throws -> (Int, Int) {
        let graph = parseGraph()
        async let p1 = part1(graph: graph)
        async let p2 = part2(graph: graph)
        return try await (p1, p2)
    }

    func part1(graph: [String: [String: Int]]) async throws -> Int {
        findOptimalHappiness(graph: graph)
    }

    func part2(graph: [String: [String: Int]]) async throws -> Int {
        var graph = graph
        graph["Me"] = [:]
        for name in graph.keys {
            graph[name]!["Me"] = 0
            graph["Me"]![name] = 0
        }

        return findOptimalHappiness(graph: graph)
    }

    func findOptimalHappiness(graph: [String: [String: Int]]) -> Int {
        var best = 0

        for path in graph.keys.permutations() {
            let happiness = (path + [path.first!])
                .adjacentPairs()
                .map { graph[$0]![$1]! + graph[$1]![$0]! }
                .reduce(0, +)

            best = max(best, happiness)
        }

        return best
    }


    // MARK: Parsing

    func parseGraph() -> [String: [String: Int]] {
        let regex = #/^(\w+) would (gain|lose) (\d+) happiness units by sitting next to (\w+)./#

        var graph: [String: [String: Int]] = [:]
        inputLines().forEach { line in
            let match = line.firstMatch(of: regex)!
            let name1 = String(match.1)
            let isGain = match.2 == "gain"
            let amount = Int(match.3)!
            let name2 = String(match.4)
            graph[name1, default: [:]][name2] = (isGain ? 1 : -1) * amount
        }

        return graph
    }
}
