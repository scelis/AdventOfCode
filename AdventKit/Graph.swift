import Foundation

public class Graph<NodeID: Hashable, NodeValue: Equatable> {

    public enum Error: Swift.Error {
        case nodeNotFound
    }

    /// A representation of a node within the graph.
    private struct Node {

        /// The node identifier
        var id: NodeID

        /// The value associated with the node
        var value: NodeValue

        /// A dictionary of nodes connected to this node and the cost to travel there
        var connections: [NodeID: Int] = [:]
    }

    private var nodes: [NodeID: Node] = [:]

    public init() {
    }

    public func addNode(id: NodeID, value: NodeValue) {
        nodes[id] = Node(id: id, value: value)
    }

    public func addConnection(
        from: NodeID,
        to: NodeID,
        cost: Int = 1,
        bidirectional: Bool = true
    ) throws {
        guard
            var fromNode = nodes[from],
            var toNode = nodes[to]
            else { throw Error.nodeNotFound }

        fromNode.connections[to] = cost
        nodes[fromNode.id] = fromNode

        if bidirectional {
            toNode.connections[from] = cost
            nodes[toNode.id] = toNode
        }
    }

    public func value(of: NodeID) -> NodeValue? {
        return nodes[of]?.value
    }

    public func nodesAccessible(from: NodeID) -> Set<NodeID> {
        guard let node = nodes[from] else { return [] }
        return Set(node.connections.keys)
    }
}
