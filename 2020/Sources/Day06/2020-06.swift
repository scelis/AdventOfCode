import AdventKit
import Foundation

public struct Day06: Day {
    public func part1() async throws -> Int {
        inputLines()
            .split(separator: "")
            .map({ Set($0.joined()) })
            .reduce(0, { $0 + $1.count })
    }

    public func part2() async throws -> Int {
        inputLines()
            .split(separator: "")
            .map { arr in
                arr.reduce(Set(arr.first!), { $0.intersection($1) })
            }
            .reduce(0, { $0 + $1.count })
    }
}
