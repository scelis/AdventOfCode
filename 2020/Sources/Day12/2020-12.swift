import AdventKit2
import Foundation

struct Day12: Day {
    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        var location = Coordinate2D(x: 0, y: 0)
        var direction = Direction.east
        inputLines().forEach { line in
            let number = Int(line.dropFirst())!
            switch line.first! {
            case "N": location = location.step(inDirection: .north, distance: number)
            case "S": location = location.step(inDirection: .south, distance: number)
            case "E": location = location.step(inDirection: .east, distance: number)
            case "W": location = location.step(inDirection: .west, distance: number)
            case "L": direction = direction.turnLeft(degrees: number)
            case "R": direction = direction.turnRight(degrees: number)
            case "F": location = location.step(inDirection: direction, distance: number)
            default: assertionFailure()
            }
        }

        return location.manhattanDistance(from: .init(x: 0, y: 0))
    }

    func part2() async throws -> Int {
        let origin = Coordinate2D(x: 0, y: 0)
        var ship = origin
        var waypoint = origin
            .step(inDirection: .east, distance: 10)
            .step(inDirection: .north, distance: 1)

        inputLines().forEach { line in
            let number = Int(line.dropFirst())!
            switch line.first! {
            case "N": waypoint = waypoint.step(inDirection: .north, distance: number)
            case "S": waypoint = waypoint.step(inDirection: .south, distance: number)
            case "E": waypoint = waypoint.step(inDirection: .east, distance: number)
            case "W": waypoint = waypoint.step(inDirection: .west, distance: number)
            case "F":
                for _ in 0..<number {
                    ship.x += waypoint.x
                    ship.y += waypoint.y
                }
            case "L":
                waypoint = waypoint.rotate(around: origin, degrees: 360 - number)
            case "R":
                waypoint = waypoint.rotate(around: origin, degrees: number)
            default: assertionFailure()
            }
        }

        return ship.manhattanDistance(from: origin)
    }
}
