import AdventKit
import Foundation

public struct Day01: Day {
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

    public func part2() async throws -> Int {
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
