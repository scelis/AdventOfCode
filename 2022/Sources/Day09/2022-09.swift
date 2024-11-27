import AdventKit
import Foundation

private extension Coordinate2D {
    func movingToward(other: Coordinate2D) -> Coordinate2D {
        guard abs(x - other.x) > 1 || abs(y - other.y) > 1 else {
            return self
        }

        return Coordinate2D(
            x: x + (other.x - x).signum(),
            y: y + (other.y - y).signum()
        )
    }
}

struct Day09: Day {
    func parseCommands() -> [(Direction, Int)] {
        return input().components(separatedBy: .newlines).map { line -> (Direction, Int) in
            let components = line.components(separatedBy: .whitespaces)
            return (Direction(rawValue: components[0])!, Int(components[1])!)
        }
    }

    func simulate(numKnots: Int, commands: [(Direction, Int)]) -> Int {
        var rope: [Coordinate2D] = .init(repeating: .zero, count: numKnots)
        var visited: Set<Coordinate2D> = [.zero]
        commands.forEach { (direction, steps) in
            for _ in 0..<steps {
                rope[0] = rope[0].step(inDirection: direction)
                for i in 1..<rope.count {
                    rope[i] = rope[i].movingToward(other: rope[i - 1])
                }
                visited.insert(rope.last!)
            }
        }

        return visited.count
    }

    func run() async throws -> (Int, Int) {
        let commands = parseCommands()
        async let p1 = part1(commands: commands)
        async let p2 = part2(commands: commands)
        return try await (p1, p2)
    }

    func part1(commands: [(Direction, Int)]) async throws -> Int {
        simulate(numKnots: 2, commands: commands)
    }

    func part2(commands: [(Direction, Int)]) async throws -> Int {
        simulate(numKnots: 10, commands: commands)
    }
}
