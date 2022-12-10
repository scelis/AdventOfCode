import Foundation

public protocol GraphNode: Equatable, Identifiable {}

public class Graph<Node: GraphNode> {
    public enum Error: Swift.Error {
        case nodeNotFound
    }

    private struct Connection: Hashable {
        var origin: Node.ID
        var destination: Node.ID
    }

    private var nodes: [Node.ID: Node] = [:]
    private var connections: [Node.ID: Set<Node.ID>] = [:]
    private var connectionCosts: [Connection: Int] = [:]

    public init() {
    }

    public func add(node: Node) {
        nodes[node.id] = node
    }

    public func addConnection(
        from: Node.ID,
        to: Node.ID,
        cost: Int = 1,
        bidirectional: Bool = true
    ) throws {
        guard
            let _ = nodes[from],
            let _ = nodes[to]
            else { throw Error.nodeNotFound }

        connections[from, default: []].insert(to)
        connectionCosts[Connection(origin: from, destination: to)] = cost

        if bidirectional {
            connections[to, default: []].insert(from)
            connectionCosts[Connection(origin: to, destination: from)] = cost
        }
    }

    public func node(withID id: Node.ID) -> Node? {
        return nodes[id]
    }

    public func nodesAccessible(from: Node.ID) throws -> Set<Node.ID> {
        guard let connections = connections[from] else { throw Error.nodeNotFound }
        return connections
    }
}
