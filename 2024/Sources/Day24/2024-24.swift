import AdventKit
import Foundation

struct Day24: Day {
    struct Gate: Equatable {
        enum GateType: String {
            case and = "AND"
            case or = "OR"
            case xor = "XOR"
        }

        var gateType: GateType
        var left: String
        var right: String
        var output: String
    }

    func run() async throws -> (Int, String) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        var (wires, gates) = parseInput()
        while !gates.isEmpty {
            gates = gates.filter { gate in
                if let left = wires[gate.left], let right = wires[gate.right] {
                    switch gate.gateType {
                    case .and: wires[gate.output] = left && right
                    case .or: wires[gate.output] = left || right
                    case .xor: wires[gate.output] = left != right
                    }
                    return false
                } else {
                    return true
                }
            }
        }

        var result = 0
        for i in (0...45).reversed() {
            let wire = wires["z" + String(format: "%02d", i)]!
            result = result << 1
            result += wire ? 1 : 0
        }

        return result
    }

    func part2() async throws -> String {
        // Used the code below to find places where gates didn't match up as expected. Then it was
        // relatively simple to manually inspect and find the two outputs that needed to be swapped.
        ["z06", "jmq", "z13", "gmh", "cbd", "z38", "qrh", "rqf"].sorted().joined(separator: ",")
    }

    func findOutputsToSwap(gates: [Gate]) {
        var previousZXOR: Gate?
        var previousNumber = "00"
        for i in 1...45 {
            let thisNumber = String(format: "%02d", i)

            if i == 1 {
                let xXORy = findGate(inputA: "x\(thisNumber)", inputB: "y\(thisNumber)", type: .xor, gates: gates)
                let xANDy = findGate(inputA: "x\(previousNumber)", inputB: "y\(previousNumber)", type: .and, gates: gates)
                let zXOR = findGate(inputA: xXORy!.output, inputB: xANDy!.output, type: .xor, gates: gates)
                previousZXOR = zXOR
            }

            if i > 1 {
                let xXORy = findGate(inputA: "x\(thisNumber)", inputB: "y\(thisNumber)", type: .xor, gates: gates)
                let xANDy = findGate(inputA: "x\(previousNumber)", inputB: "y\(previousNumber)", type: .and, gates: gates)
                let andGate = findGate(inputA: previousZXOR!.left, inputB: previousZXOR!.right, type: .and, gates: gates)
                let orGate = findGate(inputA: xANDy!.output, inputB: andGate!.output, type: .or, gates: gates)
                let zXOR = findGate(inputA: orGate!.output, inputB: xXORy!.output, type: .xor, gates: gates)
                if zXOR?.output != "z\(thisNumber)" {
                    fatalError("Something is not right")
                }
                previousZXOR = zXOR
            }

            previousNumber = thisNumber
        }

        fatalError("Couldn't find outputs to swap")
    }

    func findGate(inputA: String, inputB: String, type: Gate.GateType, gates: [Gate]) -> Gate? {
        gates.first { gate in
            gate.gateType == type && ((gate.left == inputA && gate.right == inputB) || (gate.left == inputB && gate.right == inputA))
        }
    }

    func parseInput() -> (wires: [String: Bool], gates: [Gate]) {
        let sections = input().components(separatedBy: "\n\n")
        let wires: [String: Bool] = sections[0].components(separatedBy: .newlines).reduce(into: [:]) { result, line in
            let parts = line.components(separatedBy: ": ")
            result[parts[0]] = (parts[1] == "1")
        }
        let gates: [Gate] = sections[1].components(separatedBy: .newlines).map { line in
            let parts = line.components(separatedBy: .whitespaces)
            return Gate(gateType: Gate.GateType(rawValue: parts[1])!, left: parts[0], right: parts[2], output: parts[4])
        }
        return (wires, gates)
    }
}