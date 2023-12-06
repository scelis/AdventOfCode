import AdventKit
import CryptoKit
import Foundation

public class Day04: Day<Int, Int> {
    private let key = "yzbqklnj"

    public override func part1() throws -> Int {
        findHash(prefix: "00000")
    }

    public override func part2() throws -> Int {
        findHash(prefix: "000000")
    }

    private func findHash(prefix: String) -> Int {
        var i = 1
        while true {
            let candidate = "\(key)\(i)"
            let hash = candidate.data(using: .utf8)!.md5
            if hash.hasPrefix(prefix) {
                return i
            }
            i += 1
        }
    }
}

extension Data {
    var md5: String {
        Insecure.MD5
            .hash(data: self)
            .map { String(format: "%02x", $0) }
            .joined()
    }
}
