import AdventKit
import Foundation

public struct Day08: Day {
    private struct Tree: GridGraphNode {
        var height: Int
        var coordinate: Coordinate2D
    }

    private static var graph: GridGraph<Tree> = {
        let integers = inputLines().map { line -> [Int] in
            return line.map { character -> Int in
                return Int(String(character))!
            }
        }

        return try! GridGraph(data: integers, createNode: Tree.init)
    }()

    public func part1() async throws -> Int {
        try Self.graph.reduce(0) { partialResult, treeCoordinate -> Int in
            let (tree, coordinate) = treeCoordinate

            let isVisible = try Direction.cardinalDirections.first { direction in
                var isVisible = true
                try Self.graph.walk(direction, from: coordinate) { other, stop in
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

    public func part2() async throws -> Int {
        try Self.graph.reduce(0) { partialResult, treeCoordinate -> Int in
            let (tree, coordinate) = treeCoordinate

            let score = try Direction.cardinalDirections.map { direction -> Int in
                var numVisible = 0
                try Self.graph.walk(direction, from: coordinate) { other, stop in
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
