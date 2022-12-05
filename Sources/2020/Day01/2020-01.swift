import AdventKit
import Foundation

class Day01: Day {
    override func part1() -> Any {
        for i in 0..<inputIntegers.count {
            for j in (i + 1)..<inputIntegers.count {
                if inputIntegers[i] + inputIntegers[j] == 2020 {
                    return "\(inputIntegers[i] * inputIntegers[j])"
                }
            }
        }
        return ""
    }

    override func part2() -> Any {
        for i in 0..<inputIntegers.count {
            for j in (i + 1)..<inputIntegers.count {
                for k in (j + 1)..<inputIntegers.count {
                    if inputIntegers[i] + inputIntegers[j] + inputIntegers[k] == 2020 {
                        return "\(inputIntegers[i] * inputIntegers[j] * inputIntegers[k])"
                    }
                }
            }
        }
        return ""
    }
}
