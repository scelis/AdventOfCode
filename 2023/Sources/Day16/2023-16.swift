import AdventKit
import Foundation

public struct Day16: Day {

    // MARK: - Structures

    enum Tile: Character {
        case empty = "."
        case leftUpMirror = "/"
        case rightDownMirror = "\\"
        case verticalSplitter = "|"
        case horizontalSplitter = "-"
    }

    struct Node: GridGraphNode {
        var tile: Tile
        var lightDirections: Set<Direction> = []
        var coordinate: Coordinate2D

        init(tile: Tile, coordinate: Coordinate2D) {
            self.tile = tile
            self.coordinate = coordinate
        }
    }

    // MARK: - Solving

    public func part1() async throws -> Int {
        let graph = try parseGraph()
        return numberOfTilesEnergized(origin: .zero, direction: .east, graph: graph)
    }

    public func part2() async throws -> Int {
        let graph = try parseGraph()
        var largest = 0
        for x in 0..<graph.width {
            let top = numberOfTilesEnergized(origin: Coordinate2D(x: x, y: 0), direction: .south, graph: graph)
            reset(graph: graph)
            let bottom = numberOfTilesEnergized(origin: Coordinate2D(x: x, y: graph.height - 1), direction: .north, graph: graph)
            reset(graph: graph)
            largest = max(top, bottom, largest)
        }
        for y in 0..<graph.height {
            let left = numberOfTilesEnergized(origin: Coordinate2D(x: 0, y: y), direction: .east, graph: graph)
            reset(graph: graph)
            let right = numberOfTilesEnergized(origin: Coordinate2D(x: graph.width - 0, y: y), direction: .west, graph: graph)
            reset(graph: graph)
            largest = max(left, right, largest)
        }
        return largest
    }

    func numberOfTilesEnergized(origin: Coordinate2D, direction: Direction, graph: GridGraph<Node>) -> Int {
        var queue: [(Coordinate2D, Direction)] = [(origin, direction)]

        while !queue.isEmpty {
            let (coordinate, direction) = queue.removeFirst()
            try? graph.walk(direction, from: coordinate, includeStartingNode: true) { node, stop in
                if node.lightDirections.contains(direction) {
                    stop = true
                } else {
                    var node = node
                    node.lightDirections.insert(direction)
                    graph.add(node: node)

                    switch node.tile {
                    case .empty:
                        break
                    case .leftUpMirror:
                        switch direction {
                        case .east: queue.append((node.coordinate.step(inDirection: .north), .north))
                        case .south: queue.append((node.coordinate.step(inDirection: .west), .west))
                        case .north: queue.append((node.coordinate.step(inDirection: .east), .east))
                        case .west: queue.append((node.coordinate.step(inDirection: .south), .south))
                        default: fatalError()
                        }
                        stop = true
                    case .rightDownMirror:
                        switch direction {
                        case .east: queue.append((node.coordinate.step(inDirection: .south), .south))
                        case .south: queue.append((node.coordinate.step(inDirection: .east), .east))
                        case .north: queue.append((node.coordinate.step(inDirection: .west), .west))
                        case .west: queue.append((node.coordinate.step(inDirection: .north), .north))
                        default: fatalError()
                        }
                        stop = true
                    case .horizontalSplitter:
                        if direction == .north || direction == .south {
                            queue.append((node.coordinate.step(inDirection: .west), .west))
                            queue.append((node.coordinate.step(inDirection: .east), .east))
                            stop = true
                        }
                    case .verticalSplitter:
                        if direction == .east || direction == .west {
                            queue.append((node.coordinate.step(inDirection: .north), .north))
                            queue.append((node.coordinate.step(inDirection: .south), .south))
                            stop = true
                        }
                    }
                }
            }
        }

        return graph.allNodes.filter({ !$0.lightDirections.isEmpty }).count
    }

    func reset(graph: GridGraph<Node>) {
        for node in graph.allNodes {
            var node = node
            node.lightDirections = []
            graph.add(node: node)
        }
    }

    // MARK: - Parsing

    func parseGraph() throws -> GridGraph<Node> {
        let data: [[Tile]] = inputLines().map({ $0.compactMap({ Tile(rawValue: $0) }) })
        return try GridGraph(data: data, createNode: Node.init)
    }
}
