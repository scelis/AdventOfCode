import AdventKit
import Foundation
import Parsing

class Day04: Day {
    lazy var pairs: [(ClosedRange<Int>, ClosedRange<Int>)] = {
        let rangeParser = Parse(with: { Int.parser(); "-"; Int.parser() }).map { $0...$1 }
        let pairParser = Parse(with: { rangeParser; ","; rangeParser }).map { ($0, $1) }
        return inputLines.map { try! pairParser.parse($0) }
    }()

    override func part1() -> Any {
        return pairs.filter { pair in
            return pair.0.contains(pair.1) || pair.1.contains(pair.0)
        }
        .count
    }

    override func part2() -> Any {
        return pairs.filter { pair in
            return pair.0.overlaps(pair.1)
        }
        .count
    }
}

Day04().run()
