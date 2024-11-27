import AdventKit
import Foundation

struct Day06: Day {
    func run() async throws -> (Int, Int) {
        let lines = inputLines()
        let times = lines[0].components(separatedBy: .whitespaces).compactMap(Int.init)
        let distances = lines[1].components(separatedBy: .whitespaces).compactMap(Int.init)

        async let p1 = part1(times: times, distances: distances)
        async let p2 = part2(times: times, distances: distances)
        return try await (p1, p2)
    }

    func part1(times: [Int], distances: [Int]) async throws -> Int {
        return zip(times, distances)
            .map { numberOfSolutions(time: $0, distance: $1) }
            .reduce(1, *)
    }

    func part2(times: [Int], distances: [Int]) async throws -> Int {
        let time = Int(times.map { String($0) }.joined())!
        let distance = Int(distances.map { String($0) }.joined())!
        return numberOfSolutions(time: time, distance: distance)
    }

    func numberOfSolutions(time: Int, distance: Int) -> Int {
        let times = solveQuadraticEquation(a: -1, b: Double(time), c: -Double(distance))
        return Int(floor(times.1)) - Int(ceil(times.0)) + 1
    }

    func solveQuadraticEquation(a: Double, b: Double, c: Double) -> (Double, Double) {
        let discriminant = sqrt(b * b - 4 * a * c)
        return ((-b + discriminant) / (2 * a), (-b - discriminant) / (2 * a))
    }
}
