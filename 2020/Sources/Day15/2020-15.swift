import AdventKit
import Foundation

public struct Day15: Day {
    public func part1() async throws -> Int {
        return numberSpoken(atTurn: 2020)
    }

    public func part2() async throws -> Int {
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
