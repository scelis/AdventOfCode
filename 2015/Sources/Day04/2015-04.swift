import AdventKit
import Foundation

public struct Day04: Day {
    public func part1() async throws -> Int {
        findHash(prefix: "00000")
    }

    public func part2() async throws -> Int {
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
