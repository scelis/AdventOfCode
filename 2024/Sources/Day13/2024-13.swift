import AdventKit
import Foundation

struct Day13: Day {
    struct Machine {
        var buttonA: Coordinate2D
        var buttonB: Coordinate2D
        var prize: Coordinate2D
    }

    func run() async throws -> (Int, Int) {
        let machines = parseInput()
        async let p1 = solve(machines: machines)
        async let p2 = solve(machines: machines, extraPrizeDistance: 10000000000000)
        return try await (p1, p2)
    }

    func solve(machines: [Machine], extraPrizeDistance: Int = 0) async throws -> Int {
        machines.compactMap { machine -> Coordinate2D? in
            solveEquations(
                a: machine.buttonA.x, b: machine.buttonB.x, c: machine.prize.x + extraPrizeDistance,
                d: machine.buttonA.y, e: machine.buttonB.y, f: machine.prize.y + extraPrizeDistance
            )
        }
        .reduce(0) { $0 + 3 * $1.x + $1.y }
    }

    // ax + by = c
    // dx + ey = f
    func solveEquations(a: Int, b: Int, c: Int, d: Int, e: Int, f: Int) -> (Coordinate2D)? {
        let determinant = a * e - b * d
        let x = Double(c * e - b * f) / Double(determinant)
        let y = Double(a * f - c * d) / Double(determinant)
        if x.isWholeNumber && y.isWholeNumber {
            return Coordinate2D(x: Int(x), y: Int(y))
        } else {
            return nil
        }
    }

    // MARK: Parsing

    func parseInput() -> [Machine] {
        let buttonARegex = #/Button A: X\+(\d+), Y\+(\d+)/#
        let buttonBRegex = #/Button B: X\+(\d+), Y\+(\d+)/#
        let prizeRegex = #/Prize: X=(\d+), Y=(\d+)/#
        return input().components(separatedBy: "\n\n").map { str in
            let buttonAMatch = str.firstMatch(of: buttonARegex)!
            let buttonBMatch = str.firstMatch(of: buttonBRegex)!
            let prizeMatch = str.firstMatch(of: prizeRegex)!
            return Machine(
                buttonA: Coordinate2D(x: Int(buttonAMatch.1)!, y: Int(buttonAMatch.2)!),
                buttonB: Coordinate2D(x: Int(buttonBMatch.1)!, y: Int(buttonBMatch.2)!),
                prize: Coordinate2D(x: Int(prizeMatch.1)!, y: Int(prizeMatch.2)!)
            )
        }
    }
}
