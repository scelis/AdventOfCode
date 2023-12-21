import AdventKit
import Foundation

public struct Day17: Day {

    // MARK: - Structures

    struct Pose: Equatable, Hashable {
        var coordinate: Coordinate2D
        var direction: Direction
    }

    // MARK: - Solving

    public func part1() async throws -> Int {
        solve(minimumStepsBeforeTurning: 1, maximumStepsBeforeTurning: 3)
    }

    public func part2() async throws -> Int {
        solve(minimumStepsBeforeTurning: 4, maximumStepsBeforeTurning: 10)
    }

    func solve(minimumStepsBeforeTurning: Int, maximumStepsBeforeTurning: Int) -> Int {
        let map = parseMap()
        let destination = Coordinate2D(x: map[0].count - 1, y: map.count - 1)
        var queue = [Pose(coordinate: .zero, direction: .east), Pose(coordinate: .zero, direction: .south)]
        var minimumHeatLoss: [Pose: Int] = [queue[0]: 0, queue[1]: 0]
        var bestSolution = Int.max

        while !queue.isEmpty {
            let pose = queue.removeFirst()
            let currentHeatLoss = minimumHeatLoss[pose]!

            if currentHeatLoss > bestSolution {
                return bestSolution
            }

            var updatedQueue = false
            var nextHeatLoss = currentHeatLoss
            for i in 1...maximumStepsBeforeTurning {
                let nextCoordinate = pose.coordinate.step(inDirection: pose.direction, distance: i)
                if let thisHeatLoss = map[safe: nextCoordinate.y]?[safe: nextCoordinate.x] {
                    nextHeatLoss += thisHeatLoss
                    if i >= minimumStepsBeforeTurning {
                        for nextDirection in [pose.direction.turnLeft(), pose.direction.turnRight()] {
                            let nextPose = Pose(coordinate: nextCoordinate, direction: nextDirection)
                            if nextHeatLoss < minimumHeatLoss[nextPose, default: Int.max] {
                                if nextCoordinate == destination, nextHeatLoss < bestSolution {
                                    bestSolution = nextHeatLoss
                                }
                                minimumHeatLoss[nextPose] = nextHeatLoss
                                queue.append(nextPose)
                                updatedQueue = true
                            }
                        }
                    }
                } else {
                    break
                }
            }

            if updatedQueue {
                queue.sort { minimumHeatLoss[$0]! < minimumHeatLoss[$1]! }
            }
        }

        return bestSolution
    }

    // MARK: - Parsing

    func parseMap() -> [[Int]] {
        return inputLines().map({ $0.compactMap({ Int(String($0)) }) })
    }
}
