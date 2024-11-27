import AdventKit
import Foundation

struct Day05: Day {
    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        let computer = IntcodeComputer(input: input())
        computer.run(input: [1])
        return computer.outputBuffer.last!
    }

    func part2() async throws -> Int {
        let computer = IntcodeComputer(input: input())
        computer.run(input: [5])
        return computer.outputBuffer.last!
    }
}
