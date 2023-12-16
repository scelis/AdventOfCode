import AdventKit
import Foundation

public struct Day11: Day {
    private enum Value {
        case int(Int)
        case old

        init?(rawValue: String) {
            if rawValue == "old" {
                self = .old
            } else if let integer = Int(rawValue) {
                self = .int(integer)
            } else {
                return nil
            }
        }
    }

    private enum Operation: String, CaseIterable {
        case add = "+"
        case multiply = "*"
    }

    private class Monkey {
        let id: Int
        let operation: Operation
        let value: Value
        let divisibleByTest: Int
        let divisibleTrueTarget: Int
        let divisibleFalseTarget: Int
        var items: [Int]
        var inspections = 0

        init(
            id: Int,
            items: [Int],
            operation: Operation,
            value: Value,
            divisibleByTest: Int,
            divisibleTrueTarget: Int,
            divisibleFalseTarget: Int
        ) {
            self.id = id
            self.items = items
            self.operation = operation
            self.value = value
            self.divisibleByTest = divisibleByTest
            self.divisibleTrueTarget = divisibleTrueTarget
            self.divisibleFalseTarget = divisibleFalseTarget
        }

        func throwFirst(worryDecay: (Int) -> Int) -> (item: Int, target: Int)? {
            guard var worry = items.first else { return nil }
            items.removeFirst()
            inspections += 1

            switch (operation, value) {
            case (.add, .int(let int)): worry += int
            case (.add, .old): worry += worry
            case (.multiply, .int(let int)): worry *= int
            case (.multiply, .old): worry *= worry
            }

            worry = worryDecay(worry)

            return (worry, (worry % divisibleByTest == 0) ? divisibleTrueTarget : divisibleFalseTarget)
        }
    }

    private func parseMonkeys() throws -> [Monkey] {
        var monkeys: [Monkey] = []

        try input().enumerateMatches(withPattern: "Monkey ([0-9]+):\n  Starting items: ([0-9, ]+)\n  Operation: new = old ([*+]) ([0-9]+|old)\n  Test: divisible by ([0-9]+)\n    If true: throw to monkey ([0-9]+)\n    If false: throw to monkey ([0-9]+)") { match in
            monkeys.append(
                Monkey(
                    id: Int(match[1])!,
                    items: match[2].components(separatedBy: ", ").map({ Int($0)! }),
                    operation: Operation(rawValue: match[3])!,
                    value: Value(rawValue: match[4])!,
                    divisibleByTest: Int(match[5])!,
                    divisibleTrueTarget: Int(match[6])!,
                    divisibleFalseTarget: Int(match[7])!
                )
            )
        }

        return monkeys
    }

    private func solve(monkeys: [Monkey], numRounds: Int, worryDecay: (Int) -> Int) throws -> Int {
        for _ in 0..<numRounds {
            for monkey in monkeys {
                while let (item, target) = monkey.throwFirst(worryDecay: worryDecay) {
                    monkeys[target].items.append(item)
                }
            }
        }

        return monkeys
            .map { $0.inspections }
            .sorted(by: >)
            .prefix(2)
            .reduce(1, *)
    }

    public func part1() async throws -> Int {
        let monkeys = try parseMonkeys()
        return try solve(monkeys: monkeys, numRounds: 20, worryDecay: { $0 / 3 })
    }

    public func part2() async throws -> Int {
        let monkeys = try parseMonkeys()
        let leastCommonMultiple = monkeys.map { $0.divisibleByTest }.leastCommonMultiple
        return try solve(monkeys: monkeys, numRounds: 10000, worryDecay: { $0 % leastCommonMultiple })
    }
}
