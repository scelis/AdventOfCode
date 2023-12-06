import AdventKit
import Foundation

public class Day06: Day<Int, Int> {
    public override func part1() throws -> Int {
        return zip(times, distances)
            .map { winningTimeRange(totalRaceTime: $0.0, currentRecord: $0.1).count }
            .reduce(1, *)
    }

    public override func part2() throws -> Int {
        let time = Int(times.map { String($0) }.joined())!
        let record = Int(distances.map { String($0) }.joined())!
        return winningTimeRange(totalRaceTime: time, currentRecord: record).count
    }

    func winningTimeRange(totalRaceTime: Int, currentRecord: Int) -> Range<Int> {
        let middle = totalRaceTime / 2
        let left = (1..<middle).binaryFirstIndex { i in
            return distanceTraveled(timeHoldingButton: i, totalTime: totalRaceTime) > currentRecord
        } ?? middle
        let right = (middle..<totalRaceTime).binaryLastIndex { i in
            return distanceTraveled(timeHoldingButton: i, totalTime: totalRaceTime) > currentRecord
        } ?? middle

        return left..<(right + 1)
    }

    func distanceTraveled(timeHoldingButton: Int, totalTime: Int) -> Int {
        return (totalTime - timeHoldingButton) * timeHoldingButton
    }

    // MARK: - Parsing

    lazy var times: [Int] = inputLines[0].components(separatedBy: .whitespaces).compactMap(Int.init)
    lazy var distances: [Int] = inputLines[1].components(separatedBy: .whitespaces).compactMap(Int.init)
}
