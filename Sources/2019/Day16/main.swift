import AdventKit
import Foundation

class Day16: Day {
    override func part1() -> Any {
        var numbers: [Int] = inputString.map( { Int(String($0))! })
        let pattern = [0, 1, 0, -1]

        for _ in 0..<100 {
            for digitIndex in 0..<numbers.count {
                var sum = 0
                for patternIndex in digitIndex..<numbers.count {
                    let actualPatternIndex = ((patternIndex + 1) / (digitIndex + 1)) % pattern.count
                    let patternValue = pattern[actualPatternIndex]
                    let digitValue = numbers[patternIndex]
                    sum += digitValue * patternValue
                }
                numbers[digitIndex] = abs(sum) % 10
            }
        }

        return Int(numbers[0..<8].map({ "\($0)" }).joined())!.description
    }

    override func part2() -> Any {
        let numbers: [Int] = inputString.map( { Int(String($0))! })
        var input = Array<[Int]>.init(repeating: numbers, count: 10000).flatMap({ $0 })
        let startIndex = Int(Array(input.prefix(7)).map({ "\($0)" }).joined())!

        for _ in 0..<100 {
            for i in (startIndex..<input.count - 2).reversed() {
                input[i] = (input[i] + input[i + 1]) % 10
            }
        }

        return Int(input[startIndex..<(startIndex + 8)].map({ "\($0)" }).joined())!.description
    }
}

Day16().run()
