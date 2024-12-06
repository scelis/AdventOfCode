import AdventKit
import Foundation

struct Day06: Day {

    // MARK: Types

    enum Error: Swift.Error {
        case stuckInLoop
    }

    // MARK: Solving

    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        let graph = inputCharacterArrays()
        let (location, direction) = findGuard(graph: graph)
        return try patrol(graph: graph, location: location, direction: direction)
    }

    func part2() async throws -> Int {
        let graph = inputCharacterArrays()
        let (location, direction) = findGuard(graph: graph)
        var numPositions = 0

        for y in graph.indices {
            for x in graph[y].indices where graph[y][x] == "." {
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

    func patrol(graph: [[Character]], location: Coordinate2D, direction: Direction) throws -> Int {
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

        return visited.count - 1
    }

    func findGuard(graph: [[Character]]) -> (Coordinate2D, Direction) {
        for y in graph.indices {
            for x in graph[y].indices {
                switch graph[y][x] {
                case "^": return (Coordinate2D(x: x, y: y), .up)
                case "v": return (Coordinate2D(x: x, y: y), .down)
                case "<": return (Coordinate2D(x: x, y: y), .left)
                case ">": return (Coordinate2D(x: x, y: y), .right)
                default: break
                }
            }
        }
        fatalError("Could not find guard")
    }
}
