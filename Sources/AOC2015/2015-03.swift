import AdventKit
import Algorithms
import Foundation

struct Day03: Day {

    // MARK: - Solving

    func run(input: String) async throws -> (Int, Int) {
        let directions = parseDirections(input: input)
        async let p1 = part1(directions: directions)
        async let p2 = part2(directions: directions)
        return try await (p1, p2)
    }

    func part1(directions: [Direction]) async throws -> Int {
        var current = Coordinate2D.zero
        return directions.reduce(into: Set<Coordinate2D>([current])) { partialResult, direction in
            current = current.step(inDirection: direction)
            partialResult.insert(current)
        }.count
    }

    func part2(directions: [Direction]) async throws -> Int {
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

    func parseDirections(input: String) -> [Direction] {
        input.compactMap { character in
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
