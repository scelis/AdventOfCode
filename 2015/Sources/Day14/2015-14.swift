import AdventKit
import Foundation

struct Day14: Day {

    // MARK: Structures

    struct Reindeer {
        var name: String
        var speed: Int
        var activeDuration: Int
        var restDuration: Int
    }

    // MARK: Solving

    func run() async throws -> (Int, Int) {
        let reindeer = parseReindeer()
        async let p1 = part1(reindeer: reindeer, seconds: 2503)
        async let p2 = part2(reindeer: reindeer, seconds: 2503)
        return try await (p1, p2)
    }

    func part1(reindeer: [Reindeer], seconds: Int) async throws -> Int {
        findWinners(reindeer: reindeer, seconds: seconds).distance
    }

    func part2(reindeer: [Reindeer], seconds: Int) async throws -> Int {
        var points: [String: Int] = [:]
        for time in 1...seconds {
            for name in findWinners(reindeer: reindeer, seconds: time).names {
                points[name, default: 0] += 1
            }
        }

        return points.values.max()!
    }

    func findWinners(reindeer: [Reindeer], seconds: Int) -> (names: Set<String>, distance: Int) {
        let distances = reindeer.map { reindeer -> (String, Int) in
            let period = reindeer.activeDuration + reindeer.restDuration
            let numPeriods = seconds / period
            let remainder = seconds % period
            let distancePerPeriod = reindeer.speed * reindeer.activeDuration
            let distance = distancePerPeriod * numPeriods + min(remainder, reindeer.activeDuration) * reindeer.speed
            return (reindeer.name, distance)
        }

        let maxDistance = distances.map(\.1).max()!
        let names = distances.compactMap { $0.1 == maxDistance ? $0.0 : nil }
        return (Set(names), maxDistance)
    }

    // MARK: Parsing

    func parseReindeer() -> [Reindeer] {
        let regex = #/^(\w+) can fly (\d+) km/s for (\d+) seconds, but then must rest for (\d+) seconds./#

        return inputLines().map { line in
            let match = line.firstMatch(of: regex)!
            return Reindeer(
                name: String(match.1),
                speed: Int(match.2)!,
                activeDuration: Int(match.3)!,
                restDuration: Int(match.4)!
            )
        }
    }
}
