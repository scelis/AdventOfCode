import AdventKit
import Algorithms
import Foundation

public struct Day05: Day {
    public func part1() async throws -> String {
        return try solve(isPartOne: true)
    }

    public func part2() async throws -> String {
        return try solve(isPartOne: false)
    }

    func solve(isPartOne: Bool) throws -> String {
        let parts = input().components(separatedBy: "\n\n")

        var stacks: [[Character]] = .init(repeating: [], count: 9)
        parts[0].components(separatedBy: .newlines).dropLast().forEach { line in
            for (index, chunk) in line.chunks(ofCount: 4).enumerated() {
                if let crate = chunk.dropFirst().first, crate != " " {
                    stacks[index].append(crate)
                }
            }
        }

        try parts[1].enumerateMatches(withPattern: "move ([0-9]+) from ([0-9]+) to ([0-9]+)") { match in
            let (count, source, destination) = (Int(match[1])!, Int(match[2])! - 1, Int(match[3])! - 1)
            let crates = Array(stacks[source][0..<count])
            stacks[source] = Array(stacks[source].dropFirst(count))
            stacks[destination] = (isPartOne ? crates.reversed() : crates) + stacks[destination]
        }

        return stacks.reduce("") { $0 + String($1.first!) }
    }
}
