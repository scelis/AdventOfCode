import AdventKit
import Foundation

struct Day11: Day {
    func run() async throws -> (Int, Int) {
        let stones = parseStoneCounts()
        async let p1 = calculateNumberOfStones(stones: stones, blinks: 25)
        async let p2 = calculateNumberOfStones(stones: stones, blinks: 75)
        return try await (p1, p2)
    }

    func calculateNumberOfStones(stones: [Int: Int], blinks: Int) async throws -> Int {
        var stones = stones
        for _ in 0..<blinks {
            stones = blink(stones: stones)
        }
        return stones.values.reduce(0, +)
    }

    func blink(stones: [Int: Int]) -> [Int: Int] {
        var newStones: [Int: Int] = [:]
        for (stone, count) in stones {
            if stone == 0 {
                newStones[1, default: 0] += count
            } else if
                case let numberOfDigits = stone.numberOfDigits,
                numberOfDigits % 2 == 0
            {
                let pivot = pow(10, numberOfDigits / 2)
                newStones[stone / pivot, default: 0] += count
                newStones[stone % pivot, default: 0] += count
            } else {
                newStones[stone * 2024, default: 0] += count
            }
        }
        return newStones
    }

    func parseStoneCounts() -> [Int: Int] {
        inputIntegers().reduce(into: [:]) { $0[$1, default: 0] += 1 }
    }
}
