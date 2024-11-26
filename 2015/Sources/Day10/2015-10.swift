import AdventKit2
import Foundation

struct Day10: Day {

    func run() async throws -> (Int, Int) {
        var digits = Int(input())!.digits

        for _ in 0..<40 {
            digits = nextInSequence(input: digits)
        }
        let part1 = digits.count

        for _ in 0..<10 {
            digits = nextInSequence(input: digits)
        }
        let part2 = digits.count

        return (part1, part2)
    }

    func nextInSequence(input: [Int]) -> [Int] {
        var next: [Int] = []

        var start = 0
        while start < input.count {
            var end = start + 1
            while end < input.count && input[end] == input[start] {
                end += 1
            }

            for digit in (end - start).digits {
                next.append(digit)
            }
            next.append(input[start])
            start = end
        }

        return next
    }
}
