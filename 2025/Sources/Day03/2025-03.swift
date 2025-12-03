import AdventKit
import Foundation

struct Day03: Day {
    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        solve(batterySize: 2)
    }

    func part2() async throws -> Int {
        solve(batterySize: 12)
    }

    func solve(batterySize: Int) -> Int {
        inputLines()
            .map { $0.map { $0.wholeNumberValue! } }
            .reduce(0) { $0 + maximumJoltage($1, batterySize: batterySize) }
    }

    func maximumJoltage(_ batteries: [Int], batterySize: Int) -> Int {
        var selected: [Int] = .init(repeating: -1, count: batterySize)

        for (i, battery) in batteries.enumerated() {
            let remaining = batteries.count - 1 - i
            for j in max(0, batterySize - remaining - 1)..<selected.count {
                if battery > selected[j] {
                    selected[j] = battery
                    for l in j+1..<selected.count {
                        selected[l] = -1
                    }
                    break
                }
            }
        }

        return selected.reduce(0) { $0 * 10 + $1 }
    }
}
