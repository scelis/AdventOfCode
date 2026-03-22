import AdventKit
import Foundation

struct Day08: Day {

    func run(input: String) async throws -> (Int, Int) {
        let lines = input.lines
        async let p1 = part1(lines: lines)
        async let p2 = part2(lines: lines)
        return try await (p1, p2)
    }

    func part1(lines: [String]) async throws -> Int {
        lines
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

    func part2(lines: [String]) async throws -> Int {
        lines
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
