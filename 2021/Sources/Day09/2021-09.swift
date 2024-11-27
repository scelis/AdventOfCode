import AdventKit2
import Foundation

struct Day09: Day {
    func run() async throws -> (Int, Int) {
        let integers = input().components(separatedBy: .newlines).map { $0.map { Int(String($0))! } }
        let lowPoints = calculateLowPoints(integers: integers)

        async let p1 = part1(lowPoints: lowPoints)
        async let p2 = part2(integers: integers, lowPoints: lowPoints)
        return try await (p1, p2)
    }

    func part1(lowPoints: [Coordinate2D: Int]) async throws -> Int {
        lowPoints.values.reduce(0) { $0 + $1 + 1 }
    }

    func part2(integers: [[Int]], lowPoints: [Coordinate2D: Int]) async throws -> Int {
        var basinSizes: [Coordinate2D: Int] = [:]
        var coordinatesToBasins: [Coordinate2D: Coordinate2D] = [:]
        var coordinatesToCheck: Set<Coordinate2D> = []

        let peekAroundCoordinate: (Coordinate2D) -> Void = { coordinate in
            coordinate
                .neighboringCoordinates()
                .forEach { nearby in
                    if
                        coordinatesToBasins[nearby] == nil,
                        let height = integers[safe: nearby.y]?[safe: nearby.x],
                        height != 9
                    {
                        coordinatesToCheck.insert(nearby)
                    }
                }
        }

        for coordinate in lowPoints.keys {
            basinSizes[coordinate] = 1
            coordinatesToBasins[coordinate] = coordinate
            peekAroundCoordinate(coordinate)
        }

        while let coordinate = coordinatesToCheck.popFirst() {
            guard
                coordinatesToBasins[coordinate] == nil,
                let height = integers[safe: coordinate.y]?[safe: coordinate.x]
                else { continue }

            for neighbor in coordinate.neighboringCoordinates() {
                if
                    let neighborHeight = integers[safe: neighbor.y]?[safe: neighbor.x],
                    neighborHeight <= height,
                    let basinCoordinate = coordinatesToBasins[neighbor]
                {
                    basinSizes[basinCoordinate, default: 0] += 1
                    coordinatesToBasins[coordinate] = basinCoordinate
                    peekAroundCoordinate(coordinate)
                    break
                }
            }
        }

        return basinSizes.values.sorted(by: >).prefix(3).reduce(1, *)
    }

    func calculateLowPoints(integers: [[Int]]) -> [Coordinate2D: Int] {
        var lowPoints: [Coordinate2D: Int] = [:]
        for i in 0..<integers.count {
            for j in 0..<integers[i].count {
                let coordinate = Coordinate2D(x: j, y: i)
                let number = integers[coordinate.y][coordinate.x]
                var isLowPoint = true

                for neighbor in coordinate.neighboringCoordinates() {
                    if
                        let other = integers[safe: neighbor.y]?[safe: neighbor.x],
                        other <= number
                    {
                        isLowPoint = false
                        break
                    }
                }

                if isLowPoint {
                    lowPoints[coordinate] = number
                }
            }
        }

        return lowPoints
    }
}
