import AdventKit
import Algorithms
import Foundation

struct Day03: Day {
    func priority(for character: Character) -> Int {
        if character.isLowercase {
            return Int(character.asciiValue! - Character("a").asciiValue!) + 1
        } else {
            return Int(character.asciiValue! - Character("A").asciiValue!) + 27
        }
    }

    func run(input: String) async throws -> (Int, Int) {
        let lines = input.lines
        async let p1 = part1(lines: lines)
        async let p2 = part2(lines: lines)
        return try await (p1, p2)
    }

    func part1(lines: [String]) async throws -> Int {
        return lines
            .map { line -> Int in
                let first = Set(line[0..<line.count/2])
                let second = Set(line[line.count/2..<line.count])
                return priority(for: first.intersection(second).first!)
            }
            .reduce(0, +)
    }

    func part2(lines: [String]) async throws -> Int {
        return lines
            .map { Set($0) }
            .chunks(ofCount: 3)
            .map { chunk -> Int in
                let intersection = chunk.dropFirst().reduce(chunk.first!) { $0.intersection($1) }
                return priority(for: intersection.first!)
            }
            .reduce(0, +)
    }
}
