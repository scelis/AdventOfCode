import AdventKit
import Foundation

class Day06: Day {
    override func part1() -> Any {
        inputLines
            .split(separator: "")
            .map({ Set($0.joined()) })
            .reduce(0, { $0 + $1.count })
            .description
    }

    override func part2() -> Any {
        inputLines
            .split(separator: "")
            .map { arr in
                arr.reduce(Set(arr.first!), { $0.intersection($1) })
            }.reduce(0, { $0 + $1.count })
            .description
    }
}
