import AdventKit
import Foundation

struct Day08: Day {
    struct Tree: GridGraphNode {
        var height: Int
        var coordinate: Coordinate2D
    }

    func generateGraph() -> GridGraph<Tree> {
        let integers = inputLines().map { line -> [Int] in
            return line.map { character -> Int in
                return Int(String(character))!
            }
        }

        return try! GridGraph(data: integers, createNode: Tree.init)
    }

    func run() async throws -> (Int, Int) {
        let graph = generateGraph()
        async let p1 = part1(graph: graph)
        async let p2 = part2(graph: graph)
        return try await (p1, p2)
    }

    func part1(graph: GridGraph<Tree>) async throws -> Int {
        try graph.reduce(0) { partialResult, treeCoordinate -> Int in
            let (tree, coordinate) = treeCoordinate

            let isVisible = try Direction.cardinalDirections.first { direction in
                var isVisible = true
                try graph.walk(direction, from: coordinate) { other, stop in
                    if other.height >= tree.height {
                        isVisible = false
                        stop = true
                    }
                }
                return isVisible
            } != nil

            return isVisible ? partialResult + 1 : partialResult
        }
    }

    func part2(graph: GridGraph<Tree>) async throws -> Int {
        try graph.reduce(0) { partialResult, treeCoordinate -> Int in
            let (tree, coordinate) = treeCoordinate

            let score = try Direction.cardinalDirections.map { direction -> Int in
                var numVisible = 0
                try graph.walk(direction, from: coordinate) { other, stop in
                    numVisible += 1
                    if other.height >= tree.height {
                        stop = true
                    }
                }
                return numVisible
            }
            .reduce(1, *)

            return score > partialResult ? score : partialResult
        }
    }
}
