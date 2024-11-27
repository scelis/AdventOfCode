import AdventKit
import Foundation

struct Day03: Day {
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

    func allCoordinates(vectors: [SimpleVector]) -> [Coordinate2D: Int] {
        var coordinates = [Coordinate2D: Int]()

        var steps = 0
        var current = Coordinate2D(x: 0, y: 0)
        for vector in vectors {
            for _ in 0..<vector.length {
                let next = Coordinate2D(x: current.x + vector.direction.dx, y: current.y + vector.direction.dy)
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

        let origin = Coordinate2D(x: 0, y: 0)
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

    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        return findIntersection(input: input())
    }

    func part2() async throws -> Int {
        return findIntersection(input: input(), closest: false)
    }
}
