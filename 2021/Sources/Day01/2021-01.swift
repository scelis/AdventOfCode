import AdventKit
import Algorithms
import Foundation

struct Day01: Day {
    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        inputIntegers()
            .adjacentPairs()
            .reduce(0) { partialResult, pair in
                return (pair.1 > pair.0) ? partialResult + 1 : partialResult
            }
    }

    func part2() async throws -> Int {
        inputIntegers()
            .windows(ofCount: 3)
            .map { $0.reduce(0, +) }
            .adjacentPairs()
            .reduce(0) { partialResult, pair in
                return (pair.1 > pair.0) ? partialResult + 1 : partialResult
            }
    }
}
