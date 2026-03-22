import AdventKit
import Foundation

struct Day01: Day {
    func run(input: String) async throws -> (Int, Int) {
        let integers = input.integers
        async let p1 = part1(integers: integers)
        async let p2 = part2(integers: integers)
        return try await (p1, p2)
    }

    func part1(integers: [Int]) async throws -> Int {
        return integers
            .reduce(0) { total, mass in
                return total + mass / 3 - 2
            }
    }

    func part2(integers: [Int]) async throws -> Int {
        return integers
            .reduce(0) { total, mass in
                return total + fuelRequired(forItemWithMass: mass)
            }
    }

    func fuelRequired(forItemWithMass mass: Int) -> Int {
        guard mass > 0 else { return 0 }
        let fuel = max(0, mass / 3 - 2)
        return fuel + fuelRequired(forItemWithMass: fuel)
    }
}
