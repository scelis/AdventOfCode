import AdventKit
import Algorithms
import Foundation

public class Day01: Day<Int, Int> {
    public override func part1() throws -> Int {
        input
            .components(separatedBy: .newlines)
            .map { Int($0)! }
            .adjacentPairs()
            .reduce(0) { partialResult, pair in
                return (pair.1 > pair.0) ? partialResult + 1 : partialResult
            }
    }

    public override func part2() throws -> Int {
        input
            .components(separatedBy: .newlines)
            .map { Int($0)! }
            .windows(ofCount: 3)
            .map { $0.reduce(0, +) }
            .adjacentPairs()
            .reduce(0) { partialResult, pair in
                return (pair.1 > pair.0) ? partialResult + 1 : partialResult
            }
    }
}
