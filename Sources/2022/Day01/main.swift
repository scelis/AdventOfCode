import AdventKit
import Foundation

class Day01: Day {
    lazy var sortedElves: [Int] = {
        return inputString
            .split(separator: "\n\n")
            .map {
                $0.split(separator: "\n")
                    .map({ Int($0)! })
                    .reduce(0, +)
            }
            .sorted(by: >)
    }()

    override func part1() -> String {
        return sortedElves.first!.description
    }

    override func part2() -> String {
        return sortedElves
            .prefix(3)
            .reduce(0, +)
            .description
    }
}

Day01().run()
