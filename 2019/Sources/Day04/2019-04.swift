import AdventKit
import Foundation

public struct Day04: Day {
    func isValidPassword(number: Int, strict: Bool) -> Bool {
        var previous: Int?
        var foundDouble = false
        var foundStrictDouble = false

        let digits = number.digits
        for (index, digit) in digits.enumerated() {
            var isIncreasing = false

            if let previous = previous {
                if previous > digit {
                    return false
                } else if previous == digit {
                    foundDouble = true
                } else {
                    isIncreasing = true
                }
            } else {
                isIncreasing = true
            }

            if
                strict,
                isIncreasing,
                foundStrictDouble == false,
                index < digits.count - 1,
                digits[index + 1] == digit,
                (index >= digits.count - 2 || digits[index + 2] != digit)
            {
                foundStrictDouble = true
            }

            previous = digit
        }

        return strict ? foundStrictDouble : foundDouble
    }

    func numberOfPasswords(in range: ClosedRange<Int>, strict: Bool) -> Int {
        var numberOfPasswords = 0

        for i in range {
            if isValidPassword(number: i, strict: strict) {
                numberOfPasswords += 1
            }
        }

        return numberOfPasswords
    }

    var range: ClosedRange<Int> {
        let integers = inputIntegers()
        return integers[0]...integers[1]
    }

    public func part1() async throws -> Int {
        return numberOfPasswords(in: range, strict: false)
    }

    public func part2() async throws -> Int {
        return numberOfPasswords(in: range, strict: true)
    }
}
