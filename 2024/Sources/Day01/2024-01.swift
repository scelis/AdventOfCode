import AdventKit
import Foundation

struct Day01: Day {
    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        let (left, right): ([Int], [Int]) = inputLines().reduce(into: ([], [])) { result, line in
            let numbers = line.components(separatedBy: .whitespaces).compactMap(Int.init)
            result.0.append(numbers[0])
            result.1.append(numbers[1])
        }

        return zip(left.sorted(), right.sorted()).reduce(0) { $0 + abs($1.0 - $1.1) }
    }

    func part2() async throws -> Int {
        let (left, right): ([Int], [Int: Int]) = inputLines().reduce(into: ([], [:])) { result, line in
            let numbers = line.components(separatedBy: .whitespaces).compactMap(Int.init)
            result.0.append(numbers[0])
            result.1[numbers[1], default: 0] += 1
        }

        return left.map({ $0 * right[$0, default: 0] }).reduce(0, +)
    }
}
