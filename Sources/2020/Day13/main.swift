import AdventKit
import Foundation

class Day13: Day {
    override func part1() -> Any {
        let timestamp = Int(inputLines[0])!
        let buses = inputLines[1]
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

        return (bestBus * bestTimeToWait).description
    }

    func printFunctions() {
        inputLines[1]
            .components(separatedBy: ",")
            .enumerated()
            .forEach { index, element in
                if let integer = Int(element) {
                    print("(T + \(index)) % \(integer) == 0")
                }
            }
    }

    override func part2() -> Any {
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
                return "\(current - 13)"
            }
            current += increment
        }
    }
}

Day13().run()
