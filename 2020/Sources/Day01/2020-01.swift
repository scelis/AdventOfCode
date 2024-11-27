import AdventKit
import Foundation

struct Day01: Day {
    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    public func part1() async throws -> Int {
        let integers = inputIntegers()
        for i in 0..<integers.count {
            for j in (i + 1)..<integers.count {
                if integers[i] + integers[j] == 2020 {
                    return integers[i] * integers[j]
                }
            }
        }
        fatalError()
    }

    func part2() async throws -> Int {
        let integers = inputIntegers()
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
