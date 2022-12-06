import Foundation

extension Int {
    public var digits: [Int] {
        var digits: [Int] = []
        var number = self

        while number != 0 {
            let ones = number % 10
            digits.insert(ones, at: 0)
            number = number / 10
        }

        return digits
    }

    public var primeFactors: [Int] {
        var factors: [Int] = []

        var number = self
        outer: while number > 1 {
            for i in 2...number {
                if number % i == 0 {
                    factors.append(i)
                    number = number / i
                    continue outer
                }
            }
        }

        return factors
    }
}

extension Array where Element == Int {
    public var leastCommonMultiple: Int {
        var allFactors: Set<Int> = []
        var factorCounts: [[Int: Int]] = []

        for number in self {
            var counts: [Int: Int] = [:]
            for factor in number.primeFactors {
                allFactors.insert(factor)
                counts[factor] = (counts[factor] ?? 0) + 1
            }
            factorCounts.append(counts)
        }

        var lcm = 1
        for factor in allFactors {
            var maxCount = 0
            for dict in factorCounts {
                maxCount = Swift.max(maxCount, dict[factor] ?? 0)
            }
            lcm = lcm * pow(factor, maxCount)
        }

        return lcm
    }
}

public func pow(_ a: Int, _ b: Int) -> Int {
    return Int(pow(Double(a), Double(b)))
}
