import AdventKit
import Foundation

struct Day18: Day {
    enum Error: Swift.Error {
        case pathNotFound
    }

    func run() async throws -> (Int, String) {
        let coordinates = parseInput()
        var corrupted: Set<Coordinate2D> = coordinates.prefix(1024).reduce(into: []) { $0.insert($1) }
        var path = try findShortestPath(corruptedCoordinates: corrupted)
        let part1 = path.count

        var i = 1024
        var part2Coordinate: Coordinate2D?
        while part2Coordinate == nil {
            while corrupted.intersection(path).isEmpty {
                corrupted.insert(coordinates[i])
                i += 1
            }

            do {
                path = try findShortestPath(corruptedCoordinates: corrupted)
            } catch {
                part2Coordinate = coordinates[i - 1]
            }
        }

        return (part1, "\(part2Coordinate!.x),\(part2Coordinate!.y)")
    }

    func findShortestPath(
        range: ClosedRange<Int> = 0...70,
        corruptedCoordinates: Set<Coordinate2D>
    ) throws -> Set<Coordinate2D> {
        var queue: [Coordinate2D] = [.zero]
        var visited: Set<Coordinate2D> = []
        var map: [Coordinate2D: Set<Coordinate2D>] = [.zero: []]
        while !queue.isEmpty {
            let coordinate = queue.removeFirst()
            guard !visited.contains(coordinate) else { continue }
            let pathSet = map[coordinate]!
            visited.insert(coordinate)

            for neighbor in coordinate.neighboringCoordinates() {
                if
                    range.contains(neighbor.x),
                    range.contains(neighbor.y),
                    !corruptedCoordinates.contains(neighbor),
                    map[neighbor]?.count ?? Int.max > pathSet.count + 1
                {
                    if neighbor.x == range.upperBound && neighbor.y == range.upperBound {
                        return pathSet.union([neighbor])
                    } else {
                        map[neighbor] = pathSet.union([neighbor])
                        queue.append(neighbor)
                    }
                }
            }
        }

        throw Error.pathNotFound
    }

    func parseInput() -> [Coordinate2D] {
        inputLines().map { line in
            let parts = line.components(separatedBy: ",")
            return Coordinate2D(x: Int(parts[0])!, y: Int(parts[1])!)
        }
    }
}
