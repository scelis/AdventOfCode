import AdventKit
import Foundation

public struct Day01: Day {
    public func part1() async throws -> Int {
        return inputIntegers()
            .reduce(0) { total, mass in
                return total + mass / 3 - 2
            }
    }

    public func part2() async throws -> Int {
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
