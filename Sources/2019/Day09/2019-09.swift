import AdventKit
import Foundation

public class Day09: Day<Int, Int> {
    public override func part1() throws -> Int {
        let computer = IntcodeComputer(input: input)
        computer.run(input: [1])
        return computer.outputBuffer.first!
    }

    public override func part2() throws -> Int {
        let computer = IntcodeComputer(input: input)
        computer.run(input: [2])
        return computer.outputBuffer.first!
    }
}
