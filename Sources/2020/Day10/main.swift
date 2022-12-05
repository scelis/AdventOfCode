import AdventKit
import Algorithms
import Foundation

class Day10: Day {
    override func part1() -> Any {
        var differences: [Int: Int] = [:]
        let integers = inputIntegers.sorted()
        integers
            .enumerated()
            .forEach { (index, element) in
                let previous = (index > 0) ? integers[index - 1] : 0
                let diff = element - previous
                differences[diff] = (differences[diff] ?? 0) + 1
            }

        return "\(differences[1]! * (differences[3]! + 1))"
    }

    override func part2() -> Any {
        let integers = inputIntegers.sorted()
        var memoize: [Int: Int] = [0: 1]
        for int in integers {
            memoize[int] = (1...3).map({ memoize[int - $0] ?? 0 }).reduce(0, +)
        }

        return "\(memoize[integers.last!]!)"
    }
}

Day10().run()
