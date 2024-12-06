import AdventKit
import Foundation

struct Day06: Day {

    // MARK: Types

    enum Error: Swift.Error {
        case guardNotFound
        case stuckInLoop
    }

    struct TileHistory {
        var allDirections: Set<Direction>
        let firstDirection: Direction

        init(direction: Direction) {
            self.allDirections = [direction]
            self.firstDirection = direction
        }
    }

    // MARK: Solving

    func run() async throws -> (Int, Int) {
        let graph = inputCharacterArrays()
        let location = try findGuard(graph: graph)
        let visitedLocations = try patrol(graph: graph, location: location, direction: .up)
        let part1Answer = visitedLocations.count
        let part2Answer = await part2(graph: graph, visitedLocations: visitedLocations)
        return (part1Answer, part2Answer)
    }

    func findGuard(graph: [[Character]]) throws -> Coordinate2D {
        for y in graph.indices {
            for x in graph[y].indices {
                if graph[y][x] == "^" {
                    return Coordinate2D(x: x, y: y)
                }
            }
        }

        throw Error.guardNotFound
    }

    func patrol(
        graph: [[Character]],
        location: Coordinate2D,
        direction: Direction
    ) throws -> [Coordinate2D: TileHistory] {
        var location = location
        var direction = direction
        var visited: [Coordinate2D: TileHistory] = [location: TileHistory(direction: direction)]

        while graph[safe: location] != nil {
            let nextLocation = location.step(inDirection: direction)
            if graph[safe: nextLocation] == "#" {
                direction = direction.turnRight()
            } else if visited[nextLocation]?.allDirections.contains(direction) == true {
                throw Error.stuckInLoop
            } else {
                location = nextLocation
                visited[nextLocation, default: TileHistory(direction: direction)].allDirections.insert(direction)
            }
        }

        visited[location] = nil
        return visited
    }

    func part2(graph: [[Character]], visitedLocations: [Coordinate2D: TileHistory]) async -> Int {
        var numPositions = 0

        await withTaskGroup(of: Int.self) { group in
            for (coordinate, tileHistory) in visitedLocations where graph[coordinate] == "." {
                group.addTask {
                    do {
                        var updatedGraph = graph
                        updatedGraph[coordinate.y][coordinate.x] = "#"
                        let direction = tileHistory.firstDirection
                        let location = coordinate.step(inDirection: direction.turnAround())
                        _ = try patrol(graph: updatedGraph, location: location, direction: direction)
                        return 0
                    } catch {
                        return 1
                    }
                }
            }

            for await number in group {
                numPositions += number
            }
        }

        return numPositions
    }
}
