import Foundation

public protocol GridGraphNode: GraphNode where ID == Coordinate2D {
    var coordinate: Coordinate2D { get }
}

extension GridGraphNode {
    public var id: ID { coordinate }
}

public struct GridGraph<Node: GridGraphNode>: Graphable, Sendable {
    public enum Error: Swift.Error {
        case notRectangular
    }

    public var nodes: [Node.ID: Node] = [:]
    public var connections: [Node.ID: [Node.ID: Int]] = [:]
    public let origin: Coordinate2D
    public let height: Int
    public let width: Int
    public let diagonalsAllowed: Bool

    public init<T>(
        data: [[T]],
        origin: Coordinate2D = .zero,
        diagonalsAllowed: Bool = false,
        addConnections: Bool = true,
        createNode: (T, Coordinate2D) -> Node
    ) throws {
        self.origin = origin
        self.diagonalsAllowed = diagonalsAllowed
        self.height = data.count
        self.width = data.first?.count ?? 0

        for (rowIndex, row) in data.enumerated() {
            guard row.count == width else { throw Error.notRectangular }
            for (columnIndex, rawNode) in row.enumerated() {
                let coordinate = Coordinate2D(x: origin.x + columnIndex, y: origin.y + rowIndex)
                let node = createNode(rawNode, coordinate)
                add(node: node)
            }
        }

        if addConnections {
            for x in 0..<width {
                for y in 0..<height {
                    let current = Coordinate2D(x: x + origin.x, y: y + origin.y)
                    for direction in validDirections {
                        let neighbor = current.step(inDirection: direction)
                        try? addConnection(from: current, to: neighbor, bidirectional: false)
                    }
                }
            }
        }
    }

    public var validDirections: Set<Direction> {
        if diagonalsAllowed {
            return Direction.cardinalAndIntercardinalDirections
        } else {
            return Direction.cardinalDirections
        }
    }

    public func walk(
        _ direction: Direction,
        from coordinate: Coordinate2D,
        includeStartingNode: Bool = false,
        using block: (Node, inout Bool) -> Void
    ) throws {
        guard let startingNode = self.node(withID: coordinate) else {
            throw GraphError.nodeNotFound
        }

        var stop = false
        if includeStartingNode {
            block(startingNode, &stop)
        }

        var currentCoordinate = coordinate
        var nextCoordinate = coordinate.step(inDirection: direction)
        while
            !stop,
            let nextNode = self.node(withID: nextCoordinate),
            connections[currentCoordinate]?.keys.contains(nextCoordinate) == true
        {
            block(nextNode, &stop)
            currentCoordinate = nextCoordinate
            nextCoordinate = nextCoordinate.step(inDirection: direction)
        }
    }
}

extension GridGraph: Sequence {
    public func makeIterator() -> IndexingIterator<[(Node, Coordinate2D)]> {
        let items: [(key: Coordinate2D, value: Node)] = nodes.sorted { a, b in
            return (a.key.y < b.key.y) || (a.key.y == b.key.y && a.key.x < b.key.x)
        }

        let pairs: [(Node, Coordinate2D)] = items.map { item -> (Node, Coordinate2D) in
            return (item.value, item.key)
        }

        return pairs.makeIterator()
    }
}
