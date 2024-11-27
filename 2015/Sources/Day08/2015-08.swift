import AdventKit
import Foundation

struct Day08: Day {

    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        inputLines()
            .map { Array($0) }
            .map { array in
                var difference = 2
                var i = 1
                while i < array.count - 1 {
                    if array[i] == "\\" {
                        if (array[i + 1] == "\\" || array[i + 1] == "\"") {
                            difference += 1
                            i += 2
                        } else if array[i + 1] == "x" {
                            difference += 3
                            i += 4
                        } else {
                            fatalError("Unexpected escaped character: \(array[i + 1])")
                        }
                    } else {
                        i += 1
                    }
                }
                return difference
            }
            .reduce(0, +)
    }

    func part2() async throws -> Int {
        inputLines()
            .map { Array($0) }
            .map { array in
                var difference = 4
                for i in 1..<(array.count - 1) {
                    if array[i] == "\\" || array[i] == "\"" {
                        difference += 1
                    }
                }
                return difference
            }
            .reduce(0, +)
    }
}
