import AdventKit
import Algorithms
import Foundation

public struct Day01: Day {
    public func part1() async throws -> Int {
        inputIntegers()
            .adjacentPairs()
            .reduce(0) { partialResult, pair in
                return (pair.1 > pair.0) ? partialResult + 1 : partialResult
            }
    }

    public func part2() async throws -> Int {
        inputIntegers()
            .windows(ofCount: 3)
            .map { $0.reduce(0, +) }
            .adjacentPairs()
            .reduce(0) { partialResult, pair in
                return (pair.1 > pair.0) ? partialResult + 1 : partialResult
            }
    }
}
