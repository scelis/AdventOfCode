import AdventKit
import Foundation

public class Day01: Day<Int, Int> {
    public override func part1() throws -> Int {
        input.reduce(0) { floor, character in
            if character == "(" {
                return floor + 1
            } else if character == ")" {
                return floor - 1
            } else {
                return floor
            }
        }
    }

    public override func part2() throws -> Int {
        var floor = 0
        for (index, character) in input.enumerated() {
            if character == "(" {
                floor += 1
            } else if character == ")" {
                floor -= 1
                if floor < 0 {
                    return index + 1
                }
            }
        }
        fatalError()
    }
}
