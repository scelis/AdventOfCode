import AdventKit
import Foundation

public struct Day01: Day {
    let digits: [String: Int] = [
        "0": 0,
        "1": 1,
        "2": 2,
        "3": 3,
        "4": 4,
        "5": 5,
        "6": 6,
        "7": 7,
        "8": 8,
        "9": 9
    ]

    let words: [String: Int] = [
        "zero": 0,
        "one": 1,
        "two": 2,
        "three": 3,
        "four": 4,
        "five": 5,
        "six": 6,
        "seven": 7,
        "eight": 8,
        "nine": 9
    ]

    func findCalibrationComponent(in string: String, using map: [String: Int], fromBeginning: Bool) -> Int? {
        var s: String.SubSequence = .init(string)
        while !s.isEmpty {
            for (key, value) in map {
                if (fromBeginning && s.hasPrefix(key)) || (!fromBeginning && s.hasSuffix(key)) {
                    return value
                }
            }
            s = fromBeginning ? s.dropFirst() : s.dropLast()
        }
        return nil
    }

    func calibrationValue(for string: String, using map: [String: Int]) -> Int? {
        guard
            let left = findCalibrationComponent(in: string, using: map, fromBeginning: true),
            let right = findCalibrationComponent(in: string, using: map, fromBeginning: false)
        else { return nil }

        return left * 10 + right
    }

    public func part1() async throws -> Int {
        return inputLines()
            .compactMap { calibrationValue(for: $0, using: digits) }
            .reduce(0, +)
    }

    public func part2() async throws -> Int {
        let map: [String: Int] = digits.merging(words, uniquingKeysWith: { a, _ in a })
        return inputLines()
            .compactMap { calibrationValue(for: $0, using: map) }
            .reduce(0, +)
    }
}
