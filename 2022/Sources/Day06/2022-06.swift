import AdventKit
import Algorithms
import Foundation

public class Day06: Day<Int, Int> {
    public override func part1() throws -> Int {
        return endIndexOfUniqueSequence(ofSize: 4, inString: input)
    }

    public override func part2() throws -> Int {
        return endIndexOfUniqueSequence(ofSize: 14, inString: input)
    }

    private func endIndexOfUniqueSequence(ofSize size: Int, inString string: String) -> Int {
        return Array(string)
            .windows(ofCount: size)
            .first(where: { Set($0).count == size })!
            .endIndex
    }
}
