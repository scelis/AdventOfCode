import AdventKit
import Algorithms
import Foundation

struct Day10: Day {
    func run(input: String) async throws -> (Int, Int) {
        let integers = input.lines.map { Int($0)! }.sorted()
        async let p1 = part1(integers: integers)
        async let p2 = part2(integers: integers)
        return try await (p1, p2)
    }

    func part1(integers: [Int]) async throws -> Int {
        var differences: [Int: Int] = [:]
        integers
            .enumerated()
            .forEach { (index, element) in
                let previous = (index > 0) ? integers[index - 1] : 0
                let diff = element - previous
                differences[diff] = (differences[diff] ?? 0) + 1
            }

        return differences[1]! * (differences[3]! + 1)
    }

    func part2(integers: [Int]) async throws -> Int {
        var memoize: [Int: Int] = [0: 1]
        for int in integers {
            memoize[int] = (1...3).map({ memoize[int - $0] ?? 0 }).reduce(0, +)
        }

        return memoize[integers.last!]!
    }
}
