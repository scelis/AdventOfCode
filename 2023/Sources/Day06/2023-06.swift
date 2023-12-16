import AdventKit
import Foundation

public struct Day06: Day {
    public func part1() async throws -> Int {
        return zip(times, distances)
            .map { numberOfSolutions(time: $0, distance: $1) }
            .reduce(1, *)
    }

    public func part2() async throws -> Int {
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

    // MARK: - Parsing

    var times: [Int] {
        inputLines()[0].components(separatedBy: .whitespaces).compactMap(Int.init)
    }

    var distances: [Int] {
        inputLines()[1].components(separatedBy: .whitespaces).compactMap(Int.init)
    }
}
