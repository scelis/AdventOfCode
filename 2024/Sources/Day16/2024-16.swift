import AdventKit
import Foundation

struct Day16: Day {
    struct Solution: Equatable, Hashable {
        var score: Int
        var coordinates: Set<Coordinate2D>
    }

    func run() async throws -> (Int, Int) {
        let (map, start, end) = parseInput()
        var queue = [Pose(coordinate: start, direction: .east)]
        var minimumScores: [Pose: Solution] = [queue[0]: Solution(score: 0, coordinates: [start])]
        var bestSolution = Solution(score: Int.max, coordinates: [])

        while !queue.isEmpty {
            let pose = queue.removeFirst()
            let currentSolution = minimumScores[pose]!
            if currentSolution.score > bestSolution.score {
                break
            }

            var updatedQueue = false
            let next: [(Pose, Int)] = [
                (pose.steppingForward(), currentSolution.score + 1),
                (pose.turningLeft(), currentSolution.score + 1000),
                (pose.turningRight(), currentSolution.score + 1000),
            ]

            for (nextPose, nextScore) in next where map[safe: nextPose.coordinate] != "#" {
                if nextPose.coordinate == end {
                    if nextScore == bestSolution.score {
                        bestSolution.coordinates.formUnion(currentSolution.coordinates)
                    } else if nextScore < bestSolution.score {
                        bestSolution = Solution(score: nextScore, coordinates: currentSolution.coordinates.union([end]))
                    }
                } else {
                    let minimumForPose = minimumScores[nextPose, default: Solution(score: Int.max, coordinates: [])]
                    if nextScore == minimumForPose.score {
                        minimumScores[nextPose]!.coordinates.formUnion(currentSolution.coordinates)
                    } else if nextScore < minimumForPose.score {
                        minimumScores[nextPose] = Solution(score: nextScore, coordinates: currentSolution.coordinates.union([nextPose.coordinate]))
                        queue.append(nextPose)
                        updatedQueue = true
                    }
                }
            }

            if updatedQueue {
                queue.sort { minimumScores[$0]!.score < minimumScores[$1]!.score }
            }
        }

        return (bestSolution.score, bestSolution.coordinates.count)
    }

    func parseInput() -> ([[Character]], Coordinate2D, Coordinate2D) {
        let map = inputCharacterArrays()
        var start: Coordinate2D?
        var end: Coordinate2D?
        for y in map.indices {
            for x in map[y].indices {
                if map[y][x] == "S" {
                    start = Coordinate2D(x: x, y: y)
                } else if map[y][x] == "E" {
                    end = Coordinate2D(x: x, y: y)
                }
            }
        }
        return (map, start!, end!)
    }
}
