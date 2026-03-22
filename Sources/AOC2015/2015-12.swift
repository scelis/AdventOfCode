import AdventKit
import Foundation

struct Day12: Day {

    // MARK: Solving

    func run(input: String) async throws -> (Int, Int) {
        async let p1 = part1(input: input)
        async let p2 = part2(input: input)
        return try await (p1, p2)
    }

    func part1(input: String) async throws -> Int {
        let json = try parseJSON(input: input)
        return sumOfNumbers(within: json, ignoringRed: false)
    }

    func part2(input: String) async throws -> Int {
        let json = try parseJSON(input: input)
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

    func parseJSON(input: String) throws -> Any {
        try JSONSerialization.jsonObject(with: input.data(using: .utf8)!)
    }
}
