import AdventKit
import Foundation

struct Day10: Day {
    struct Machine {
        var lights: [Bool]
        var schematics: [Set<Int>]
        var joltages: [Int]
    }

    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        parseMachines()
            .map { minimumButtonPressesPart1(machine: $0) }
            .reduce(0, +)
    }

    func part2() async throws -> Int {
        0
    }

    func minimumButtonPressesPart1(machine: Machine) -> Int {
        let allOff: [Bool] = .init(repeating: false, count: machine.lights.count)
        var minimumPresses: [[Bool]: Int] = [allOff: 0]
        var toCheck: [[Bool]] = [allOff]
        var checked: Set<[Bool]> = []

        while minimumPresses[machine.lights] == nil {
            let current = toCheck.removeFirst()
            if !checked.contains(current) {
                let presses = minimumPresses[current]!
                for schematic in machine.schematics {
                    let newLights = current.enumerated().map { schematic.contains($0) ? !$1 : $1 }
                    if minimumPresses[newLights] == nil {
                        minimumPresses[newLights] = presses + 1
                        if !checked.contains(newLights) {
                            toCheck.append(newLights)
                        }
                    }
                }
                checked.insert(current)
            }
        }

        return minimumPresses[machine.lights]!
    }

    func parseMachines() -> [Machine] {
        let lightsRegex = #/\[([.#]+)\]/#
        let schematicsRegex = #/\(([0-9,]+)\)/#
        let joltagesRegex = #/\{([-0-9,]+)\}/#
        return inputLines().compactMap { line in
            let lightsMatch = line.firstMatch(of: lightsRegex)!
            let lights: [Bool] = lightsMatch.1.map { $0 == "#" }

            let joltagesMatch = line.firstMatch(of: joltagesRegex)!
            let joltages = joltagesMatch.1.components(separatedBy: ",").compactMap(Int.init)

            var schematics: [Set<Int>] = []
            for schematicsMatch in line.matches(of: schematicsRegex) {
                let numbers = schematicsMatch.1.components(separatedBy: ",").compactMap(Int.init)
                schematics.append(Set(numbers))
            }

            return Machine(lights: lights, schematics: schematics, joltages: joltages)
        }
    }
}
