import AdventKit
import Foundation

public struct Day08: Day {
    struct Node {
        var id: String
        var left: String
        var right: String
    }

    let nodes: [String: Node]
    let directions: [Character]

    public func part1() async throws -> Int {
        return numberOfSteps(from: "AAA", to: { $0 == "ZZZ" })
    }

    public func part2() async throws -> Int {
        // Apparently each starting node has a singular ending node that it can reach and the
        // number of steps from start to end is the same as looping from end back to end. That
        // makes this problem significantly easier.
        nodes.keys
            .filter { $0.hasSuffix("A") }
            .map { numberOfSteps(from: $0, to: { $0.hasSuffix("Z") }) }
            .leastCommonMultiple
    }

    func numberOfSteps(from start: String, to condition: (String) -> Bool) -> Int {
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

    private static let nodeRegex = #/^([A-Z]+) = \(([A-Z]+), ([A-Z]+)\)$/#

    init() {
        let lines = Self.inputLines()
        self.directions = Array(lines[0])
        self.nodes = Self.inputLines().dropFirst(2)
            .reduce(into: [:]) { partialResult, line in
                let match = line.wholeMatch(of: Self.nodeRegex)!
                partialResult[String(match.1)] = Node(
                    id: String(match.1),
                    left: String(match.2),
                    right: String(match.3)
                )
            }
    }
}
