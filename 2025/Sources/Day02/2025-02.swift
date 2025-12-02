import AdventKit
import Foundation

struct Day02: Day {
    func run() async throws -> (Int, Int) {
        let ranges = parseInput()
        async let p1 = part1(ranges: ranges)
        async let p2 = part2(ranges: ranges)
        return try await (p1, p2)
    }

    func part1(ranges: [ClosedRange<Int>]) async throws -> Int {
        ranges
            .map { sumOfInvalidIDs(from: $0, isPartOne: true) }
            .reduce(0, +)
    }

    func part2(ranges: [ClosedRange<Int>]) async throws -> Int {
        ranges
            .map { sumOfInvalidIDs(from: $0, isPartOne: false) }
            .reduce(0, +)
    }

    func sumOfInvalidIDs(from range: ClosedRange<Int>, isPartOne: Bool) -> Int {
        range.reduce(0) { result, number in
            let isValid = isValid(id: number, isPartOne: isPartOne)
            return isValid ? result : result + number
        }
    }

    func isValid(id: Int, isPartOne: Bool) -> Bool {
        guard id > 10 else { return true }

        let numberOfDigits = id.numberOfDigits
        if isPartOne {
            if
                numberOfDigits % 2 == 0,
                isRepeatedSequence(number: id, sequenceLength: numberOfDigits / 2)
            {
                return false
            }
        } else {
            for sequenceLength in 1...(numberOfDigits / 2) {
                if
                    numberOfDigits % sequenceLength == 0,
                    isRepeatedSequence(number: id, sequenceLength: sequenceLength)
                {
                    return false
                }
            }
        }

        return true
    }

    func isRepeatedSequence(number: Int, sequenceLength: Int) -> Bool {
        let n = pow(10, sequenceLength)
        let sequence = number % n
        var remainder = number / n
        while remainder != 0 {
            let next = remainder % n
            if next != sequence {
                return false
            }
            remainder /= n
        }
        return true
    }

    func parseInput() -> [ClosedRange<Int>] {
        input()
            .components(separatedBy: ",")
            .map {
                let pair = $0.components(separatedBy: "-")
                return Int(pair[0])!...Int(pair[1])!
            }
    }
}
