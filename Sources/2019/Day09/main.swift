import AdventKit
import Foundation
import IntcodeComputer

class Day09: Day {
    lazy var memory: [Int] = IntcodeComputer.parse(input: inputString)

    override func part1() -> String {
        let computer = IntcodeComputer(memory: memory)
        computer.run(input: [1])
        return "\(computer.outputBuffer)"
    }

    override func part2() -> String {
        let computer = IntcodeComputer(memory: memory)
        computer.run(input: [2])
        return "\(computer.outputBuffer)"
    }
}

Day09().run()
