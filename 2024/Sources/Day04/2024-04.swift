import AdventKit
import Foundation

struct Day04: Day {
    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        let graph = inputCharacterArrays()
        var total = 0
        for y in graph.indices {
            for x in graph[y].indices {
                guard graph[y][x] == "X" else { continue }

                let coordinate = Coordinate2D(x: x, y: y)
                for direction in Direction.cardinalAndIntercardinalDirections {
                    if
                        graph[safe: coordinate.step(inDirection: direction, distance: 1)] == "M",
                        graph[safe: coordinate.step(inDirection: direction, distance: 2)] == "A",
                        graph[safe: coordinate.step(inDirection: direction, distance: 3)] == "S"
                    {
                        total += 1
                    }
                }
            }
        }

        return total
    }

    func part2() async throws -> Int {
        let graph = inputCharacterArrays()
        var total = 0
        for y in graph.indices {
            for x in graph[y].indices {
                guard graph[y][x] == "A" else { continue }

                let coordinate = Coordinate2D(x: x, y: y)
                let cornerCounts: [Character: Int] = Direction.intercardinalDirections.reduce(into: [:]) { partialResult, direction in
                    if let character = graph[safe: coordinate.step(inDirection: direction)] {
                        partialResult[character, default: 0] += 1
                    }
                }

                if
                    cornerCounts["M"] == 2,
                    cornerCounts["S"] == 2,
                    graph[coordinate.step(inDirection: .northWest)] != graph[coordinate.step(inDirection: .southEast)]
                {
                    total += 1
                }
            }
        }

        return total
    }
}
