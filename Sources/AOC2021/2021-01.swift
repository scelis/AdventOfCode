import AdventKit
import Algorithms
import Foundation

struct Day01: Day {
    func run(input: String) async throws -> (Int, Int) {
        let integers = input.integers
        async let p1 = part1(integers: integers)
        async let p2 = part2(integers: integers)
        return try await (p1, p2)
    }

    func part1(integers: [Int]) async throws -> Int {
        integers
            .adjacentPairs()
            .reduce(0) { partialResult, pair in
                return (pair.1 > pair.0) ? partialResult + 1 : partialResult
            }
    }

    func part2(integers: [Int]) async throws -> Int {
        integers
            .windows(ofCount: 3)
            .map { $0.reduce(0, +) }
            .adjacentPairs()
            .reduce(0) { partialResult, pair in
                return (pair.1 > pair.0) ? partialResult + 1 : partialResult
            }
    }
}
