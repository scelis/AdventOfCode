import AdventKit
import Foundation

struct Day08: Day {
    enum Instruction {
        case nop(Int)
        case acc(Int)
        case jmp(Int)

        init(line: String) {
            let parts = line.components(separatedBy: .whitespacesAndNewlines)
            let value = Int(parts[1])!
            switch parts[0] {
            case "nop": self = .nop(value)
            case "acc": self = .acc(value)
            case "jmp": self = .jmp(value)
            default: fatalError()
            }
        }
    }

    var instructions: [Instruction] {
        inputLines().map { Instruction(line: $0) }
    }

    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        return execute(instructions: instructions).accumulatorValue
    }

    func execute(instructions: [Instruction]) -> (completed: Bool, accumulatorValue: Int) {
        var i = 0
        var accumulator = 0
        var executed: Set<Int> = []

        while !executed.contains(i) && i < instructions.count {
            executed.insert(i)

            switch instructions[i] {
            case .nop:
                i += 1
            case .acc(let value):
                accumulator += value
                i += 1
            case .jmp(let value):
                i += value
            }
        }

        return (i == instructions.count, accumulator)
    }

    func part2() async throws -> Int {
        var i = 0
        while true {
            var modified = instructions

            var didModify = false
            while !didModify {
                switch instructions[i] {
                case .nop(let value):
                    modified[i] = .jmp(value)
                    didModify = true
                case .jmp(let value):
                    modified[i] = .nop(value)
                    didModify = true
                case .acc:
                    break
                }
                i += 1
            }

            let result = execute(instructions: modified)
            if result.completed {
                return result.accumulatorValue
            }
        }
    }
}
