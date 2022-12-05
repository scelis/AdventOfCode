import AdventKit
import Algorithms
import Foundation
import Parsing

class Day05: Day {
    override func part1() -> Any {
        return solve(isPartOne: true)
    }

    override func part2() -> Any {
        return solve(isPartOne: false)
    }

    func solve(isPartOne: Bool) -> Any {
        let parts = inputString.components(separatedBy: "\n\n")

        var stacks: [[Character]] = .init(repeating: [], count: 9)
        parts[0].components(separatedBy: .newlines).dropLast().forEach { line in
            for (index, chunk) in line.chunks(ofCount: 4).enumerated() {
                if let crate = chunk.dropFirst().first, crate != " " {
                    stacks[index].append(crate)
                }
            }
        }

        let moveParser = Parse { "move "; Int.parser(); " from "; Int.parser(); " to "; Int.parser() }
        let parser = Many(element: { moveParser }, separator: { "\n" })
        for move in try! parser.parse(parts[1]) {
            let (count, source, destination) = (move.0, move.1 - 1, move.2 - 1)
            let crates = Array(stacks[source][0..<count])
            stacks[source] = Array(stacks[source].dropFirst(count))
            stacks[destination] = (isPartOne ? crates.reversed() : crates) + stacks[destination]
        }

        return stacks.reduce("") { $0 + String($1.first!) }
    }
}

Day05().run()
