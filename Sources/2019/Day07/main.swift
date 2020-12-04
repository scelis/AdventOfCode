import AdventKit
import Foundation
import IntcodeComputer

class Day07: Day {
    override func part1() -> String {
        var maxSignal = Int.min
        for a in 0...4 {
            for b in 0...4 {
                for c in 0...4 {
                    for d in 0...4 {
                        for e in 0...4 {
                            let set: Set<Int> = [a, b, c, d, e]
                            if set.count == 5 {
                                let computerA = IntcodeComputer(input: inputString)
                                computerA.run(input: [a, 0])
                                let computerB = IntcodeComputer(input: inputString)
                                computerB.run(input: [b, computerA.readInt()!])
                                let computerC = IntcodeComputer(input: inputString)
                                computerC.run(input: [c, computerB.readInt()!])
                                let computerD = IntcodeComputer(input: inputString)
                                computerD.run(input: [d, computerC.readInt()!])
                                let computerE = IntcodeComputer(input: inputString)
                                computerE.run(input: [e, computerD.readInt()!])
                                maxSignal = max(maxSignal, computerE.readInt()!)
                            }
                        }
                    }
                }
            }
        }

        return "\(maxSignal)"
    }

    override func part2() -> String {
        var maxSignal = Int.min
        for a in 5...9 {
            for b in 5...9 {
                for c in 5...9 {
                    for d in 5...9 {
                        for e in 5...9 {
                            let set: Set<Int> = [a, b, c, d, e]
                            if set.count == 5 {
                                var computers: [IntcodeComputer] = []
                                for _ in 0...4 {
                                    computers.append(IntcodeComputer(input: inputString))
                                }

                                computers[0].run(input: [a, 0])
                                computers[1].run(input: [b])
                                computers[2].run(input: [c])
                                computers[3].run(input: [d])
                                computers[4].run(input: [e])

                                while computers.last!.state != .halted {
                                    for (index, computer) in computers.enumerated() {
                                        let previousIndex = (index > 0) ? index - 1 : 4
                                        let previousComputer = computers[previousIndex]
                                        if
                                            computer.state == .awaitingInput,
                                            let output = previousComputer.readInt()
                                        {
                                            computer.run(input: [output])
                                        }
                                    }
                                }
                                maxSignal = max(maxSignal, computers.last!.readInt()!)
                            }
                        }
                    }
                }
            }
        }

        return "\(maxSignal)"
    }
}

Day07().run()
