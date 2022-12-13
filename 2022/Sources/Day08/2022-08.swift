import AdventKit
import Foundation

public class Day08: Day<Int, Int> {
    private struct Tree: GridGraphNode {
        var height: Int
        var coordinate: Coordinate2D
    }

    private lazy var graph: GridGraph<Tree> = {
        let integers = inputLines.map { line -> [Int] in
            return line.map { character -> Int in
                return Int(String(character))!
            }
        }

        return try! GridGraph(data: integers, createNode: Tree.init)
    }()

    public override func part1() throws -> Int {
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

    public override func part2() throws -> Int {
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
