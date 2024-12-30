import AdventKit
import Foundation

struct Day20: Day {
    enum Pulse: Equatable, Hashable, Sendable {
        case low
        case high
    }

    enum Module: Equatable, Hashable, Sendable {
        case broadcast(name: String, outputs: [String])
        case flipFlop(name: String, outputs: [String], on: Bool)
        case conjunction(name: String, outputs: [String], memory: [String: Pulse])

        var name: String {
            switch self {
            case .broadcast(let name, _), .flipFlop(let name, _, _), .conjunction(let name, _, _):
                return name
            }
        }

        var outputs: [String] {
            switch self {
            case .broadcast(_, let outputs), .flipFlop(_, let outputs, _), .conjunction(_, let outputs, _):
                return outputs
            }
        }
    }

    struct PressResult {
        var modules: [String: Module]
        var pulses: [String: [Pulse: Int]]
        var totalPulses: [Pulse: Int]
    }

    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        var modules = parseInput()
        var totalPulses: [Pulse: Int] = [:]
        for _ in 0..<1000 {
            let result = pressButton(modules: modules)
            totalPulses[.low, default: 0] += result.totalPulses[.low, default: 0]
            totalPulses[.high, default: 0] += result.totalPulses[.high, default: 0]
            modules = result.modules
        }
        return totalPulses[.low, default: 0] * totalPulses[.high, default: 0]
    }

    func part2() async throws -> Int {
        var modules = parseInput()
        let rxInput: String = modules.first(where: { $0.value.outputs.contains("rx") })!.value.name
        let rxInputInputs = modules
            .values
            .filter { $0.outputs.contains(rxInput) }
            .map { $0.name }
        var cycles: [String: Int] = [:]
        var i = 0
        while cycles.count < rxInputInputs.count {
            let result = pressButton(modules: modules)
            modules = result.modules
            i += 1
            for input in rxInputInputs where cycles[input] == nil {
                if result.pulses[input]?[.low] == 1 {
                    cycles[input] = i
                }
            }
        }
        return Array(cycles.values).leastCommonMultiple
    }

    func pressButton(modules: [String: Module]) -> PressResult {
        var modules = modules
        var pulses: [String: [Pulse: Int]] = [:]
        var totalPulses: [Pulse: Int] = [:]
        var queue: [(from: String, to: String, pulse: Pulse)] = [("button", "broadcaster", .low)]
        while !queue.isEmpty {
            let (from, to, pulse) = queue.removeFirst()
            totalPulses[pulse, default: 0] += 1
            pulses[to, default: [:]][pulse, default: 0] += 1

            let module = modules[to]
            switch module {
            case .broadcast(_, let outputs):
                for output in outputs {
                    queue.append((to, output, pulse))
                }
            case .flipFlop(let name, let outputs, var on):
                guard pulse == .low else { continue }
                on.toggle()
                let nextPulse: Pulse = on ? .high : .low
                for output in outputs {
                    queue.append((to, output, nextPulse))
                }
                modules[name] = .flipFlop(name: name, outputs: outputs, on: on)
            case .conjunction(let name, let outputs, var memory):
                memory[from] = pulse
                let nextPulse: Pulse = memory.values.allSatisfy({ $0 == .high }) ? .low : .high
                for output in outputs {
                    queue.append((to, output, nextPulse))
                }
                modules[name] = .conjunction(name: name, outputs: outputs, memory: memory)
            case nil:
                break
            }
        }

        return PressResult(modules: modules, pulses: pulses, totalPulses: totalPulses)
    }

    func parseInput() -> [String: Module] {
        var modules: [String: Module] = [:]
        inputLines().forEach { line in
            let components = line.components(separatedBy: " -> ")
            let outputs = components[1].components(separatedBy: ", ")
            switch components[0].first {
            case "%":
                let name = String(components[0].dropFirst())
                modules[name] = .flipFlop(name: name, outputs: outputs, on: false)
            case "&":
                let name = String(components[0].dropFirst())
                modules[name] = .conjunction(name: name, outputs: outputs, memory: [:])
            default:
                let name = components[0]
                modules[name] = .broadcast(name: name, outputs: outputs)
            }
        }

        var inputs: [String: Set<String>] = [:]
        for (name, module) in modules {
            for output in module.outputs {
                inputs[output, default: []].insert(name)
            }
        }

        return modules.mapValues { module in
            switch module {
            case .broadcast: return module
            case .flipFlop: return module
            case .conjunction(let name, let outputs, _):
                var memory: [String: Pulse] = [:]
                for input in inputs[name]! {
                    memory[input] = .low
                }
                return .conjunction(name: name, outputs: outputs, memory: memory)
            }
        }
    }
}
