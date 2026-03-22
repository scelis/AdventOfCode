import AdventKit
import Algorithms
import Foundation

struct Day09: Day {
    func run(input: String) async throws -> (Int, Int) {
        let integers = input.integers
        let part1 = try await part1(integers: integers)
        let part2 = try await part2(integers: integers, part1Result: part1)
        return (part1, part2)
    }

    func part1(integers: [Int]) async throws -> Int {
        return integers
            .enumerated()
            .first { (index, element) -> Bool in
                return
                    index > 25 &&
                    integers[index - 25...index - 1].combinations(ofCount: 2).first { arr in
                        return arr[0] != arr[1] && arr[0] + arr[1] == element
                    } == nil
            }!.element
    }

    func part2(integers: [Int], part1Result: Int) async throws -> Int {
        var i = 0
        while i < integers.count {
            var j = i
            var sum = integers[i]

            while sum < part1Result {
                j += 1
                sum += integers[j]
            }

            if sum == part1Result {
                let range = integers[i...j]
                let result = range.min()! + range.max()!
                return result
            } else {
                i += 1
            }
        }
        fatalError()
    }
}
