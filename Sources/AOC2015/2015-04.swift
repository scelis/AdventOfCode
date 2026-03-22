import AdventKit
import Foundation

struct Day04: Day {
    func run(input: String) async throws -> (Int, Int) {
        async let p1 = part1(input: input)
        async let p2 = part2(input: input)
        return try await (p1, p2)
    }

    public func part1(input: String) async throws -> Int {
        findHash(key: input, prefix: "00000")
    }

    func part2(input: String) async throws -> Int {
        findHash(key: input, prefix: "000000")
    }

    private func findHash(key: String, prefix: String) -> Int {
        var i = 1
        while true {
            let candidate = "\(key)\(i)"
            let hash = candidate.data(using: .utf8)!.md5()
            if hash.hasPrefix(prefix) {
                return i
            }
            i += 1
        }
    }
}
