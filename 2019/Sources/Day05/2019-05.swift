import AdventKit
import Foundation

public class Day05: Day<Int, Int> {
    public override func part1() throws -> Int {
        let computer = IntcodeComputer(input: input)
        computer.run(input: [1])
        return computer.outputBuffer.last!
    }

    public override func part2() throws -> Int {
        let computer = IntcodeComputer(input: input)
        computer.run(input: [5])
        return computer.outputBuffer.last!
    }
}
