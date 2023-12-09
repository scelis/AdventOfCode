import AdventKit
import Foundation

public class Day09: Day<Int, Int> {
    public override func part1() throws -> Int {
        integers
            .map { calculateNext(in: $0) }
            .reduce(0, +)
    }

    public override func part2() throws -> Int {
        integers
            .map { calculatePrevious(in: $0) }
            .reduce(0, +)
    }

    func calculateNext(in sequence: [Int]) -> Int {
        if sequence.allSatisfy({ $0 == 0 }) {
            return 0
        }

        let differences = sequence.adjacentPairs().map({ $1 - $0 })
        return sequence.last! + calculateNext(in: differences)
    }

    func calculatePrevious(in sequence: [Int]) -> Int {
        if sequence.allSatisfy({ $0 == 0 }) {
            return 0
        }

        let differences = sequence.adjacentPairs().map({ $1 - $0 })
        return sequence.first! - calculatePrevious(in: differences)
    }

    // MARK: - Parsing

    lazy var integers: [[Int]] = inputLines.map({ $0.components(separatedBy: " ").compactMap(Int.init) })
}
