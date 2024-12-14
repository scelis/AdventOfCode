import AdventKit
import Foundation

struct Day14: Day {
    struct Robot {
        var position: Coordinate2D
        var velocity: Coordinate2D
    }

    func run() async throws -> (Int, Int) {
        let robots = parseInput()
        async let p1 = part1(robots: robots, width: 101, height: 103, seconds: 100)
        async let p2 = part2(robots: robots, width: 101, height: 103)
        return try await (p1, p2)
    }

    func part1(robots: [Robot], width: Int, height: Int, seconds: Int) async throws -> Int {
        let robots = simulate(robots: robots, width: width, height: height, seconds: seconds)
        return safetyFactor(robots: robots, width: width, height: height)
    }

    func part2(robots: [Robot], width: Int, height: Int) async throws -> Int {
        var i = 0
        var robots = robots
        while !isEasterEggDetected(robots: robots, width: width, height: height) {
            robots = simulate(robots: robots, width: width, height: height, seconds: 1)
            i += 1
        }
        return i
    }

    func simulate(robots: [Robot], width: Int, height: Int, seconds: Int) -> [Robot] {
        var robots = robots
        for _ in 0..<seconds {
            robots = robots.map { robot in
                var robot = robot
                robot.position.x = (robot.position.x + robot.velocity.x + width) % width
                robot.position.y = (robot.position.y + robot.velocity.y + height) % height
                return robot
            }
        }
        return robots
    }

    func safetyFactor(robots: [Robot], width: Int, height: Int) -> Int {
        var quadrantCounts = [0, 0, 0, 0]
        for robot in robots {
            if robot.position.x < width / 2 {
                if robot.position.y < height / 2 {
                    quadrantCounts[0] += 1
                } else if robot.position.y > height / 2 {
                    quadrantCounts[3] += 1
                }
            } else if robot.position.x > width / 2 {
                if robot.position.y < height / 2 {
                    quadrantCounts[1] += 1
                } else if robot.position.y > height / 2 {
                    quadrantCounts[2] += 1
                }
            }
        }
        return quadrantCounts.reduce(1, *)
    }

    func isEasterEggDetected(robots: [Robot], width: Int, height: Int) -> Bool {
        var coordinates: Set<Coordinate2D> = []
        robots.forEach { coordinates.insert($0.position) }

        return coordinates.filter { coordinate in
            Direction.cardinalAndIntercardinalDirections.allSatisfy { direction in
                coordinates.contains(coordinate.step(inDirection: direction))
            }
        }.count >= 10
    }

    func prettyPrint(robots: [Robot], width: Int, height: Int) {
        var grid = Array(repeating: Array(repeating: ".", count: width), count: height)
        for robot in robots {
            grid[robot.position.y][robot.position.x] = "#"
        }
        for row in grid {
            print(row.joined())
        }
        print("")
    }

    func parseInput() -> [Robot] {
        let regex = #/p=(-?\d+),(-?\d+) v=(-?\d+),(-?\d+)/#
        return input().matches(of: regex).map { match in
            Robot(
                position: Coordinate2D(x: Int(match.1)!, y: Int(match.2)!),
                velocity: Coordinate2D(x: Int(match.3)!, y: Int(match.4)!)
            )
        }
    }
}
