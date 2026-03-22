import AdventKit
import Foundation

struct Day08: Day {
    func run(input: String) async throws -> (Int, Int) {
        let lines = input.lines
        async let p1 = part1(lines: lines)
        async let p2 = part2(lines: lines)
        return try await (p1, p2)
    }

    func part1(lines: [String]) async throws -> Int {
        lines
            .map { $0.components(separatedBy: " | ")[1] }
            .map { str -> Int in
                str.components(separatedBy: " ")
                    .filter { [2, 3, 4, 7].contains($0.count) }
                    .count
            }
            .reduce(0, +)
    }

    func part2(lines: [String]) async throws -> Int {
        let countToDigit: [Int: Int] = [
            2: 1,
            3: 7,
            4: 4,
            7: 8
        ]

        var sum = 0
        for line in lines {
            let components = line.components(separatedBy: " | ")
            let signalPatterns = components[0].components(separatedBy: " ").map(Set.init)
            let outputStrings = components[1].components(separatedBy: " ").map(Set.init)
            var charactersToDigit: [Set<Character>: Int] = [:]
            var digitToCharacters: [Int: Set<Character>] = [:]

            for item in signalPatterns {
                if let digit = countToDigit[item.count] {
                    charactersToDigit[item] = digit
                    digitToCharacters[digit] = item
                }
            }

            for item in signalPatterns {
                if let value: Int = {
                    if
                        item.count == 6,
                        item.intersection(digitToCharacters[4]!).count == 3,
                        item.intersection(digitToCharacters[7]!).count == 3
                    {
                        return 0
                    } else if
                        item.count == 5,
                        item.intersection(digitToCharacters[4]!).count == 2
                    {
                        return 2
                    } else if
                        item.count == 5,
                        item.intersection(digitToCharacters[1]!).count == 2
                    {
                        return 3
                    } else if
                        item.count == 5,
                        item.intersection(digitToCharacters[4]!).count == 3
                    {
                        return 5
                    } else if
                        item.count == 6,
                        item.intersection(digitToCharacters[1]!).count == 1
                    {
                        return 6
                    } else if
                        item.count == 6,
                        item.intersection(digitToCharacters[4]!).count == 4
                    {
                        return 9
                    } else {
                        return nil
                    }
                }() {
                    charactersToDigit[item] = value
                    digitToCharacters[value] = item
                }
            }

            let outputDigits = outputStrings.map { charactersToDigit[$0]! }
            sum += Int(digits: outputDigits)
        }

        return sum
    }
}
