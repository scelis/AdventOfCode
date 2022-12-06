import AdventKit
import Algorithms
import Foundation

public class Day06: Day<Int, Int> {
    public override func part1() throws -> Int {
        return indexOfUniqueSequence(ofSize: 4, inString: input)! + 4
    }

    public override func part2() throws -> Int {
        return indexOfUniqueSequence(ofSize: 14, inString: input)! + 14
    }

    private func indexOfUniqueSequence(ofSize size: Int, inString string: String) -> Int? {
        string
            .windows(ofCount: size)
            .enumerated()
            .first { Set($0.element).count == size }?
            .offset
    }
}
