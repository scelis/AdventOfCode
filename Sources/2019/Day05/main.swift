import AdventKit
import Foundation
import IntcodeComputer

class Day05: Day {
    override func part1() -> Any {
        let computer = IntcodeComputer(input: inputString)
        computer.run(input: [1])
        return "\(computer.outputBuffer.last!)"
    }

    override func part2() -> Any {
        let computer = IntcodeComputer(input: inputString)
        computer.run(input: [5])
        return "\(computer.outputBuffer.last!)"
    }
}

Day05().run()
