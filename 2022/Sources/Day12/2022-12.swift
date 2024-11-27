import AdventKit2
import Foundation

struct Day12: Day {
    struct Node: GridGraphNode {
        var height: Int
        var coordinate: Coordinate2D
    }

    func parseInput() throws -> (GridGraph<Node>, Coordinate2D, Coordinate2D) {
        let characters = input().components(separatedBy: .newlines).map { Array($0) }
        var start: Coordinate2D?
        var destination: Coordinate2D?

        var graph = try GridGraph(data: characters, addConnections: false) { character, coordinate in
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
                    let otherNode = graph.node(withID: otherCoordinate),
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

    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        let (graph, start, destination) = try parseInput()
        return try graph.findPath(from: start, to: destination).count - 1
    }

    func part2() async throws -> Int {
        var (graph, _, destination) = try parseInput()
        try graph.reverse()
        return try graph.findPath(
            from: destination,
            toEndCondition: { graph.node(withID: $0)!.height == 0 }
        ).count - 1
    }
}
