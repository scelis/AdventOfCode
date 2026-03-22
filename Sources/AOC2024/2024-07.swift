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
            case .add: a + b
            case .multiply: a * b
            case .concatenate: a * Int(pow(10, Double(b.numberOfDigits))) + b
            }
        }
    }

    // MARK: Solving

    func run(input: String) async throws -> (Int, Int) {
        let equations = parseEquations(input: input)
        async let p1 = part1(equations: equations)
        async let p2 = part2(equations: equations)
        return try await (p1, p2)
    }

    func part1(equations: [Equation]) async throws -> Int {
        equations
            .filter { isPossiblyTrue(equation: $0, operators: [.add, .multiply]) }
            .map { $0.testValue }
            .reduce(0, +)
    }

    func part2(equations: [Equation]) async throws -> Int {
        equations
            .filter { isPossiblyTrue(equation: $0, operators: [.add, .multiply, .concatenate]) }
            .map { $0.testValue }
            .reduce(0, +)
    }

    func isPossiblyTrue(equation: Equation, operators: [Operator]) -> Bool {
        var runningTotals: Set<Int> = [equation.numbers[0]]

        for i in 1..<equation.numbers.count {
            var nextTotals: Set<Int> = []
            for total in runningTotals {
                for op in operators {
                    let value = op.evaluate(a: total, b: equation.numbers[i])
                    if value <= equation.testValue {
                        nextTotals.insert(value)
                    }
                }
            }

            if nextTotals.isEmpty {
                return false
            } else {
                runningTotals = nextTotals
            }
        }

        return runningTotals.contains(equation.testValue)
    }

    // MARK: Parsing

    func parseEquations(input: String) -> [Equation] {
        input.lines.map {
            let components = $0.components(separatedBy: ":")
            return Equation(
                testValue: Int(components[0])!,
                numbers: components[1].components(separatedBy: .whitespaces).compactMap(Int.init)
            )
        }
    }
}
