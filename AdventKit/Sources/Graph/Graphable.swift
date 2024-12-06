import Foundation

public protocol GraphNode: Equatable, Identifiable, Sendable where ID: Hashable, ID: Sendable {}

enum GraphError: Error {
    case nodeNotFound
    case pathNotFound
}

public protocol Graphable {
    associatedtype Node: GraphNode
    var nodes: [Node.ID: Node] { get set }
    var connections: [Node.ID: [Node.ID: Int]] { get set }
}

extension Graphable {

    // MARK: Nodes & Connections

    public mutating func add(node: Node) {
        nodes[node.id] = node
    }

    public func node(withID id: Node.ID) -> Node? {
        nodes[id]
    }

    public mutating func addConnection(
        from: Node.ID,
        to: Node.ID,
        cost: Int = 1,
        bidirectional: Bool
    ) throws {
        guard
            node(withID: from) != nil,
            node(withID: to) != nil
        else {
            throw GraphError.nodeNotFound
        }

        var connectionsFromNode = self.connections[from, default: [:]]
        connectionsFromNode[to] = cost
        self.connections[from] = connectionsFromNode

        if bidirectional {
            var connectionsToNode = self.connections[to, default: [:]]
            connectionsToNode[from] = cost
            self.connections[to] = connectionsToNode
        }
    }

    public func connections(from: Node.ID) throws -> [Node.ID: Int] {
        guard node(withID: from) != nil else {
            throw GraphError.nodeNotFound
        }

        return connections[from] ?? [:]
    }

    // MARK: Pathfinding

    public func findPath(
        from start: Node.ID,
        to end: Node.ID
    ) throws -> [Node.ID] {
        return try findPath(from: start, toEndCondition: { $0 == end })
    }

    /// Uses Dijkstra's algorithm to find the shortest path from the start to a node that satisfies the end condition.
    public func findPath(
        from start: Node.ID,
        toEndCondition: (Node.ID) throws -> Bool
    ) throws -> [Node.ID] {
        var map: [Node.ID: (Int, [Node.ID])] = [start: (0, [start])]
        var visited: Set<Node.ID> = []
        var bestSolution: (Int, [Node.ID])?

        var nodesToCheck = [start]
        while let originID = nodesToCheck.first {
            nodesToCheck.removeFirst()
            visited.insert(originID)

            var addedNodeToCheck = false
            for (destinationID, connectionCost) in connections[originID] ?? [:] {
                let (costToOrigin, pathToOrigin) = map[originID]!
                let totalCost = costToOrigin + connectionCost
                if map[destinationID] == nil || totalCost < map[destinationID]!.0 {
                    map[destinationID] = (totalCost, pathToOrigin + [destinationID])

                    if
                        try toEndCondition(destinationID),
                        (bestSolution == nil || totalCost < bestSolution!.0)
                    {
                        bestSolution = (totalCost, pathToOrigin + [destinationID])
                    }

                    if !visited.contains(destinationID) {
                        nodesToCheck.append(destinationID)
                        addedNodeToCheck = true
                    }
                }
            }

            if addedNodeToCheck {
                nodesToCheck.sort { a, b in
                    return map[a]!.0 < map[b]!.0
                }
            }

            if
                let bestSolution,
                let nextNodeID = nodesToCheck.first,
                let nextCost = map[nextNodeID]?.0,
                bestSolution.0 < nextCost
            {
                break
            }
        }

        if let bestSolution {
            return bestSolution.1
        } else {
            throw GraphError.pathNotFound
        }
    }

    /// Returns a map of all nodes reachable from the start and the cheapest cost to reach that node.
    public func explore(from start: Node.ID) throws -> [Node.ID: Int] {
        var map: [Node.ID: Int] = [start: 0]
        var visited: Set<Node.ID> = []
        var nodesToCheck = [start]
        while let originID = nodesToCheck.first {
            nodesToCheck.removeFirst()
            visited.insert(originID)

            var addedNodeToCheck = false
            for (destinationID, connectionCost) in connections[originID] ?? [:] {
                let costToOrigin = map[originID]!
                let totalCost = costToOrigin + connectionCost
                if map[destinationID] == nil || totalCost < map[destinationID]! {
                    map[destinationID] = totalCost

                    if !visited.contains(destinationID) {
                        nodesToCheck.append(destinationID)
                        addedNodeToCheck = true
                    }
                }
            }

            if addedNodeToCheck {
                nodesToCheck.sort { a, b in
                    return map[a]! < map[b]!
                }
            }
        }

        return map
    }

    // MARK: Derivitives

    /// Reverses the graph so that all nodes going from A -> B now go from B -> A. This is useful for calculating a path backwards
    /// from a destination.
    public mutating func reverse() throws {
        let oldConnections = connections
        connections.removeAll()
        for (origin, connectionCosts) in oldConnections {
            for (destination, cost) in connectionCosts {
                try addConnection(from: destination, to: origin, cost: cost, bidirectional: false)
            }
        }
    }
}
