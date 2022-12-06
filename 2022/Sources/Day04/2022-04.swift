import AdventKit
import Foundation
import Parsing

public class Day04: Day<Int, Int> {
    lazy var pairs: [(ClosedRange<Int>, ClosedRange<Int>)] = {
        let rangeParser = Parse(with: { Int.parser(); "-"; Int.parser() }).map { $0...$1 }
        let pairParser = Parse(with: { rangeParser; ","; rangeParser }).map { ($0, $1) }
        return input.components(separatedBy: .newlines).map { try! pairParser.parse($0) }
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
