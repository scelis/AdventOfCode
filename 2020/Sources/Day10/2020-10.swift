import AdventKit
import Algorithms
import Foundation

public class Day10: Day<Int, Int> {
    lazy var inputIntegers: [Int] = {
        return inputLines.map { Int($0)! }.sorted()
    }()

    public override func part1() throws -> Int {
        var differences: [Int: Int] = [:]
        inputIntegers
            .enumerated()
            .forEach { (index, element) in
                let previous = (index > 0) ? inputIntegers[index - 1] : 0
                let diff = element - previous
                differences[diff] = (differences[diff] ?? 0) + 1
            }

        return differences[1]! * (differences[3]! + 1)
    }

    public override func part2() throws -> Int {
        var memoize: [Int: Int] = [0: 1]
        for int in inputIntegers {
            memoize[int] = (1...3).map({ memoize[int - $0] ?? 0 }).reduce(0, +)
        }

        return memoize[inputIntegers.last!]!
    }
}
