import AdventKit2
import Foundation

struct Day08: Day {
    struct Node {
        var id: String
        var left: String
        var right: String
    }

    func run() async throws -> (Int, Int) {
        let directions = parseDirections()
        let nodes = parseNodes()
        async let p1 = part1(directions: directions, nodes: nodes)
        async let p2 = part2(directions: directions, nodes: nodes)
        return try await (p1, p2)
    }

    func part1(directions: [Character], nodes: [String: Node]) async throws -> Int {
        return numberOfSteps(from: "AAA", to: { $0 == "ZZZ" }, directions: directions, nodes: nodes)
    }

    func part2(directions: [Character], nodes: [String: Node]) async throws -> Int {
        // Apparently each starting node has a singular ending node that it can reach and the
        // number of steps from start to end is the same as looping from end back to end. That
        // makes this problem significantly easier.
        nodes.keys
            .filter { $0.hasSuffix("A") }
            .map { numberOfSteps(from: $0, to: { $0.hasSuffix("Z") }, directions: directions, nodes: nodes) }
            .leastCommonMultiple
    }

    func numberOfSteps(
        from start: String,
        to condition: (String) -> Bool,
        directions: [Character],
        nodes: [String: Node]
    ) -> Int {
        var steps = 0
        var current = start
        while true {
            let node = nodes[current]!
            let direction = directions[steps % directions.count]
            current = direction == "L" ? node.left : node.right
            steps += 1

            if condition(current) {
                return steps
            }
        }
    }

    // MARK: - Parsing

    func parseDirections() -> [Character] {
        Array(inputLines()[0])
    }

    func parseNodes() -> [String: Node] {
        let nodeRegex = #/^([A-Z]+) = \(([A-Z]+), ([A-Z]+)\)$/#

        return inputLines()
            .dropFirst(2)
            .reduce(into: [:]) { partialResult, line in
                let match = line.wholeMatch(of: nodeRegex)!
                partialResult[String(match.1)] = Node(
                    id: String(match.1),
                    left: String(match.2),
                    right: String(match.3)
                )
            }
    }
}
