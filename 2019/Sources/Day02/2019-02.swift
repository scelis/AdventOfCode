import AdventKit
import Foundation

struct Day02: Day {
    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        let computer = IntcodeComputer(input: input())
        computer[1] = 12
        computer[2] = 2
        computer.run()
        return computer[0]
    }

    func part2() async throws -> Int {
        for noun in 0...99 {
            for verb in 0...99 {
                let computer = IntcodeComputer(input: input())
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
