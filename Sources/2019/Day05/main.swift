import AdventKit
import Foundation
import IntcodeComputer

class Day05: Day {
    lazy var memory: [Int] = IntcodeComputer.parse(input: inputString)

    override func part1() -> String {
        let computer = IntcodeComputer(memory: memory)
        computer.run(input: [1])
        return "\(computer.outputBuffer.last!)"
    }

    override func part2() -> String {
        let computer = IntcodeComputer(memory: memory)
        computer.run(input: [5])
        return "\(computer.outputBuffer.last!)"
    }
}

Day05().run()
