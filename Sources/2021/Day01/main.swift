import AdventKit
import Algorithms
import Foundation

class Day01: Day {
    override func part1() -> String {
        inputIntegers.adjacentPairs()
            .reduce(0) { partialResult, pair in
                return (pair.1 > pair.0) ? partialResult + 1 : partialResult
            }
            .description
    }

    override func part2() -> String {
        inputIntegers.windows(ofCount: 3)
            .map { $0.reduce(0, +) }
            .adjacentPairs()
            .reduce(0) { partialResult, pair in
                return (pair.1 > pair.0) ? partialResult + 1 : partialResult
            }
            .description
    }
}

Day01().run()
