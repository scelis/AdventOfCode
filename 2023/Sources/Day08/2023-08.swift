import AdventKit
import Foundation

public class Day08: Day<Int, Int> {
    struct Node {
        var id: String
        var left: String
        var right: String
    }

    struct Visit: Equatable, Hashable {
        var id: String
        var step: Int
    }

    public override func part1() throws -> Int {
        return numberOfSteps(from: "AAA", to: "ZZZ")!
    }

    public override func part2() throws -> Int {
        let startingIDs: [String] = nodes.keys.filter { $0.hasSuffix("A") }
        let endingIDs: [String] = nodes.keys.filter { $0.hasSuffix("Z") }
        let distances: [[Int]] = startingIDs.map { start in
            endingIDs.compactMap { end in
                numberOfSteps(from: start, to: end)
            }
        }
        return distances
            .map { $0.min()! }
            .leastCommonMultiple
    }

    func numberOfSteps(from start: String, to end: String) -> Int? {
        var steps = 0
        var current = start
        var visits: Set<Visit> = []
        while true {
            let node = nodes[current]!
            let direction = directions[steps % directions.count]
            current = direction == "L" ? node.left : node.right
            steps += 1

            if current == end {
                return steps
            }

            let visit = Visit(id: current, step: steps % directions.count)
            if visits.contains(visit) {
                return nil
            } else {
                visits.insert(visit)
            }
        }
    }

    // MARK: - Parsing

    let nodeRegex = #/^([A-Z]+) = \(([A-Z]+), ([A-Z]+)\)$/#

    lazy var nodes: [String: Node] = {
        inputLines.dropFirst(2)
            .reduce(into: [:]) { partialResult, line in
                let match = line.wholeMatch(of: nodeRegex)!
                partialResult[String(match.1)] = Node(
                    id: String(match.1),
                    left: String(match.2),
                    right: String(match.3)
                )
            }
    }()

    lazy var directions: [Character] = Array(inputLines[0])
}
