import AdventKit2
import Algorithms
import Foundation

struct Day13: Day {

    // MARK: - Solving

    func run() async throws -> (Int, Int) {
        let patterns = parsePatterns()
        async let p1 = part1(patterns: patterns)
        async let p2 = part2(patterns: patterns)
        return try await (p1, p2)
    }

    func part1(patterns: [[[Character]]]) async throws -> Int {
        return solve(patterns: patterns, withSmudge: false)
    }

    func part2(patterns: [[[Character]]]) async throws -> Int {
        return solve(patterns: patterns, withSmudge: true)
    }

    func solve(patterns: [[[Character]]], withSmudge: Bool) -> Int {
        let leftSum = patterns
            .compactMap { verticalReflectionIndex(pattern: $0, withSmudge: withSmudge) }
            .reduce(0, +)

        let upperSum = patterns
            .map { $0.rotateClockwise() }
            .compactMap { verticalReflectionIndex(pattern: $0, withSmudge: withSmudge) }
            .reduce(0, +)

        return leftSum + 100 * upperSum
    }

    func verticalReflectionIndex(pattern: [[Character]], withSmudge: Bool) -> Int? {
        let width = pattern[0].count
        for x in 0..<(width - 1) {
            let equality = pattern.compareColumn(atIndex: x, withColumnAtIndex: x + 1, allowSmudge: withSmudge)
            if equality == .equal || equality == .equalWithSmudge {
                var left = x - 1
                var right = x + 2
                var isReflecting = true
                var foundSmudge = (equality == .equalWithSmudge)

                while isReflecting && left >= 0 && right < width {
                    switch pattern.compareColumn(atIndex: left, withColumnAtIndex: right, allowSmudge: withSmudge && !foundSmudge) {
                    case .equal:
                        break
                    case .equalWithSmudge:
                        foundSmudge = true
                    case .notEqual:
                        isReflecting = false
                    }
                    left -= 1
                    right += 1
                }
                if isReflecting {
                    if (withSmudge && foundSmudge) || !withSmudge {
                        return x + 1
                    }
                }
            }
        }

        return nil
    }

    // MARK: - Parsing

    func parsePatterns() -> [[[Character]]] {
        input().components(separatedBy: "\n\n").map { section in
            section.components(separatedBy: "\n").map(Array.init)
        }
    }
}

enum EqualityIndex: Equatable {
    case equal
    case equalWithSmudge
    case notEqual
}

private extension [[Character]] {
    func compareColumn(atIndex a: Int, withColumnAtIndex b: Int, allowSmudge: Bool) -> EqualityIndex {
        var foundSmudge = false
        for row in self {
            if row[a] != row[b] {
                if allowSmudge {
                    if foundSmudge {
                        return .notEqual
                    } else {
                        foundSmudge = true
                    }
                } else {
                    return .notEqual
                }
            }
        }
        return (allowSmudge && foundSmudge) ? .equalWithSmudge : .equal
    }

    func rotateClockwise() -> [[Character]] {
        return (0..<self[0].count).map { column in
            return (0..<self.count).map { row in
                return self[row][column]
            }
        }
    }
}
