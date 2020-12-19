import AdventKit
import Foundation

class Day15: Day {
    override func part1() -> String {
        return numberSpoken(atTurn: 2020).description
    }

    override func part2() -> String {
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

assert(Day15(input: "1,3,2").part1() == "1")
assert(Day15(input: "2,1,3").part1() == "10")
assert(Day15(input: "1,2,3").part1() == "27")
assert(Day15(input: "2,3,1").part1() == "78")
assert(Day15(input: "3,2,1").part1() == "438")
assert(Day15(input: "3,1,2").part1() == "1836")

Day15().run()
