import AdventKit2
import Algorithms
import Foundation

struct Day06: Day {
    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        return endIndexOfUniqueSequence(ofSize: 4, inString: input())
    }

    func part2() async throws -> Int {
        return endIndexOfUniqueSequence(ofSize: 14, inString: input())
    }

    private func endIndexOfUniqueSequence(ofSize size: Int, inString string: String) -> Int {
        return Array(string)
            .windows(ofCount: size)
            .first(where: { Set($0).count == size })!
            .endIndex
    }
}
