import AdventKit
import Foundation

public class Day10: Day<Int, Int> {
    enum Tile: Character {
        case ground = "."
        case northSouth = "|"
        case eastWest = "-"
        case northEast = "L"
        case northWest = "J"
        case southWest = "7"
        case southEast = "F"
        case start = "S"

        init?(directions: Set<Direction>) {
            switch directions {
            case Tile.northSouth.directions: self = .northSouth
            case Tile.eastWest.directions: self = .eastWest
            case Tile.northEast.directions: self = .northEast
            case Tile.northWest.directions: self = .northWest
            case Tile.southWest.directions: self = .southWest
            case Tile.southEast.directions: self = .southEast
            default: return nil
            }
        }



        var directions: Set<Direction> {
            switch self {
            case .ground, .start: return []
            case .northSouth: return [.north, .south]
            case .eastWest: return [.east, .west]
            case .northEast: return [.north, .east]
            case .northWest: return [.north, .west]
            case .southWest: return [.south, .west]
            case .southEast: return [.south, .east]
            }
        }
    }

    struct Node: GridGraphNode {
        var tile: Tile
        var coordinate: Coordinate2D
    }

    public override func part1() throws -> Int {
        let _ = try checkParseGraph()
        return loopCoordinates.count / 2
    }

    public override func part2() throws -> Int {
        let graph = try checkParseGraph()

        // Find top/left "F" tile in the loop.
        var currentCoordinate: Coordinate2D! = loopCoordinates.min { a, b in
            if a.y < b.y { return true }
            if a.y == b.y { return a.x < b.x }
            return false
        }

        // From here we walk east. The inside of the loop will always be to our right.
        var currentDirection = Direction.east

        // Walk the loop, looking for tiles to our right that are not part of the loop.
        var innerCoordinates: Set<Coordinate2D> = []
        var visited: Set<Coordinate2D> = []
        while !visited.contains(currentCoordinate) {
            visited.insert(currentCoordinate)
            currentCoordinate = currentCoordinate.step(inDirection: currentDirection)
            let currentNode = try graph.node(withID: currentCoordinate)
            let exitDirection = currentNode.tile.directions.first { $0 != currentDirection.turnAround() }!

            currentDirection = currentDirection.turnRight()
            while currentDirection != exitDirection {
                if
                    let neighbor = try? graph.node(withID: currentCoordinate.step(inDirection: currentDirection)),
                    !loopCoordinates.contains(neighbor.coordinate),
                    !innerCoordinates.contains(neighbor.coordinate)
                {
                    innerCoordinates.formUnion(try graph.explore(from: neighbor.coordinate).keys)
                }
                currentDirection = currentDirection.turnLeft()
            }
        }

        return innerCoordinates.count
    }

    // MARK: - Parsing

    var graph: GridGraph<Node>?
    var startingCoordinate = Coordinate2D.zero
    var loopCoordinates: Set<Coordinate2D> = []

    func checkParseGraph() throws -> Graph<Node> {
        if let graph {
            return graph
        }

        // Create graph
        let data: [[Tile]] = inputLines.map({ $0.compactMap({ Tile(rawValue: $0) }) })
        let graph = try GridGraph(data: data, addConnections: false, createNode: Node.init)
        self.graph = graph

        // Find starting coordinate
        for (node, coordinate) in graph {
            if node.tile == .start {
                startingCoordinate = coordinate
                loopCoordinates.insert(startingCoordinate)
                break
            }
        }

        // Replace start tile with correct tile.
        let directionsFromStart: Set<Direction> = Direction.cardinalDirections
            .reduce(into: []) { partialResult, direction in
                let neighborCoordinate = startingCoordinate.step(inDirection: direction)
                if
                    let node = try? graph.node(withID: neighborCoordinate),
                    node.tile.directions.contains(direction.turnAround())
                {
                    partialResult.insert(direction)
                }
            }
        assert(directionsFromStart.count == 2)
        graph.add(node: Node(tile: Tile(directions: directionsFromStart)!, coordinate: startingCoordinate))

        // Connect remaining pipes in loop
        var keepGoing = true
        var currentCoordinate = startingCoordinate
        while keepGoing {
            var foundNeightbor = false
            let node = try graph.node(withID: currentCoordinate)
            for direction in node.tile.directions {
                let neighborCoordinate = currentCoordinate.step(inDirection: direction)
                if !loopCoordinates.contains(neighborCoordinate) {
                    loopCoordinates.insert(neighborCoordinate)
                    try graph.addConnection(
                        from: currentCoordinate,
                        to: neighborCoordinate,
                        bidirectional: true
                    )
                    currentCoordinate = neighborCoordinate
                    foundNeightbor = true
                    break
                }
            }
            if !foundNeightbor {
                keepGoing = false
            }
        }

        // Connect all other locations that are not part of the loop
        for (_, coordinate) in graph where !loopCoordinates.contains(coordinate) {
            for direction in [Direction.east, Direction.south] {
                let neighborCoordinate = coordinate.step(inDirection: direction)
                if !loopCoordinates.contains(neighborCoordinate) {
                    try? graph.addConnection(
                        from: coordinate,
                        to: neighborCoordinate,
                        bidirectional: true
                    )
                }
            }
        }

        return graph
    }
}
