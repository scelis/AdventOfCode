import AdventKit
import Foundation

public class Day03: Day<Int, Int> {
    private struct Node: GridGraphNode {
        var character: Character
        var coordinate: Coordinate2D

        var digit: Int? {
            Int(String(character))
        }
    }

    private struct SchematicNumber: Equatable, Hashable {
        var number: Int
        var location: [Coordinate2D]
    }

    private lazy var schematic: [[Character]] = inputLines.map { Array($0) }
    private lazy var graph = try! GridGraph(data: schematic, diagonalsAllowed: true, createNode: Node.init)

    public override func part1() throws -> Int {
        return try schematicNumbers
            .filter { try isPartNumber($0) }
            .map { $0.number }
            .reduce(0, +)
    }

    public override func part2() throws -> Int {
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

    private func isPartNumber(_ number: SchematicNumber) throws -> Bool {
        for location in number.location {
            for (coordinate, _) in try graph.connections(from: location) {
                let neighbor = try graph.node(withID: coordinate)
                if neighbor.character != "." && neighbor.digit == nil {
                    return true
                }
            }
        }
        return false
    }

    // MARK: - Parsing

    private lazy var schematicNumbers: [SchematicNumber] = {
        var numbers: [SchematicNumber] = []
        var currentLocation = Coordinate2D.zero

        for y in 0..<graph.height {
            var currentNumberDigits: [Int] = []
            var currentNumberCoordinates: [Coordinate2D] = []

            var addCurrentNumber: () -> Void = {
                let number = currentNumberDigits.reduce(0) { $0 * 10 + $1 }
                numbers.append(SchematicNumber(number: number, location: currentNumberCoordinates))
                currentNumberDigits.removeAll()
                currentNumberCoordinates.removeAll()
            }

            try! graph.walk(.right, from: Coordinate2D(x: 0, y: y), includeStartingNode: true) { node, _ in
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
    }()

    private lazy var coordinateToNumberMap: [Coordinate2D: SchematicNumber] = {
        var map: [Coordinate2D: SchematicNumber] = [:]
        for number in schematicNumbers {
            for coordinate in number.location {
                map[coordinate] = number
            }
        }
        return map
    }()
}
