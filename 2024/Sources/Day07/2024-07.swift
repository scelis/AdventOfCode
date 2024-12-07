import AdventKit
import Foundation

struct Day07: Day {

    // MARK: Types

    struct Equation {
        var testValue: Int
        var numbers: [Int]
    }

    enum Operator {
        case add
        case multiply
        case concatenate

        func evaluate(a: Int, b: Int) -> Int {
            switch self {
            case .add:
                return a + b
            case .multiply:
                return a * b
            case .concatenate:
                let numberOfDigitsInB = Int(log10(Double(b))) + 1
                return a * Int(pow(10, Double(numberOfDigitsInB))) + b
            }
        }
    }

    // MARK: Solving

    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        parseEquations()
            .filter { isPossiblyTrue(equation: $0, operators: [.add, .multiply]) }
            .map { $0.testValue }
            .reduce(0, +)
    }

    func part2() async throws -> Int {
        parseEquations()
            .filter { isPossiblyTrue(equation: $0, operators: [.add, .multiply, .concatenate]) }
            .map { $0.testValue }
            .reduce(0, +)
    }

    func isPossiblyTrue(equation: Equation, operators: [Operator]) -> Bool {
        func isPossiblyTrueRecursive(numbers: [Int], runningTotals: Set<Int>) -> Bool {
            guard !runningTotals.isEmpty && !numbers.isEmpty else {
                return runningTotals.contains(equation.testValue)
            }

            var nextRunningTotals: Set<Int> = []
            for total in runningTotals {
                for op in operators {
                    let value = op.evaluate(a: total, b: numbers[0])
                    if value <= equation.testValue {
                        nextRunningTotals.insert(value)
                    }
                }
            }

            return isPossiblyTrueRecursive(
                numbers: numbers.removing(at: 0),
                runningTotals: nextRunningTotals
            )
        }

        return isPossiblyTrueRecursive(
            numbers: equation.numbers.removing(at: 0),
            runningTotals: [equation.numbers[0]]
        )
    }

    // MARK: Parsing

    func parseEquations() -> [Equation] {
        inputLines().map {
            let components = $0.components(separatedBy: ":")
            return Equation(
                testValue: Int(components[0])!,
                numbers: components[1].components(separatedBy: .whitespaces).compactMap(Int.init)
            )
        }
    }
}
