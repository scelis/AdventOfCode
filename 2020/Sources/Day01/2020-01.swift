import AdventKit
import Foundation

public class Day01: Day<Int, Int> {
    public lazy var inputIntegers: [Int] = {
        return inputLines.map { Int($0)! }
    }()

    public override func part1() throws -> Int {
        for i in 0..<inputIntegers.count {
            for j in (i + 1)..<inputIntegers.count {
                if inputIntegers[i] + inputIntegers[j] == 2020 {
                    return inputIntegers[i] * inputIntegers[j]
                }
            }
        }
        fatalError()
    }

    public override func part2() throws -> Int {
        for i in 0..<inputIntegers.count {
            for j in (i + 1)..<inputIntegers.count {
                for k in (j + 1)..<inputIntegers.count {
                    if inputIntegers[i] + inputIntegers[j] + inputIntegers[k] == 2020 {
                        return inputIntegers[i] * inputIntegers[j] * inputIntegers[k]
                    }
                }
            }
        }
        fatalError()
    }
}
