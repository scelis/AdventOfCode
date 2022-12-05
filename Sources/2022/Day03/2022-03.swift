import AdventKit
import Algorithms
import Foundation

public class Day03: Day<Int, Int> {
    func priority(for character: Character) -> Int {
        if character.isLowercase {
            return Int(character.asciiValue! - Character("a").asciiValue!) + 1
        } else {
            return Int(character.asciiValue! - Character("A").asciiValue!) + 27
        }
    }

    public override func part1() throws -> Int {
        return input
            .components(separatedBy: .newlines)
            .map { line -> Int in
                let first = Set(line[0..<line.count/2])
                let second = Set(line[line.count/2..<line.count])
                return priority(for: first.intersection(second).first!)
            }
            .reduce(0, +)
    }

    public override func part2() throws -> Int {
        return input
            .components(separatedBy: .newlines)
            .map { Set($0) }
            .chunks(ofCount: 3)
            .map { chunk -> Int in
                let intersection = chunk.dropFirst().reduce(chunk.first!) { $0.intersection($1) }
                return priority(for: intersection.first!)
            }
            .reduce(0, +)
    }
}
