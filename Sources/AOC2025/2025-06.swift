import AdventKit
import Foundation

struct Day06: Day {
    func run(input: String) async throws -> (Int, Int) {
        let lines = input.lines
        async let p1 = part1(lines: lines)
        async let p2 = part2(lines: lines)
        return try await (p1, p2)
    }

    func part1(lines: [String]) async throws -> Int {
        let sheet = lines.map { $0.split(separator: " ", omittingEmptySubsequences: true) }
        var total = 0

        for column in 0..<sheet[0].count {
            let numbers = sheet.dropLast().map { Int($0[column])! }
            let answer = switch sheet.last![column] {
            case "+": numbers.reduce(0, +)
            case "*": numbers.reduce(1, *)
            default: fatalError()
            }
            total += answer
        }

        return total
    }

    func part2(lines: [String]) async throws -> Int {
        let sheet = lines.map { Array($0) }
        var total = 0

        var group: [Int] = []
        var op: Character?
        for column in (0..<sheet[0].count).reversed() {
            var number: Int?
            for row in 0..<sheet.count {
                let c = sheet[row][column]
                if c.isNumber {
                    number = (number ?? 0) * 10 + c.wholeNumberValue!
                } else if c == "+" || c == "*" {
                    op = c
                }
            }

            if let number = number {
                group.append(number)
            }
            
            if number == nil || column == 0 {
                switch op {
                case "+": total += group.reduce(0, +)
                case "*": total += group.reduce(1, *)
                default: fatalError()
                }
                
                group = []
                op = nil
            }
        }

        return total
    }
}
