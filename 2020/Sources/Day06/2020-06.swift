import AdventKit
import Foundation

public class Day06: Day<Int, Int> {
    public override func part1() throws -> Int {
        inputLines
            .split(separator: "")
            .map({ Set($0.joined()) })
            .reduce(0, { $0 + $1.count })
    }

    public override func part2() throws -> Int {
        inputLines
            .split(separator: "")
            .map { arr in
                arr.reduce(Set(arr.first!), { $0.intersection($1) })
            }
            .reduce(0, { $0 + $1.count })
    }
}
