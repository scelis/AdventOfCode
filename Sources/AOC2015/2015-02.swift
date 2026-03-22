import AdventKit
import Foundation

struct Day02: Day {

    // MARK: - Structures

    private struct Present {
        var length: Int
        var width: Int
        var height: Int
    }

    // MARK: - Solving

    func run(input: String) async throws -> (Int, Int) {
        let presents = parsePresents(input: input)
        async let p1 = part1(presents: presents)
        async let p2 = part2(presents: presents)
        return try await (p1, p2)
    }

    private func part1(presents: [Present]) async throws -> Int {
        presents
            .map { requiredWrappingPaper(for: $0) }
            .reduce(0, +)
    }

    private func part2(presents: [Present]) async throws -> Int {
        presents
            .map { requiredRibbon(for: $0) }
            .reduce(0, +)
    }

    private func surfaceArea(of present: Present) -> Int {
        2 * present.length * present.width + 2 * present.width * present.height + 2 * present.height * present.length
    }

    private func requiredWrappingPaper(for present: Present) -> Int {
        let smallestSide = min(present.length * present.width, present.width * present.height, present.height * present.length)
        return surfaceArea(of: present) + smallestSide
    }

    private func requiredRibbon(for present: Present) -> Int {
        let sides = [present.height, present.width, present.length].sorted()
        return sides[0] * 2 + sides[1] * 2 + sides.reduce(1, *)
    }

    // MARK: - Parsing

    private func parsePresents(input: String) -> [Present] {
        input.lines.map { parsePresent(string: $0) }
    }

    private func parsePresent(string: String) -> Present {
        let components = string.components(separatedBy: "x")
        return Present(length: Int(components[0])!, width: Int(components[1])!, height: Int(components[2])!)
    }
}
