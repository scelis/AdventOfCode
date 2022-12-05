import AdventKit
import Foundation

class Day03: Day {
    struct SimpleVector {
        var direction: Direction
        var length: Int

        init(rawValue: String) {
            var rawValue = rawValue
            self.direction = Direction(rawValue: String(rawValue.removeFirst()))!
            self.length = Int(rawValue)!
        }
    }

    func parseVectors(line: String) -> [SimpleVector] {
        return line.components(separatedBy: ",").compactMap({ SimpleVector(rawValue: $0) })
    }

    func allCoordinates(vectors: [SimpleVector]) -> [Coordinate2D<Int>: Int] {
        var coordinates = [Coordinate2D<Int>: Int]()

        var steps = 0
        var current = Coordinate2D<Int>(x: 0, y: 0)
        for vector in vectors {
            for _ in 0..<vector.length {
                let next = Coordinate2D<Int>(x: current.x + vector.direction.dx, y: current.y + vector.direction.dy)
                steps += 1
                coordinates[next] = coordinates[next] ?? steps
                current = next
            }
        }

        return coordinates
    }

    func findIntersection(input: String, closest: Bool = true) -> Int {
        var vectors: [[SimpleVector]] = []
        input.enumerateLines { line in
            vectors.append(parseVectors(line: line))
        }

        let origin = Coordinate2D<Int>(x: 0, y: 0)
        let vA = vectors[0]
        let vB = vectors[1]
        let coordinatesA = allCoordinates(vectors: vA)
        let coordinatesB = allCoordinates(vectors: vB)

        var intersections = Set(coordinatesA.keys).intersection(coordinatesB.keys)
        intersections.remove(origin)

        return intersections.reduce(Int.max) { result, coordinate -> Int in
            if closest {
                return min(result, coordinate.manhattanDistance(from: origin))
            } else {
                return min(result, coordinatesA[coordinate]! + coordinatesB[coordinate]!)
            }
        }
    }


    override func part1() -> Any {
        return findIntersection(input: inputString).description
    }

    override func part2() -> Any {
        return findIntersection(input: inputString, closest: false).description
    }
}
