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
        let (location, direction) = try findGuard(graph: graph)

        let visitedLocations = try patrol(graph: graph, location: location, direction: direction)
        let part1Answer = visitedLocations.count

        let part2Answer = part2(
            graph: graph,
            location: location,
            direction: direction,
            visitedLocations: visitedLocations
        )

        return (part1Answer, part2Answer)
    }

    func findGuard(graph: [[Character]]) throws -> (Coordinate2D, Direction) {
        for y in graph.indices {
            for x in graph[y].indices {
                if graph[y][x] == "^" {
                    return (Coordinate2D(x: x, y: y), .up)
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

    func part2(
        graph: [[Character]],
        location: Coordinate2D,
        direction: Direction,
        visitedLocations: [Coordinate2D: TileHistory]
    ) -> Int {
        var numPositions = 0

        for y in graph.indices {
            for x in graph[y].indices {
                guard
                    graph[y][x] == ".",
                    case let coordinate = Coordinate2D(x: x, y: y),
                    let tileHistory = visitedLocations[coordinate]
                else {
                    continue
                }

                do {
                    var updatedGraph = graph
                    updatedGraph[y][x] = "#"
                    let direction = tileHistory.firstDirection
                    let location = coordinate.step(inDirection: direction.turnAround())
                    _ = try patrol(graph: updatedGraph, location: location, direction: direction)
                } catch {
                    numPositions += 1
                }
            }
        }

        return numPositions
    }
}
