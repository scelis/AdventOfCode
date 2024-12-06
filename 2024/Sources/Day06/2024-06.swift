import AdventKit
import Foundation

struct Day06: Day {

    // MARK: Types

    enum Error: Swift.Error {
        case guardNotFound
        case stuckInLoop
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
    ) throws -> [Coordinate2D: Set<Direction>] {
        var location = location
        var direction = direction
        var visited: [Coordinate2D: Set<Direction>] = [location: [direction]]

        while graph[safe: location] != nil {
            let nextLocation = location.step(inDirection: direction)
            if graph[safe: nextLocation] == "#" {
                direction = direction.turnRight()
            } else if visited[nextLocation, default: []].contains(direction) {
                throw Error.stuckInLoop
            } else {
                location = nextLocation
                visited[nextLocation, default: []].insert(direction)
            }
        }

        visited[location] = nil

        return visited
    }

    func part2(
        graph: [[Character]],
        location: Coordinate2D,
        direction: Direction,
        visitedLocations: [Coordinate2D: Set<Direction>]
    ) -> Int {
        var numPositions = 0

        for y in graph.indices {
            for x in graph[y].indices {
                guard
                    graph[y][x] == ".",
                    visitedLocations[Coordinate2D(x: x, y: y)] != nil
                else {
                    continue
                }

                do {
                    var updatedGraph = graph
                    updatedGraph[y][x] = "#"
                    _ = try patrol(graph: updatedGraph, location: location, direction: direction)
                } catch {
                    numPositions += 1
                }
            }
        }

        return numPositions
    }
}
