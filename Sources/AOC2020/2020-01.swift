import AdventKit
import Foundation

struct Day01: Day {
    func run(input: String) async throws -> (Int, Int) {
        let integers = input.integers
        async let p1 = part1(integers: integers)
        async let p2 = part2(integers: integers)
        return try await (p1, p2)
    }

    public func part1(integers: [Int]) async throws -> Int {
        for i in 0..<integers.count {
            for j in (i + 1)..<integers.count {
                if integers[i] + integers[j] == 2020 {
                    return integers[i] * integers[j]
                }
            }
        }
        fatalError()
    }

    func part2(integers: [Int]) async throws -> Int {
        for i in 0..<integers.count {
            for j in (i + 1)..<integers.count {
                for k in (j + 1)..<integers.count {
                    if integers[i] + integers[j] + integers[k] == 2020 {
                        return integers[i] * integers[j] * integers[k]
                    }
                }
            }
        }
        fatalError()
    }
}
