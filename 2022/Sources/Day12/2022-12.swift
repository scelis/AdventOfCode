import AdventKit
import Foundation

public class Day12: Day<Int, Int> {
    private struct Node: GridGraphNode {
        var height: Int
        var coordinate: Coordinate2D
    }

    private func parseInput() throws -> (GridGraph<Node>, Coordinate2D, Coordinate2D) {
        let characters = inputLines.map { Array($0) }
        var start: Coordinate2D?
        var destination: Coordinate2D?

        let graph = try GridGraph(data: characters, addConnections: false) { character, coordinate in
            var character = character
            if character == "S" {
                start = coordinate
                character = "a"
            } else if character == "E" {
                destination = coordinate
                character = "z"
            }
            return Node(
                height: Int(character.asciiValue! - Character("a").asciiValue!),
                coordinate: coordinate
            )
        }

        for (node, coordinate) in graph {
            for direction in graph.validDirections {
                let otherCoordinate = coordinate.step(inDirection: direction)
                if
                    let otherNode = try? graph.node(withID: otherCoordinate),
                    otherNode.height <= node.height + 1
                {
                    try graph.addConnection(
                        from: node.coordinate,
                        to: otherNode.coordinate,
                        bidirectional: false
                    )
                }
            }
        }

        return (graph, start!, destination!)
    }

    public override func part1() throws -> Int {
        let (graph, start, destination) = try parseInput()
        return try graph.findPath(
            from: start,
            toEndCondition: { $0 == destination }
        ).count - 1
    }

    public override func part2() throws -> Int {
        let (graph, _, destination) = try parseInput()
        try graph.reverse()
        return try graph.findPath(
            from: destination,
            toEndCondition: { try graph.node(withID: $0).height == 0 }
        ).count - 1
    }
}
