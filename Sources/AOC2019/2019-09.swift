import AdventKit
import Foundation

struct Day09: Day {
    func run(input: String) async throws -> (Int, Int) {
        async let p1 = part1(input: input)
        async let p2 = part2(input: input)
        return try await (p1, p2)
    }

    func part1(input: String) async throws -> Int {
        let computer = IntcodeComputer(input: input)
        computer.run(input: [1])
        return computer.outputBuffer.first!
    }

    func part2(input: String) async throws -> Int {
        let computer = IntcodeComputer(input: input)
        computer.run(input: [2])
        return computer.outputBuffer.first!
    }
}
