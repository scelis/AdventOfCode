import AdventKit2
import Foundation

struct Day02: Day {
    let pattern = #"(\d+)-(\d+) (\w): (\w+)"#

    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        var numValid = 0
        try! input().enumerateMatches(withPattern: pattern) { match in
            let min = Int(match[1])!
            let max = Int(match[2])!
            let character = match[3]
            let password = match[4]
            let count = password.reduce(0) { result, char in
                return character == String(char) ? result + 1 : result
            }
            if count >= min && count <= max {
                numValid += 1
            }
        }
        return numValid
    }

    func part2() async throws -> Int {
        var numValid = 0
        try! input().enumerateMatches(withPattern: pattern) { match in
            let i = Int(match[1])! - 1
            let j = Int(match[2])! - 1
            let character = match[3]
            let password = match[4]
            if (password[i] == character) != (password[j] == character) {
                numValid += 1
            }
        }
        return numValid
    }
}
