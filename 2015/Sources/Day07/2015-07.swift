import AdventKit
import Foundation

struct Day07: Day {
    enum Instruction {
        case provide(input: String, destination: String)
        case and(left: String, right: String, destination: String)
        case or(left: String, right: String, destination: String)
        case lshift(input: String, amount: UInt16, destination: String)
        case rshift(input: String, amount: UInt16, destination: String)
        case not(input: String, destination: String)

        init(rawInput: String) {
            let components = rawInput.components(separatedBy: .whitespaces)
            if components.count == 3, components[1] == "->" {
                self = .provide(input: components[0], destination: components[2])
            } else if components.count == 5, components[1] == "AND" {
                self = .and(left: components[0], right: components[2], destination: components[4])
            } else if components.count == 5, components[1] == "OR" {
                self = .or(left: components[0], right: components[2], destination: components[4])
            } else if components.count == 5, components[1] == "LSHIFT" {
                self = .lshift(input: components[0], amount: UInt16(components[2])!, destination: components[4])
            } else if components.count == 5, components[1] == "RSHIFT" {
                self = .rshift(input: components[0], amount: UInt16(components[2])!, destination: components[4])
            } else if components.count == 4, components[0] == "NOT" {
                self = .not(input: components[1], destination: components[3])
            } else {
                fatalError("Unexpected instruction: \(rawInput)")
            }
        }

        var destination: String {
            switch self {
            case .provide(_, let destination): destination
            case .and(_, _, let destination): destination
            case .or(_, _, let destination): destination
            case .lshift(_, _, let destination): destination
            case .rshift(_, _, let destination): destination
            case .not(_, let destination): destination
            }
        }
    }

    func run() async throws -> (UInt16, UInt16) {
        let instructions = inputLines().map(Instruction.init)
        let part1 = run(instructions: instructions)

        var modifiedInstructions = instructions
        modifiedInstructions.remove(at: instructions.firstIndex(where: { $0.destination == "b" })!)
        modifiedInstructions.insert(.provide(input: "\(part1)", destination: "b"), at: 0)
        let part2 = run(instructions: modifiedInstructions)

        return (part1, part2)
    }

    func run(instructions: [Instruction]) -> UInt16 {
        var values: [String: UInt16] = [:]
        var instructions = instructions

        func value(for input: String) -> UInt16? {
            values[input] ?? UInt16(input)
        }

        while values["a"] == nil {
            let instruction = instructions.removeFirst()

            switch instruction {
            case .provide(let input, let destination):
                if let input = value(for: input) {
                    values[destination] = input
                } else {
                    instructions.append(instruction)
                }
            case .and(let left, let right, let destination):
                if let left = value(for: left), let right = value(for: right) {
                    values[destination] = left & right
                } else {
                    instructions.append(instruction)
                }
            case .or(let left, let right, let destination):
                if let left = value(for: left), let right = value(for: right) {
                    values[destination] = left | right
                } else {
                    instructions.append(instruction)
                }
            case .lshift(let input, let amount, let destination):
                if let input = value(for: input) {
                    values[destination] = input << amount
                } else {
                    instructions.append(instruction)
                }
            case .rshift(let input, let amount, let destination):
                if let input = value(for: input) {
                    values[destination] = input >> amount
                } else {
                    instructions.append(instruction)
                }
            case .not(let input, let destination):
                if let input = value(for: input) {
                    values[destination] = ~input
                } else {
                    instructions.append(instruction)
                }
            }
        }

        return values["a"]!
    }
}
