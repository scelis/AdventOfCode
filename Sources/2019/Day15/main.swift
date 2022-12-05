import AdventKit
import Foundation
import IntcodeComputer

extension CardinalDirection {
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

class Day15: Day {
    struct Node {
        enum NodeType: Int {
            case wall = 0
            case floor = 1
            case oxygenSystem = 2
        }

        var coordinate: Coordinate2D<Int>
        var type: NodeType
        var distance: Int
        var path: [CardinalDirection]

        var reversePath: [CardinalDirection] {
            return path.map { $0.opposite }.reversed()
        }
    }

    lazy var computer = IntcodeComputer(input: inputString)
    var coordinates: [Coordinate2D<Int>: Node] = [:]
    var unexplored: [Node] = []
    var currentNode: Node
    var oxygenSystem: Node?
    var home = Coordinate2D(x: 0, y: 0)

    override init() {
        currentNode = Node(coordinate: Coordinate2D(x:0, y:0), type: .floor, distance: 0, path: [])
        coordinates[currentNode.coordinate] = currentNode
        unexplored.append(currentNode)
        super.init()
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

        for direction in CardinalDirection.mainDirections {
            let nextCoordinate = node.coordinate.step(inCardinalDirection: direction)
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
                    computer.run(input: [direction.opposite.command])
                    computer.outputBuffer = []
                case .oxygenSystem:
                    oxygenSystem = newNode
                    unexplored.append(newNode)
                    computer.run(input: [direction.opposite.command])
                    computer.outputBuffer = []
                case .wall:
                    break
                }
            }
        }
    }

    override func part1() -> Any {
        while oxygenSystem == nil {
            let unexploredNode = unexplored.removeFirst()
            explore(node: unexploredNode)
        }

        return oxygenSystem!.distance.description
    }

    override func part2() -> Any {
        travel(to: oxygenSystem!)
        home = oxygenSystem!.coordinate
        oxygenSystem?.distance = 0
        oxygenSystem?.path = []
        coordinates = [oxygenSystem!.coordinate: oxygenSystem!]
        unexplored = [oxygenSystem!]
        while !unexplored.isEmpty {
            let unexploredNode = unexplored.removeFirst()
            explore(node: unexploredNode)
        }

        return coordinates.values.reduce(0) { (result, node) -> Int in
            return max(result, (node.type == .floor) ? node.distance : 0)
        }.description
    }
}

Day15().run()
