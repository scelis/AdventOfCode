import AdventKit
import Algorithms
import Foundation

struct Day23: Day {
    func run(input: String) async throws -> (Int, String) {
        let allConnections = parseInput(input: input)
        async let p1 = part1(allConnections: allConnections)
        async let p2 = part2(allConnections: allConnections)
        return try await (p1, p2)
    }

    func part1(allConnections: [String: Set<String>]) async throws -> Int {
        var lanParties: Set<Set<String>> = []
        for (computer, connections) in allConnections {
            guard computer.hasPrefix("t") else { continue }
            for combo in connections.combinations(ofCount: 2) {
                if allConnections[combo[0]]!.contains(combo[1]) {
                    lanParties.insert([computer, combo[0], combo[1]])
                }
            }
        }
        return lanParties.count
    }

    func part2(allConnections graph: [String: Set<String>]) async throws -> String {
        let set = bronKerbosch(graph: graph, r: [], p: Set(graph.keys), x: [])
        return set.sorted().joined(separator: ",")
    }

    func bronKerbosch(graph: [String: Set<String>], r: Set<String>, p: Set<String>, x: Set<String>) -> Set<String> {
        if p.isEmpty && x.isEmpty {
            return r
        }

        var best: Set<String> = []
        var p = p
        var x = x
        let u = findPivot(graph: graph, vertices: p.union(x))
        for v in p where !graph[u]!.contains(v) {
            let neighbors = graph[v]!
            let set = bronKerbosch(
                graph: graph,
                r: r.union([v]),
                p: p.intersection(neighbors),
                x: x.intersection(neighbors)
            )
            if set.count > best.count {
                best = set
            }
            p.remove(v)
            x.insert(v)
        }

        return best
    }

    func findPivot(graph: [String: Set<String>], vertices: Set<String>) -> String {
        vertices.max { graph[$0]!.count < graph[$1]!.count }!
    }

    func parseInput(input: String) -> [String: Set<String>] {
        var connections: [String: Set<String>] = [:]
        for line in input.lines {
            let components = line.components(separatedBy: "-")
            connections[components[0], default: []].insert(components[1])
            connections[components[1], default: []].insert(components[0])
        }
        return connections
    }
}
