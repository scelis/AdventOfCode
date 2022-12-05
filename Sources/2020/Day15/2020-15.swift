import AdventKit
import Foundation

public class Day15: Day<Int, Int> {
    lazy var numbers: [Int] = {
        return input.components(separatedBy: ",").map({ Int($0)! })
    }()

    public override func part1() throws -> Int {
        return numberSpoken(atTurn: 2020)
    }

    public override func part2() throws -> Int {
        return numberSpoken(atTurn: 30_000_000)
    }

    func numberSpoken(atTurn turn: Int) -> Int {
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
