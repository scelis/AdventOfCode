import AdventKit
import Foundation

struct Day01: Day {
    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        input().reduce(0) { floor, character in
            if character == "(" {
                return floor + 1
            } else if character == ")" {
                return floor - 1
            } else {
                return floor
            }
        }
    }

    func part2() async throws -> Int {
        var floor = 0
        for (index, character) in input().enumerated() {
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
