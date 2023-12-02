import AdventKit
import Foundation

public class Day02: Day<Int, Int> {
    private struct Present {
        var length: Int
        var width: Int
        var height: Int
    }

    public override func part1() throws -> Int {
        presents
            .map { requiredWrappingPaper(for: $0) }
            .reduce(0, +)
    }

    public override func part2() throws -> Int {
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

    private lazy var presents: [Present] = inputLines.map { parsePresent(string: $0) }

    private func parsePresent(string: String) -> Present {
        let components = string.components(separatedBy: "x")
        return Present(length: Int(components[0])!, width: Int(components[1])!, height: Int(components[2])!)
    }
}
