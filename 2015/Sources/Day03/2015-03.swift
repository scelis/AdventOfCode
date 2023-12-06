import AdventKit
import Algorithms
import Foundation

public class Day03: Day<Int, Int> {
    public override func part1() throws -> Int {
        var current = Coordinate2D.zero
        return directions.reduce(into: Set<Coordinate2D>([current])) { partialResult, direction in
            current = current.step(inDirection: direction)
            partialResult.insert(current)
        }.count
    }

    public override func part2() throws -> Int {
        var locations = [Coordinate2D.zero, Coordinate2D.zero]
        return directions
            .chunks(ofCount: 2)
            .reduce(into: Set<Coordinate2D>([.zero])) { partialResult, chunk in
                for (index, direction) in chunk.enumerated() {
                    locations[index] = locations[index].step(inDirection: direction)
                    partialResult.insert(locations[index])
                }
            }
            .count
    }

    lazy var directions: [Direction] = input.compactMap { character in
        switch character {
        case "^": return .north
        case "v": return .south
        case ">": return .east
        case "<": return .west
        default: return nil
        }
    }
}
