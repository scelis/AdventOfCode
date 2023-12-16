import AdventKit
import Foundation

public struct Day05: Day {
    public func part1() async throws -> Int {
        let computer = IntcodeComputer(input: input())
        computer.run(input: [1])
        return computer.outputBuffer.last!
    }

    public func part2() async throws -> Int {
        let computer = IntcodeComputer(input: input())
        computer.run(input: [5])
        return computer.outputBuffer.last!
    }
}
