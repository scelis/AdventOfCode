import AdventKit
import Foundation

public class Day02: Day<Int, Int> {
    public override func part1() throws -> Int {
        let computer = IntcodeComputer(input: input)
        computer[1] = 12
        computer[2] = 2
        computer.run()
        return computer[0]
    }

    public override func part2() throws -> Int {
        for noun in 0...99 {
            for verb in 0...99 {
                let computer = IntcodeComputer(input: input)
                computer[1] = noun
                computer[2] = verb
                computer.run()
                if computer[0] == 19690720 {
                    return 100 * noun + verb
                }
            }
        }
        fatalError()
    }
}
