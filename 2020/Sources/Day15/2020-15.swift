import AdventKit
import Foundation

struct Day15: Day {
    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        return numberSpoken(atTurn: 2020)
    }

    func part2() async throws -> Int {
        return numberSpoken(atTurn: 30_000_000)
    }

    func numberSpoken(atTurn turn: Int) -> Int {
        let numbers = input().components(separatedBy: ",").map({ Int($0)! })

        var lastNumber = 0
        var turnForNumber: [Int: Int] = [:]
        var turnsSinceLastNumber = 0
        for turn in 0..<turn {
            let number: Int
            if turn < numbers.count {
                number = numbers[turn]
            } else {
                number = turnsSinceLastNumber
            }

            turnsSinceLastNumber = turn - (turnForNumber[number] ?? turn)
            turnForNumber[number] = turn
            lastNumber = number
        }

        return lastNumber
    }
}
