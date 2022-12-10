import Foundation

public protocol GridGraphNode: Equatable {}

public class GridGraph<Node: GridGraphNode> {
    public enum Error: Swift.Error {
        case notRectangular
    }

    public let height: Int
    public let width: Int
    public let diagonalsAllowed: Bool

    /// Store the nodes in a dictionary so that we can at some point support graphs with unknown dimensions, negative
    /// coordinates, etc.
    fileprivate let nodes: [Coordinate2D: Node]

    public init(data: [[Node]], diagonalsAllowed: Bool = false) throws {
        self.height = data.count
        self.width = data.first?.count ?? 0
        self.diagonalsAllowed = diagonalsAllowed

        var nodes: [Coordinate2D: Node] = [:]
        for (rowIndex, row) in data.enumerated() {
            guard row.count == width else { throw Error.notRectangular }
            for (columnIndex, node) in row.enumerated() {
                nodes[Coordinate2D(x: columnIndex, y: rowIndex)] = node
            }
        }
        self.nodes = nodes
    }

    public var validDirections: Set<Direction> {
        if diagonalsAllowed {
            return Direction.cardinalAndIntercardinalDirections
        } else {
            return Direction.cardinalDirections
        }
    }

    public func node(at coordinate: Coordinate2D) -> Node? {
        return nodes[coordinate]
    }

    public func walk(
        _ direction: Direction,
        from coordinate: Coordinate2D,
        using block: (Node, Coordinate2D, inout Bool) -> Void)
    {
        var stop = false
        var coordinate = coordinate.step(inDirection: direction)
        while !stop, let node = node(at: coordinate) {
            block(node, coordinate, &stop)
            coordinate = coordinate.step(inDirection: direction)
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
