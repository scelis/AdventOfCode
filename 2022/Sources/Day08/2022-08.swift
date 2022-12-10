import AdventKit
import Algorithms
import Foundation

public class Day08: Day<Int, Int> {
    private struct Tree: GridGraphNode {
        var height: Int
    }

    private lazy var graph: GridGraph<Tree> = {
        let nodes = inputLines.map { line -> [Tree] in
            return line.map { character -> Tree in
                return Tree(height: Int(String(character))!)
            }
        }
        return try! GridGraph(data: nodes)
    }()

    public override func part1() throws -> Int {
        graph.reduce(0) { partialResult, treeCoordinate -> Int in
            Direction.cardinalDirections.first { direction in
                var isVisible = true
                graph.walk(direction, from: treeCoordinate.1) { other, _, stop in
                    if other.height >= treeCoordinate.0.height {
                        isVisible = false
                        stop = true
                    }
                }
                return isVisible
            } != nil ? partialResult + 1 : partialResult
        }
    }

    public override func part2() throws -> Int {
        graph.reduce(0) { partialResult, treeCoordinate -> Int in
            let score = Direction.cardinalDirections.map { direction -> Int in
                var numVisible = 0
                graph.walk(direction, from: treeCoordinate.1) { other, _, stop in
                    numVisible += 1
                    if other.height >= treeCoordinate.0.height {
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
