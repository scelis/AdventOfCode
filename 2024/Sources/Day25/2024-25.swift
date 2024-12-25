import AdventKit
import Foundation

struct Day25: Day {
    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        return try await (p1, 0)
    }

    func part1() async throws -> Int {
        let (locks, keys) = parseInput()
        var total = 0
        for lock in locks {
            k: for key in keys {
                for pair in zip(lock, key) {
                    if pair.0 + pair.1 > 5 {
                        continue k
                    }
                }
                total += 1
            }
        }
        return total
    }

    func parseInput() -> (locks: [[Int]], keys: [[Int]]) {
        var locks: [[Int]] = []
        var keys: [[Int]] = []
        input().components(separatedBy: "\n\n").forEach { section in
            let lines = section.components(separatedBy: "\n")
            let isLock = lines[0] == "#####"
            var current: [Int] = .init(repeating: 0, count: 5)
            for i in 1...5 {
                for (index, character) in lines[i].enumerated() {
                    if character == "#" {
                        current[index] += 1
                    }
                }
            }
            if isLock {
                locks.append(current)
            } else {
                keys.append(current)
            }
        }
        return (locks: locks, keys: keys)
    }
}
