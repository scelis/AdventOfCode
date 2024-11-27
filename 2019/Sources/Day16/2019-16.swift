import AdventKit
import Foundation

struct Day16: Day {
    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        var numbers: [Int] = input().map( { Int(String($0))! })
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

        return Int(numbers[0..<8].map({ "\($0)" }).joined())!
    }

    func part2() async throws -> Int {
        let numbers: [Int] = input().map( { Int(String($0))! })
        var input = Array<[Int]>.init(repeating: numbers, count: 10000).flatMap({ $0 })
        let startIndex = Int(Array(input.prefix(7)).map({ "\($0)" }).joined())!

        for _ in 0..<100 {
            for i in (startIndex..<input.count - 2).reversed() {
                input[i] = (input[i] + input[i + 1]) % 10
            }
        }

        return Int(input[startIndex..<(startIndex + 8)].map({ "\($0)" }).joined())!
    }
}
