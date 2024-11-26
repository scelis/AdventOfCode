import AdventKit2
import Foundation

struct Day06: Day {
    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func makeRegex() -> Regex<(Substring, Substring, Substring, Substring, Substring, Substring)> {
        #/^(turn on|turn off|toggle) (\d+),(\d+) through (\d+),(\d+)/#
    }

    func part1() async throws -> Int {
        var set = IndexSet()
        let regex = makeRegex()

        inputLines().forEach { line in
            let match = line.firstMatch(of: regex)!
            let x1 = Int(match.2)!
            let y1 = Int(match.3)!
            let x2 = Int(match.4)!
            let y2 = Int(match.5)!

            var tempSet = IndexSet()
            for y in y1...y2 {
                tempSet.insert(integersIn: (1000 * y + x1)...(1000 * y + x2))
            }

            switch match.1 {
            case "turn on":
                set.formUnion(tempSet)
            case "turn off":
                set.subtract(tempSet)
            case "toggle":
                let currentlyOn = set.intersection(tempSet)
                let currentlyOff = set.symmetricDifference(tempSet)
                set.subtract(currentlyOn)
                set.formUnion(currentlyOff)
            default:
                fatalError("Unexpected command: \(match.1)")
            }
        }

        return set.count
    }

    func part2() async throws -> Int {
        var brightness: [Int] = .init(repeating: 0, count: 1_000_000)
        let regex = makeRegex()

        inputLines().forEach { line in
            let match = line.firstMatch(of: regex)!
            let x1 = Int(match.2)!
            let y1 = Int(match.3)!
            let x2 = Int(match.4)!
            let y2 = Int(match.5)!

            let diff: Int
            switch match.1 {
            case "turn on":
                diff = 1
            case "turn off":
                diff = -1
            case "toggle":
                diff = 2
            default:
                fatalError("Unexpected command: \(match.1)")
            }

            for y in y1...y2 {
                for x in x1...x2 {
                    brightness[1000 * y + x] = max(brightness[1000 * y + x] + diff, 0)
                }
            }
        }

        return brightness.reduce(0, +)
    }
}
