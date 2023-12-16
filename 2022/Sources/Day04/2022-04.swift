import AdventKit
import Foundation

public struct Day04: Day {
    var pairs: [(ClosedRange<Int>, ClosedRange<Int>)]

    init() {
        self.pairs = Self.inputLines().map { line in
            let rangeStrings = line.components(separatedBy: ",")
            let ranges = rangeStrings.map { rangeString in
                let components = rangeString.components(separatedBy: "-")
                return Int(components[0])!...Int(components[1])!
            }
            return (ranges[0], ranges[1])
        }
    }

    public func part1() async throws -> Int {
        return pairs.filter { pair in
            return pair.0.contains(pair.1) || pair.1.contains(pair.0)
        }
        .count
    }

    public func part2() async throws -> Int {
        return pairs.filter { pair in
            return pair.0.overlaps(pair.1)
        }
        .count
    }
}
