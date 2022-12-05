import AdventKit
import Foundation

class Day15: Day {
    override func part1() -> Any {
        return numberSpoken(atTurn: 2020).description
    }

    override func part2() -> Any {
        return numberSpoken(atTurn: 30_000_000).description
    }

    func numberSpoken(atTurn turn: Int) -> Int {
        let numbers = inputString.components(separatedBy: ",").map({ Int($0)! })

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
