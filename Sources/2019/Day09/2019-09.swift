import AdventKit
import Foundation
import IntcodeComputer

class Day09: Day {
    override func part1() -> Any {
        let computer = IntcodeComputer(input: inputString)
        computer.run(input: [1])
        return "\(computer.outputBuffer)"
    }

    override func part2() -> Any {
        let computer = IntcodeComputer(input: inputString)
        computer.run(input: [2])
        return "\(computer.outputBuffer)"
    }
}
