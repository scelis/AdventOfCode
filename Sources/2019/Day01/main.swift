import AdventKit
import Foundation

class Day01: Day {
    override func part1() -> String {
        return inputIntegers.reduce(0) { total, mass in
            return total + mass / 3 - 2
        }.description
    }

    override func part2() -> String {
        return inputIntegers.reduce(0) { total, mass in
            return total + fuelRequired(forItemWithMass: mass)
        }.description
    }

    func fuelRequired(forItemWithMass mass: Int) -> Int {
        guard mass > 0 else { return 0 }
        let fuel = max(0, mass / 3 - 2)
        return fuel + fuelRequired(forItemWithMass: fuel)
    }
}

Day01().run()
