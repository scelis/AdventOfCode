import AdventKit
import Foundation

struct Day15: Day {

    // MARK: - Structures

    struct Node {
        enum NodeType: Int {
            case wall = 0
            case floor = 1
            case oxygenSystem = 2
        }

        var coordinate: Coordinate2D
        var type: NodeType
        var distance: Int
        var path: [Direction]

        var reversePath: [Direction] {
            return path.map { $0.turnAround() }.reversed()
        }
    }

    class Explorer {
        var computer: IntcodeComputer
        var coordinates: [Coordinate2D: Node] = [:]
        var unexplored: [Node] = []
        var currentNode: Node
        var oxygenSystem: Node?
        var home = Coordinate2D(x: 0, y: 0)

        init(input: String) {
            computer = IntcodeComputer(input: input)
            currentNode = Node(coordinate: Coordinate2D(x:0, y:0), type: .floor, distance: 0, path: [])
            coordinates[currentNode.coordinate] = currentNode
            unexplored.append(currentNode)
        }

        /// This currently always travels all the way home and then all the way to the destination node.
        /// This could be optimized to only travel back home as far as necessary given the current location
        /// and destination paths.
        func travel(to node: Node) {
            guard currentNode.coordinate != node.coordinate else { return }

            // Travel home
            if currentNode.coordinate != home {
                for direction in currentNode.reversePath {
                    computer.run(input: [direction.command])
                }
                currentNode = coordinates[home]!
                computer.outputBuffer = []
            }

            // Travel to node
            for direction in node.path {
                computer.run(input: [direction.command])
            }
            currentNode = node
            computer.outputBuffer = []
        }

        func explore(node: Node) {
            travel(to: node)

            for direction in Direction.cardinalDirections {
                let nextCoordinate = node.coordinate.step(inDirection: direction)
                if coordinates[nextCoordinate] == nil {
                    var newNode = node
                    newNode.coordinate = nextCoordinate
                    newNode.distance += 1
                    newNode.path.append(direction)
                    computer.run(input: [direction.command])
                    newNode.type = Node.NodeType(rawValue: computer.readInt()!)!
                    coordinates[nextCoordinate] = newNode

                    switch newNode.type {
                    case .floor:
                        unexplored.append(newNode)
                        computer.run(input: [direction.turnAround().command])
                        computer.outputBuffer = []
                    case .oxygenSystem:
                        oxygenSystem = newNode
                        unexplored.append(newNode)
                        computer.run(input: [direction.turnAround().command])
                        computer.outputBuffer = []
                    case .wall:
                        break
                    }
                }
            }
        }
    }

    func run() async throws -> (Int, Int) {
        let explorer = Explorer(input: input())

        while explorer.oxygenSystem == nil {
            let unexploredNode = explorer.unexplored.removeFirst()
            explorer.explore(node: unexploredNode)
        }

        let part1 = explorer.oxygenSystem!.distance

        explorer.travel(to: explorer.oxygenSystem!)
        explorer.home = explorer.oxygenSystem!.coordinate
        explorer.oxygenSystem?.distance = 0
        explorer.oxygenSystem?.path = []
        explorer.coordinates = [explorer.oxygenSystem!.coordinate: explorer.oxygenSystem!]
        explorer.unexplored = [explorer.oxygenSystem!]
        while !explorer.unexplored.isEmpty {
            let unexploredNode = explorer.unexplored.removeFirst()
            explorer.explore(node: unexploredNode)
        }

        let part2 = explorer.coordinates.values.reduce(0) { (result, node) -> Int in
            return max(result, (node.type == .floor) ? node.distance : 0)
        }

        return (part1, part2)
    }
}

private extension Direction {
    var command: Int {
        switch self {
        case .north: return 1
        case .south: return 2
        case .west: return 3
        case .east: return 4
        default: return -1
        }
    }
}
