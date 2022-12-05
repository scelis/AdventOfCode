import AdventKit
import Algorithms
import Foundation

public class Day09: Day<Int, Int> {
    var part1Result: Int?

    lazy var inputIntegers: [Int] = {
        return inputLines.map { Int($0)! }
    }()

    public override func part1() throws -> Int {
        part1Result = inputIntegers
            .enumerated()
            .first { (index, element) -> Bool in
                return
                    index > 25 &&
                    inputIntegers[index - 25...index - 1].combinations(ofCount: 2).first { arr in
                        return arr[0] != arr[1] && arr[0] + arr[1] == element
                    } == nil
            }!.element

        return part1Result!
    }

    public override func part2() throws -> Int {
        var i = 0
        while i < inputIntegers.count {
            var j = i
            var sum = inputIntegers[i]

            while sum < part1Result! {
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
}
