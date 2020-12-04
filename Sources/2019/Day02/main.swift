import AdventKit
import Foundation
import IntcodeComputer

class Day02: Day {
    override func part1() -> String {
        let computer = IntcodeComputer(input: inputString)
        computer[1] = 12
        computer[2] = 2
        computer.run()
        return computer[0].description
    }

    override func part2() -> String {
        for noun in 0...99 {
            for verb in 0...99 {
                let computer = IntcodeComputer(input: inputString)
                computer[1] = noun
                computer[2] = verb
                computer.run()
                if computer[0] == 19690720 {
                    return "\(100 * noun + verb)"
                }
            }
        }
        return ""
    }
}

Day02().run()
