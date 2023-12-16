import AdventKit
import Foundation

public struct Day09: Day {
    public func part1() async throws -> Int {
        let computer = IntcodeComputer(input: input())
        computer.run(input: [1])
        return computer.outputBuffer.first!
    }

    public func part2() async throws -> Int {
        let computer = IntcodeComputer(input: input())
        computer.run(input: [2])
        return computer.outputBuffer.first!
    }
}
