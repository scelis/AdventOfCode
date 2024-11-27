import AdventKit2
import Foundation

struct Day01: Day {
    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        return inputIntegers()
            .reduce(0) { total, mass in
                return total + mass / 3 - 2
            }
    }

    func part2() async throws -> Int {
        return inputIntegers()
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
