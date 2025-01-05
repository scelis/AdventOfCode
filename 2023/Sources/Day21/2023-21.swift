import AdventKit
import Foundation

struct Day21: Day {
    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        let map = inputCharacterArrays()
        let start = find(character: "S", in: map)
        var current: Set<Coordinate2D> = [start]
        for _ in 1...64 {
            var next: Set<Coordinate2D> = []
            for coordinate in current {
                for neighbor in coordinate.neighboringCoordinates() {
                    if let tile = map[safe: neighbor], tile != "#" {
                        next.insert(neighbor)
                    }
                }
            }
            current = next
        }
        return current.count
    }

    func part2() async throws -> Int {
        2
    }

    func find(character: Character, in map: [[Character]]) -> Coordinate2D {
        for y in map.indices {
            for x in map[y].indices {
                if map[y][x] == character {
                    return Coordinate2D(x: x, y: y)
                }
            }
        }
        fatalError("Couldn't find \(character)")
    }
}
