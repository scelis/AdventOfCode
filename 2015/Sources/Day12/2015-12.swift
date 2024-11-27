import AdventKit
import Foundation

struct Day12: Day {

    // MARK: Solving

    func run() async throws -> (Int, Int) {
        async let p1 = try part1()
        async let p2 = try part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        let json = try parseJSON()
        return sumOfNumbers(within: json, ignoringRed: false)
    }

    func part2() async throws -> Int {
        let json = try parseJSON()
        return sumOfNumbers(within: json, ignoringRed: true)
    }

    func sumOfNumbers(within json: Any, ignoringRed: Bool) -> Int {
        if let json = json as? [Any] {
            return json.reduce(0) { $0 + sumOfNumbers(within: $1, ignoringRed: ignoringRed)}
        } else if let json = json as? [String: Any] {
            if ignoringRed, json.values.contains(where: { ($0 as? String) == "red" }) {
                return 0
            } else {
                return json.values.reduce(0) { $0 + sumOfNumbers(within: $1, ignoringRed: ignoringRed)}
            }
        } else if let json = json as? Int {
            return json
        } else {
            return 0
        }
    }

    // MARK: Parsing

    func parseJSON() throws -> Any {
        try JSONSerialization.jsonObject(with: input().data(using: .utf8)!)
    }
}
