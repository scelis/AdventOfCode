import AdventKit
import Foundation

struct Day04: Day {
    func run() async throws -> (Int, Int) {
        let pairs = inputLines().map { line in
            let rangeStrings = line.components(separatedBy: ",")
            let ranges = rangeStrings.map { rangeString in
                let components = rangeString.components(separatedBy: "-")
                return Int(components[0])!...Int(components[1])!
            }
            return (ranges[0], ranges[1])
        }

        async let p1 = part1(pairs: pairs)
        async let p2 = part2(pairs: pairs)
        return try await (p1, p2)
    }

    func part1(pairs: [(ClosedRange<Int>, ClosedRange<Int>)]) async throws -> Int {
        return pairs.filter { pair in
            return pair.0.contains(pair.1) || pair.1.contains(pair.0)
        }
        .count
    }

    func part2(pairs: [(ClosedRange<Int>, ClosedRange<Int>)]) async throws -> Int {
        return pairs.filter { pair in
            return pair.0.overlaps(pair.1)
        }
        .count
    }
}
