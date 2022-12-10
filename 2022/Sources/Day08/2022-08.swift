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
        var numVisible = 0
        for (tree, coordinate) in graph {
            for direction in Direction.cardinalDirections {
                var isVisible = true
                graph.walk(direction, from: coordinate) { other, _, stop in
                    if other.height >= tree.height {
                        isVisible = false
                        stop = true
                    }
                }

                if isVisible {
                    numVisible += 1
                    break
                }
            }
        }

        return numVisible
    }

    public override func part2() throws -> Int {
        var highestScore = 0
        for (tree, coordinate) in graph {
            var currentScore = 1
            for direction in Direction.cardinalDirections {
                var numVisible = 0
                graph.walk(direction, from: coordinate) { other, _, stop in
                    numVisible += 1
                    if other.height >= tree.height {
                        stop = true
                    }
                }

                currentScore *= numVisible
            }

            highestScore = (currentScore > highestScore) ? currentScore : highestScore
        }

        return highestScore
    }
}
