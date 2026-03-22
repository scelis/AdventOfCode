import AdventKit
import Algorithms
import Foundation

struct Day05: Day {
    func run(input: String) async throws -> (String, String) {
        async let p1 = part1(input: input)
        async let p2 = part2(input: input)
        return try await (p1, p2)
    }

    func part1(input: String) async throws -> String {
        return try solve(input: input, isPartOne: true)
    }

    func part2(input: String) async throws -> String {
        return try solve(input: input, isPartOne: false)
    }

    func solve(input: String, isPartOne: Bool) throws -> String {
        let parts = input.components(separatedBy: "\n\n")

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
