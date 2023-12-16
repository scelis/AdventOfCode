import AdventKit
import Foundation

public struct Day05: Day {
    func seatID(for pass: String) -> Int {
        var low = 0
        var high = 128
        var left = 0
        var right = 8

        for character in pass {
            switch character {
            case "F":
                high = high - ((high - low) / 2)
            case "B":
                low = low + ((high - low + 1) / 2)
            case "L":
                right = right - ((right - left) / 2)
            case "R":
                left = left + ((right - left + 1) / 2)
            default:
                break
            }
        }

        return low * 8 + left
    }

    public func part1() async throws -> Int {
        return inputLines()
            .map({ seatID(for: $0) })
            .reduce(0, max)
    }

    public func part2() async throws -> Int {
        let ids = inputLines().map({ seatID(for: $0) })
        let set = Set<Int>(ids)
        for i in (set.min()! + 1)..<set.max()! {
            if !set.contains(i) {
                return i
            }
        }
        fatalError()
    }
}
