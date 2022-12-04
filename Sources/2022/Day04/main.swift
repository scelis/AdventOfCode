import AdventKit
import Foundation

class Day04: Day {
    override func part1() -> String {
        return pairs.filter { pair in
            return pair[0].contains(pair[1]) || pair[1].contains(pair[0])
        }
        .count
        .description
    }

    override func part2() -> String {
        return pairs.filter { pair in
            return pair[0].overlaps(pair[1])
        }
        .count
        .description
    }

    lazy var pairs: [[ClosedRange<Int>]] = {
        return inputLines
            .map { line in
                return line
                    .components(separatedBy: ",")
                    .map { rangeString in
                        return rangeString
                            .components(separatedBy: "-")
                            .map { Int($0)! }
                    }
                    .map { ($0[0]...$0[1]) }
            }
    }()
}

Day04().run()
