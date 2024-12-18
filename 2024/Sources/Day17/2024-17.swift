import AdventKit
import Foundation

struct Day17: Day {
    struct Computer {
        var registers: [String: Int] = [:]
        var program: [Int] = []
        var output: [Int] = []
        var targetOutput: [Int]? = nil
        var outputString: String { output.map(String.init).joined(separator: ",") }

        mutating func run() {
            var instructionPointer = 0
            while instructionPointer < program.count {
                let instruction = program[instructionPointer]
                let operand = program[instructionPointer + 1]
                switch instruction {
                case 0: // adv
                    registers["A"] = registers["A"]! / pow(2, comboOperand(of: operand))
                case 1: // bxl
                    registers["B"] = registers["B"]! ^ operand
                case 2: // bst
                    registers["B"] = comboOperand(of: operand) % 8
                case 3: // jnz
                    if registers["A"] != 0 {
                        instructionPointer = operand - 2
                    }
                case 4: // bxc
                    registers["B"] = registers["B"]! ^ registers["C"]!
                case 5: // out
                    output.append(comboOperand(of: operand) % 8)
                case 6: // bdv
                    registers["B"] = registers["A"]! / pow(2, comboOperand(of: operand))
                case 7: // cdv
                    registers["C"] = registers["A"]! / pow(2, comboOperand(of: operand))
                default:
                    fatalError("Unknown instruction \(instruction)")
                }
                instructionPointer += 2
            }
        }

        func comboOperand(of operand: Int) -> Int {
            switch operand {
            case 0, 1, 2, 3: operand
            case 4: registers["A"]!
            case 5: registers["B"]!
            case 6: registers["C"]!
            default: fatalError()
            }
        }
    }

    func run() async throws -> (String, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> String {
        var computer = parseInput()
        computer.run()
        return computer.output.map(String.init).joined(separator: ",")
    }

    func part2() async throws -> Int {
        let computer = parseInput()
        let programCount = computer.program.count
        var range = pow(8, programCount - 1)..<pow(8, programCount)
        var similarity = 7
        while range.count > 1 {
            range = narrowRange(computer: computer, range: range, similarity: similarity)
            similarity += 1
        }
        return range.lowerBound
    }

    func narrowRange(computer: Computer, range: Range<Int>, similarity: Int) -> Range<Int> {
        var increment = (range.upperBound - range.lowerBound) / 100_000
        increment = (increment == 0) ? 1 : increment

        var lower: Int?
        var upper: Int?
        var a = range.lowerBound
        while a < range.upperBound {
            var computer = computer
            computer.registers["A"] = a
            computer.run()
            if computer.output.suffix(similarity) == computer.program.suffix(similarity) {
                if increment == 1, computer.output == computer.program {
                    return (a..<(a + 1))
                } else {
                    if lower == nil {
                        lower = a
                    }
                    upper = a
                }
            }
            a += increment
        }

        return (lower! - increment)..<(upper! + increment)
    }

    func parseInput() -> Computer {
        let registerRegex = #/Register ([A-Z]): (\d+)/#
        let programRegex = #/Program: ([0-9,]+)/#
        let sections = input().components(separatedBy: "\n\n")
        let registers: [String: Int] = sections[0]
            .components(separatedBy: .newlines)
            .reduce(into: [:]) { result, line in
                let match = line.firstMatch(of: registerRegex)!
                result[String(match.1)] = Int(String(match.2))!
            }
        let programMatch = sections[1].firstMatch(of: programRegex)!
        let program = String(programMatch.1).components(separatedBy: ",").compactMap(Int.init)
        return Computer(registers: registers, program: program)
    }
}
