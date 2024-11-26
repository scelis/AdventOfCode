import AdventKit2
import Algorithms
import Foundation

struct Day09: Day {

    func run() async throws -> (Int, Int) {
        let graph = parseGraph()
        async let p1 = findRoute(graph: graph, shortest: true)
        async let p2 = findRoute(graph: graph, shortest: false)
        return try await (p1, p2)
    }

    func parseGraph() -> [String: [String: Int]] {
        var graph: [String: [String: Int]] = [:]

        inputLines()
            .map { $0.components(separatedBy: .whitespaces) }
            .forEach { components in
                graph[components[0], default: [:]][components[2]] = Int(components[4])!
                graph[components[2], default: [:]][components[0]] = Int(components[4])!
            }

        return graph
    }

    func findRoute(graph: [String: [String: Int]], shortest: Bool) async throws -> Int {
        var best = shortest ? Int.max : 0

        for path in graph.keys.permutations() {
            let distance = path
                .adjacentPairs()
                .map { graph[$0]![$1]! }
                .reduce(0, +)

            best = shortest ? min(best, distance) : max(best, distance)
        }

        return best
    }
}
