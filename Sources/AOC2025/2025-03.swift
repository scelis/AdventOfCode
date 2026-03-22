import AdventKit
import Foundation

struct Day03: Day {
    func run(input: String) async throws -> (Int, Int) {
        let lines = input.lines
        async let p1 = part1(lines: lines)
        async let p2 = part2(lines: lines)
        return try await (p1, p2)
    }

    func part1(lines: [String]) async throws -> Int {
        solve(lines: lines, batterySize: 2)
    }

    func part2(lines: [String]) async throws -> Int {
        solve(lines: lines, batterySize: 12)
    }

    func solve(lines: [String], batterySize: Int) -> Int {
        lines
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
