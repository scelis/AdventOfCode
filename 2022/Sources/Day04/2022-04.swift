import AdventKit
import Foundation

public class Day04: Day<Int, Int> {
    lazy var pairs: [(ClosedRange<Int>, ClosedRange<Int>)] = {
        return inputLines.map { line in
            let rangeStrings = line.components(separatedBy: ",")
            let ranges = rangeStrings.map { rangeString in
                let components = rangeString.components(separatedBy: "-")
                return Int(components[0])!...Int(components[1])!
            }
            return (ranges[0], ranges[1])
        }
    }()

    public override func part1() throws -> Int {
        return pairs.filter { pair in
            return pair.0.contains(pair.1) || pair.1.contains(pair.0)
        }
        .count
    }

    public override func part2() throws -> Int {
        return pairs.filter { pair in
            return pair.0.overlaps(pair.1)
        }
        .count
    }
}
