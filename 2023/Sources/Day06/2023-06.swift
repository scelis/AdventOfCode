import AdventKit
import Foundation

public class Day06: Day<Int, Int> {
    public override func part1() throws -> Int {
        return zip(times, distances)
            .map { numberOfSolutions(time: $0, distance: $1) }
            .reduce(1, *)
    }

    public override func part2() throws -> Int {
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

    lazy var times: [Int] = inputLines[0].components(separatedBy: .whitespaces).compactMap(Int.init)
    lazy var distances: [Int] = inputLines[1].components(separatedBy: .whitespaces).compactMap(Int.init)
}
