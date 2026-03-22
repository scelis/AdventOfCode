import AdventKit
import Algorithms
import Foundation

struct Day11: Day {
    typealias Graph = [String: Set<String>]

    func run(input: String) async throws -> (Int, Int) {
        let graph = parseGraph(input: input)
        let allNodes = allNodes(graph: graph)
        let indegree = computeIndegree(graph: graph, allNodes: allNodes)
        let sorted = topologicalSort(graph: graph, indegree: indegree)

        async let p1 = part1(graph: graph, sortedNodes: sorted)
        async let p2 = part2(graph: graph, sortedNodes: sorted)
        return await (p1, p2)
    }

    func part1(graph: Graph, sortedNodes: [String]) async -> Int {
        countPaths(from: "you", to: "out", graph: graph, sortedNodes: sortedNodes)
    }

    func part2(graph: Graph, sortedNodes: [String]) async -> Int {
        guard
            let dacIndex = sortedNodes.firstIndex(of: "dac"),
            let fftIndex = sortedNodes.firstIndex(of: "fft")
        else {
            return 0
        }

        let path: [String]
        if dacIndex < fftIndex {
            path = ["svr", "dac", "fft", "out"]
        } else {
            path = ["svr", "fft", "dac", "out"]
        }

        return path
            .adjacentPairs()
            .map { countPaths(from: $0, to: $1, graph: graph, sortedNodes: sortedNodes) }
            .reduce(1, *)
    }

    func allNodes(graph: Graph) -> Set<String> {
        var allNodes = Set(graph.keys)
        for neighbors in graph.values {
            allNodes.formUnion(neighbors)
        }
        return allNodes
    }

    /// Computes the number of paths into every node.
    func computeIndegree(graph: Graph, allNodes: Set<String>) -> [String: Int] {
        var indegree: [String: Int] = [:]
        for node in allNodes {
            indegree[node] = 0
        }
        for (_, neighbors) in graph {
            for v in neighbors {
                indegree[v]! += 1
            }
        }
        return indegree
    }

    /// Sort nodes in order using Kahn's algorithm. Works because this is a directed acyclic graph.
    func topologicalSort(graph: Graph, indegree: [String: Int]) -> [String] {
        var indegree = indegree
        var queue: [String] = []

        for (node, number) in indegree where number == 0 {
            queue.append(node)
        }

        var sorted: [String] = []
        while !queue.isEmpty {
            let u = queue.removeFirst()
            sorted.append(u)

            for v in graph[u] ?? [] {
                indegree[v]! -= 1
                if indegree[v] == 0 {
                    queue.append(v)
                }
            }
        }

        return sorted
    }

    func countPaths(
        from: String,
        to: String,
        graph: [String: Set<String>],
        sortedNodes: [String]
    ) -> Int {
        var dp: [String: Int] = [:]
        for node in sortedNodes {
            dp[node] = 0
        }
        dp[from] = 1

        for u in sortedNodes {
            guard let ways = dp[u], ways > 0 else { continue }
            if let neighbors = graph[u] {
                for v in neighbors {
                    dp[v]! += ways
                }
            }
        }

        return dp[to] ?? 0
    }

    func parseGraph(input: String) -> [String: Set<String>] {
        input.lines.reduce(into: [:]) { partialResult, line in
            let parts = line.components(separatedBy: ":")
            let set = parts[1]
                .trimmingCharacters(in: .whitespaces)
                .components(separatedBy: " ")
            partialResult[parts[0]] = Set(set)
        }
    }
}
