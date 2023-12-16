import AdventKit
import Algorithms
import Foundation

public struct Day06: Day {
    public func part1() async throws -> Int {
        return endIndexOfUniqueSequence(ofSize: 4, inString: input())
    }

    public func part2() async throws -> Int {
        return endIndexOfUniqueSequence(ofSize: 14, inString: input())
    }

    private func endIndexOfUniqueSequence(ofSize size: Int, inString string: String) -> Int {
        return Array(string)
            .windows(ofCount: size)
            .first(where: { Set($0).count == size })!
            .endIndex
    }
}
