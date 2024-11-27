import AdventKit
import Foundation

struct Day03: Day {

    // MARK: - Structures

    struct Node: GridGraphNode {
        var character: Character
        var coordinate: Coordinate2D

        var digit: Int? {
            Int(String(character))
        }
    }

    struct SchematicNumber: Equatable, Hashable {
        var number: Int
        var location: [Coordinate2D]
    }

    // MARK: - Solving

    func run() async throws -> (Int, Int) {
        let schematic = inputLines().map { Array($0) }
        let graph = try createGraph(schematic: schematic)
        let schematicNumbers = try findSchematicNumbers(graph: graph)
        let part1 = try sumOfPartNumbers(schematicNumbers: schematicNumbers, graph: graph)
        let part2 = try sumOfGearRatios(schematicNumbers: schematicNumbers, graph: graph)
        return (part1, part2)
    }

    func sumOfPartNumbers(schematicNumbers: [SchematicNumber], graph: GridGraph<Node>) throws -> Int {
        try schematicNumbers
            .filter { try isPartNumber($0, graph: graph) }
            .map { $0.number }
            .reduce(0, +)
    }

    func sumOfGearRatios(schematicNumbers: [SchematicNumber], graph: GridGraph<Node>) throws -> Int {
        let coordinateToNumberMap: [Coordinate2D: SchematicNumber] = {
            var map: [Coordinate2D: SchematicNumber] = [:]
            for number in schematicNumbers {
                for coordinate in number.location {
                    map[coordinate] = number
                }
            }
            return map
        }()

        var total = 0
        for (node, coordinate) in graph where node.character == "*" {
            var partNumbers: Set<SchematicNumber> = []
            for (neighborCoordinate, _) in try graph.connections(from: coordinate) {
                if let number = coordinateToNumberMap[neighborCoordinate] {
                    partNumbers.insert(number)
                }
            }
            if partNumbers.count == 2 {
                total = total + partNumbers.map({ $0.number }).reduce(1, *)
            }
        }

        return total
    }

    func isPartNumber(_ number: SchematicNumber, graph: GridGraph<Node>) throws -> Bool {
        for location in number.location {
            for (coordinate, _) in try graph.connections(from: location) {
                let neighbor = graph.node(withID: coordinate)!
                if neighbor.character != "." && neighbor.digit == nil {
                    return true
                }
            }
        }
        return false
    }

    func findSchematicNumbers(graph: GridGraph<Node>) throws -> [SchematicNumber] {
        var numbers: [SchematicNumber] = []
        for y in 0..<graph.height {
            var currentNumberDigits: [Int] = []
            var currentNumberCoordinates: [Coordinate2D] = []

            let addCurrentNumber: () -> Void = {
                let number = currentNumberDigits.reduce(0) { $0 * 10 + $1 }
                numbers.append(SchematicNumber(number: number, location: currentNumberCoordinates))
                currentNumberDigits.removeAll()
                currentNumberCoordinates.removeAll()
            }

            try graph.walk(.right, from: Coordinate2D(x: 0, y: y), includeStartingNode: true) { node, _ in
                if let currentDigit = node.digit {
                    currentNumberDigits.append(currentDigit)
                    currentNumberCoordinates.append(node.coordinate)
                } else if !currentNumberDigits.isEmpty {
                    addCurrentNumber()
                }
            }

            if !currentNumberDigits.isEmpty {
                addCurrentNumber()
            }
        }

        return numbers
    }

    // MARK: - Parsing

    func createGraph(schematic: [[Character]]) throws -> GridGraph<Node> {
        try GridGraph(data: schematic, diagonalsAllowed: true, createNode: Node.init)
    }
}
