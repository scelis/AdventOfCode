import AdventKit
import Foundation

public struct Day01: Day {
    var sortedElves: [Int]

    init() {
        self.sortedElves = Self.input()
            .components(separatedBy: "\n\n")
            .map { $0.components(separatedBy: "\n").map({ Int($0)! }).reduce(0, +) }
            .sorted(by: >)
    }

    public func part1() async throws -> Int {
        return sortedElves.first!
    }

    public func part2() async throws -> Int {
        return sortedElves
            .prefix(3)
            .reduce(0, +)
    }
}
