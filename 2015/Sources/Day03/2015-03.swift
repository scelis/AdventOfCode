import AdventKit
import Algorithms
import Foundation

struct Day03: Day {

    // MARK: - Solving

    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        var current = Coordinate2D.zero
        return directions.reduce(into: Set<Coordinate2D>([current])) { partialResult, direction in
            current = current.step(inDirection: direction)
            partialResult.insert(current)
        }.count
    }

    func part2() async throws -> Int {
        var locations = [Coordinate2D.zero, Coordinate2D.zero]
        return directions
            .chunks(ofCount: 2)
            .reduce(into: Set<Coordinate2D>([.zero])) { partialResult, chunk in
                for (index, direction) in chunk.enumerated() {
                    locations[index] = locations[index].step(inDirection: direction)
                    partialResult.insert(locations[index])
                }
            }
            .count
    }

    // MARK: - Parsing

    var directions: [Direction] {
        input().compactMap { character in
            switch character {
            case "^": return .north
            case "v": return .south
            case ">": return .east
            case "<": return .west
            default: return nil
            }
        }
    }
}
