import AdventKit2
import Algorithms
import Foundation

struct Day09: Day {

    func part1() async throws -> Int {
        let inputIntegers = inputIntegers()

        return inputIntegers
            .enumerated()
            .first { (index, element) -> Bool in
                return
                    index > 25 &&
                    inputIntegers[index - 25...index - 1].combinations(ofCount: 2).first { arr in
                        return arr[0] != arr[1] && arr[0] + arr[1] == element
                    } == nil
            }!.element
    }

    func part2(part1Result: Int) async throws -> Int {
        let inputIntegers = inputIntegers()

        var i = 0
        while i < inputIntegers.count {
            var j = i
            var sum = inputIntegers[i]

            while sum < part1Result {
                j += 1
                sum += inputIntegers[j]
            }

            if sum == part1Result {
                let range = inputIntegers[i...j]
                let result = range.min()! + range.max()!
                return result
            } else {
                i += 1
            }
        }
        fatalError()
    }

    func run() async throws -> (Int, Int) {
        let part1 = try await part1()
        let part2 = try await part2(part1Result: part1)
        return (part1, part2)
    }
}
