import AdventKit
import Foundation

struct Day04: Day {
    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    public func part1() async throws -> Int {
        findHash(prefix: "00000")
    }

    func part2() async throws -> Int {
        findHash(prefix: "000000")
    }

    private func findHash(prefix: String) -> Int {
        let key = input()

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
