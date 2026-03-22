import AdventKit
import Foundation

struct Day06: Day {
    func run(input: String) async throws -> (Int, Int) {
        let lines = input.lines
        async let p1 = part1(lines: lines)
        async let p2 = part2(lines: lines)
        return try await (p1, p2)
    }

    func part1(lines: [String]) async throws -> Int {
        lines
            .split(separator: "")
            .map({ Set($0.joined()) })
            .reduce(0, { $0 + $1.count })
    }

    func part2(lines: [String]) async throws -> Int {
        lines
            .split(separator: "")
            .map { arr in
                arr.reduce(Set(arr.first!), { $0.intersection($1) })
            }
            .reduce(0, { $0 + $1.count })
    }
}
