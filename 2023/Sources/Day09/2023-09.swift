import AdventKit2
import Foundation

struct Day09: Day {
    func run() async throws -> (Int, Int) {
        let integers = inputLines().map({ $0.components(separatedBy: " ").compactMap(Int.init) })
        async let p1 = part1(integers: integers)
        async let p2 = part2(integers: integers)
        return try await (p1, p2)
    }

    func part1(integers: [[Int]]) async throws -> Int {
        integers
            .map { calculateNext(in: $0) }
            .reduce(0, +)
    }

    func part2(integers: [[Int]]) async throws -> Int {
        integers
            .map { calculatePrevious(in: $0) }
            .reduce(0, +)
    }

    func calculateNext(in sequence: [Int]) -> Int {
        if sequence.allSatisfy({ $0 == 0 }) {
            return 0
        }

        let differences = sequence.adjacentPairs().map({ $1 - $0 })
        return sequence.last! + calculateNext(in: differences)
    }

    func calculatePrevious(in sequence: [Int]) -> Int {
        if sequence.allSatisfy({ $0 == 0 }) {
            return 0
        }

        let differences = sequence.adjacentPairs().map({ $1 - $0 })
        return sequence.first! - calculatePrevious(in: differences)
    }
}
