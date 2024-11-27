import AdventKit2
import Foundation

struct Day13: Day {
    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        let lines = inputLines()
        let timestamp = Int(lines[0])!
        let buses = lines[1]
            .components(separatedBy: ",")
            .compactMap({ Int($0) })

        var bestBus = Int.max
        var bestTimeToWait = Int.max
        for bus in buses {
            let timeToWait = (bus - (timestamp % bus)) % bus
            if timeToWait < bestTimeToWait {
                bestTimeToWait = timeToWait
                bestBus = bus
            }
        }

        return bestBus * bestTimeToWait
    }

    func printFunctions() {
        inputLines()[1]
            .components(separatedBy: ",")
            .enumerated()
            .forEach { index, element in
                if let integer = Int(element) {
                    print("(T + \(index)) % \(integer) == 0")
                }
            }
    }

    func part2() async throws -> Int {
        // (T + 0) % 13   == 0 == (T + 13) % 13
        // (T + 3) % 41   == 0 == (T + 44) % 41
        // (T + 13) % 997 == 0 == (T + 13) % 997
        // (T + 21) % 23  == 0 == (T + 44) % 23
        // (T + 32) % 19  == 0 == (T + 13) % 19
        // (T + 42) % 29  == 0 == (T + 13) % 29
        // (T + 44) % 619 == 0 == (T + 44) % 619
        // (T + 50) % 37  == 0 == (T + 13) % 37
        // (T + 61) % 17  == 0 == (T + 44) % 17
        //
        // (T + 44) % (41 * 23 * 619 * 17) == 0
        // (T + 13) % (13 * 997 * 19 * 29 * 37) == 0
        //
        // (T + 44) % (9_923_189) == 0
        // (T + 13) % (264_235_907) == 0

        let increment = 264_235_907
        var current = increment
        while true {
            if (current + (44 - 13)) % 9_923_189 == 0 {
                return current - 13
            }
            current += increment
        }
    }
}
