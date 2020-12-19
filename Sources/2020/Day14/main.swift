import AdventKit
import Foundation

class Day14: Day {
    let maskRegex = try! NSRegularExpression(pattern: #"mask = ([1X0]+)"#, options: [])
    let writeRegex = try! NSRegularExpression(pattern: #"mem\[([0-9]+)\] = ([0-9]+)"#, options: [])

    override func part1() -> String {
        var ones: Int64 = 0
        var zeroes: Int64 = 0
        var memory: [Int64: Int64] = [:]

        for line in inputLines {
            if let match = try! line.firstMatch(withRegularExpression: maskRegex) {
                for character in match[1] {
                    ones = ones << 1
                    zeroes = zeroes << 1
                    switch character {
                    case "1": ones = ones | 1
                    case "0": zeroes = zeroes | 1
                    default: break
                    }
                }
                zeroes = ~zeroes
            } else if let match = try! line.firstMatch(withRegularExpression: writeRegex) {
                var value = Int64(match[2])!
                value = value | ones
                value = value & zeroes
                memory[Int64(match[1])!] = value
            }
        }

        return memory
            .values
            .reduce(0, +)
            .description
    }

    override func part2() -> String {
        var mask = ""
        var memory: [Int64: Int64] = [:]
        for line in inputLines {
            if let match = try! line.firstMatch(withRegularExpression: maskRegex) {
                mask = match[1]
            } else if let match = try! line.firstMatch(withRegularExpression: writeRegex) {
                let address = Int64(match[1])!
                let value = Int64(match[2])!

                var workingAddress = address
                var addressString = ""
                for i in (0...35).reversed() {
                    let number = pow(2, i)
                    if workingAddress >= number {
                        addressString += "1"
                        workingAddress -= Int64(number)
                    } else {
                        addressString += "0"
                    }
                }

                let maskedAddress = zip(mask, addressString).map({ (charM, charA) -> Character in
                    switch charM {
                    case "0": return charA
                    case "1": return "1"
                    case "X": return "X"
                    default: fatalError()
                    }
                })

                write(value: value, toAddress: maskedAddress, memory: &memory)
            }
        }

        return memory
            .values
            .reduce(0, +)
            .description
    }

    func write(value: Int64, toAddress address: [Character], memory: inout [Int64: Int64]) {
        if let index = address.firstIndex(of: "X") {
            var a = address
            var b = address
            a[index] = "0"
            b[index] = "1"
            write(value: value, toAddress: a, memory: &memory)
            write(value: value, toAddress: b, memory: &memory)
        } else {
            var binary: Int64 = 0
            for character in address {
                binary = binary << 1
                binary = binary + (character == "1" ? 1 : 0)
            }
            memory[binary] = value
        }
    }
}

let example1 = """
mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
mem[8] = 11
mem[7] = 101
mem[8] = 0
"""

assert(Day14(input: example1).part1() == "165")

let example2 = """
mask = 000000000000000000000000000000X1001X
mem[42] = 100
mask = 00000000000000000000000000000000X0XX
mem[26] = 1
"""

assert(Day14(input: example2).part2() == "208")

Day14().run()
