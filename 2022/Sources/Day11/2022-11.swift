import AdventKit
import Foundation
import Parsing

public class Day11: Day<Int, Int> {
    private enum Value {
        case int(Int)
        case old
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
        let valueParser = Parse {
            OneOf {
                Int.parser().map { Value.int($0) }
                "old".map { Value.old }
            }
        }

        let monkeyParser = Parse {
            "Monkey "; Int.parser(); ":\n"
            "  Starting items: "; Many { Int.parser() } separator: { ", " }; "\n"
            "  Operation: new = old "; Operation.parser(); " "; valueParser; "\n"
            "  Test: divisible by "; Int.parser(); "\n"
            "    If true: throw to monkey "; Int.parser(); "\n"
            "    If false: throw to monkey "; Int.parser()
        }

        let parser = Many(element: { monkeyParser }, separator: { "\n\n" })
        return try parser.parse(input).map(Monkey.init)
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

    public override func part1() throws -> Int {
        let monkeys = try parseMonkeys()
        return try solve(monkeys: monkeys, numRounds: 20, worryDecay: { $0 / 3 })
    }

    public override func part2() throws -> Int {
        let monkeys = try parseMonkeys()
        let leastCommonMultiple = monkeys.map { $0.divisibleByTest }.leastCommonMultiple
        return try solve(monkeys: monkeys, numRounds: 10000, worryDecay: { $0 % leastCommonMultiple })
    }
}
