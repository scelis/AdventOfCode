import Foundation

public struct Graph<Node: GraphNode>: Graphable, Sendable {
    public var nodes: [Node.ID: Node] = [:]
    public var connections: [Node.ID: [Node.ID: Int]] = [:]

    public init() {
    }
}
