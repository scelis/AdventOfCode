import AdventKit
import Foundation

public class Day01: Day<Int, Int> {
    lazy var sortedElves: [Int] = {
        return input
            .split(separator: "\n\n")
            .map {
                $0.split(separator: "\n")
                    .map { Int($0)! }
                    .reduce(0, +)
            }
            .sorted(by: >)
    }()

    public override func part1() throws -> Int {
        return sortedElves.first!
    }

    public override func part2() throws -> Int {
        return sortedElves
            .prefix(3)
            .reduce(0, +)
    }
}
