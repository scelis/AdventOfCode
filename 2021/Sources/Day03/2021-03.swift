import AdventKit
import Algorithms
import Foundation

public struct Day03: Day {
    public func part1() async throws -> Int {
        let inputLines = input().components(separatedBy: .newlines)
        let length = inputLines[0].count
        var ones: [Int] = .init(repeating: 0, count: length)
        var total = 0

        inputLines.forEach { str in
            for (index, char) in str.enumerated() {
                if char == "1" {
                    ones[index] += 1
                }
            }

            total += 1
        }

        let gammaString = ones
            .map { $0 > total / 2 ? "1" : "0" }
            .joined()
        let epsilonString = gammaString
            .map { $0 == "1" ? "0" : "1" }
            .joined()
        let gamma = Int(gammaString, radix: 2)!
        let epsilon = Int(epsilonString, radix: 2)!
        return gamma * epsilon
    }

    enum Rating {
        case oxygenGenerator
        case co2Scrubber
    }

    func whittleDown(items: [String], rating: Rating) -> String {
        let length = items.first!.count
        var items = items

        for i in 0..<length {
            var zeroes: [String] = []
            var ones: [String] = []
            for item in items {
                if item[i] == "0" {
                    zeroes.append(item)
                } else {
                    ones.append(item)
                }
            }

            switch rating {
            case .oxygenGenerator:
                if ones.count > zeroes.count {
                    items = ones
                } else if zeroes.count > ones.count {
                    items = zeroes
                } else {
                    items = ones
                }
            case .co2Scrubber:
                if ones.count > zeroes.count {
                    items = zeroes
                } else if zeroes.count > ones.count {
                    items = ones
                } else {
                    items = zeroes
                }
            }

            if items.count == 1 {
                break
            }
        }

        return items[0]
    }

    public func part2() async throws -> Int {
        let inputLines = input().components(separatedBy: .newlines)
        let oxygen = Int(whittleDown(items: inputLines, rating: .oxygenGenerator), radix: 2)!
        let co2 = Int(whittleDown(items: inputLines, rating: .co2Scrubber), radix: 2)!
        return oxygen * co2
    }
}
