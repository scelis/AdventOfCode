import AdventKit
import Foundation

struct Day20: Day {
    func run() async throws -> (Int, Int) {
        let (map, _, end) = parseInput()
        let distances = explore(map: map, from: end)
        async let p1 = part1(map: map, distances: distances)
        async let p2 = part2(map: map, distances: distances)
        return try await (p1, p2)
    }

    func part1(map: [[Character]], distances: [Coordinate2D: Int]) async throws -> Int {
        numberOfCheats(map: map, distances: distances, saving: 100, cheatLength: 2)
    }

    func part2(map: [[Character]], distances: [Coordinate2D: Int]) async throws -> Int {
        numberOfCheats(map: map, distances: distances, saving: 100, cheatLength: 20)
    }

    func explore(map: [[Character]], from coordinate: Coordinate2D) -> [Coordinate2D: Int] {
        var distances: [Coordinate2D: Int] = [coordinate: 0]
        var visited: Set<Coordinate2D> = []
        var queue = [coordinate]
        while !queue.isEmpty {
            let current = queue.removeFirst()
            let distance = distances[current]!
            visited.insert(current)

            for neighbor in current.neighboringCoordinates() where !visited.contains(neighbor) {
                if let tile = map[safe: neighbor], tile != "#" {
                    distances[neighbor] = distance + 1
                    queue.append(neighbor)
                }
            }
        }
        return distances
    }

    func numberOfCheats(
        map: [[Character]],
        distances: [Coordinate2D: Int],
        saving: Int,
        cheatLength: Int
    ) -> Int {
        var count = 0
        for (coordinate, distance) in distances {
            for dx in 0...cheatLength {
                for dy in (-cheatLength + dx)...(cheatLength - dx) {
                    if dx == 0 && dy <= 0 { continue }
                    if
                        case let exit = Coordinate2D(x: coordinate.x + dx, y: coordinate.y + dy),
                        let exitDistance = distances[exit],
                        abs(distance - exitDistance) - (dx + abs(dy)) >= saving
                    {
                        count += 1
                    }
                }
            }
        }
        return count
    }

    func parseInput() -> (map: [[Character]], start: Coordinate2D, end: Coordinate2D) {
        let map = inputCharacterArrays()
        var start: Coordinate2D?
        var end: Coordinate2D?
        for y in map.indices {
            for x in map[y].indices {
                switch map[y][x] {
                case "S": start = Coordinate2D(x: x, y: y)
                case "E": end = Coordinate2D(x: x, y: y)
                default: break
                }
            }
        }
        return (map, start!, end!)
    }
}
