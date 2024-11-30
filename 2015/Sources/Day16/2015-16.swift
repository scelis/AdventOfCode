import AdventKit
import Foundation

struct Day16: Day {

    // MARK: Structures

    struct Sue {
        var number: Int
        var properties: [String: Int]
    }

    let properties: [String: Int] = [
        "children": 3,
        "cats": 7,
        "samoyeds": 2,
        "pomeranians": 3,
        "akitas": 0,
        "vizslas": 0,
        "goldfish": 5,
        "trees": 3,
        "cars": 2,
        "perfumes": 1,
    ]

    // MARK: Solving

    func run() async throws -> (Int, Int) {
        let sues = parseSues()
        async let p1 = part1(sues: sues)
        async let p2 = part2(sues: sues)
        return try await (p1, p2)
    }

    func part1(sues: [Sue]) async throws -> Int {
        return sues.first { sue in
            for (property, value) in properties {
                if let sueValue = sue.properties[property], sueValue != value {
                    return false
                }
            }

            return true
        }!.number
    }

    func part2(sues: [Sue]) async throws -> Int {
        return sues.first { sue in
            for (property, value) in properties {
                if property == "cats" || property == "trees" {
                    if let sueValue = sue.properties[property], sueValue <= value {
                        return false
                    }
                } else if property == "pomeranians" || property == "goldfish" {
                    if let sueValue = sue.properties[property], sueValue >= value {
                        return false
                    }
                } else if let sueValue = sue.properties[property], sueValue != value {
                    return false
                }
            }

            return true
        }!.number
    }

    // MARK: Parsing

    func parseSues() -> [Sue] {
        let outerPattern = #/^Sue (\d+): (.+)$/#
        let innerPattern = #/(\w+): (\d+)/#

        return inputLines().map { line in
            let outerMatch = line.firstMatch(of: outerPattern)!
            let properties: [String: Int] = outerMatch.2.matches(of: innerPattern).reduce(into: [:]) { partialResult, result in
                partialResult[String(result.1)] = Int(result.2)!
            }
            return Sue(number: Int(outerMatch.1)!, properties: properties)
        }
    }
}
