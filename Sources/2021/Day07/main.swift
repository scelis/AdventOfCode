import AdventKit
import Algorithms
import Foundation

class Day07: Day {
    func solve(distanceFunction: ([Int], Int) -> Int) -> String {
        let crabs = inputString.components(separatedBy: ",").map({ Int($0)! })
        let average: Int = crabs.reduce(0, +) / crabs.count
        let base = distanceFunction(crabs, average)
        let increasing = distanceFunction(crabs, average + 1)
        let decreasing = distanceFunction(crabs, average - 1)

        guard base > increasing || base > decreasing else { return base.description }

        var best: Int
        var distanceFromAverage: Int
        if increasing < base {
            distanceFromAverage = 1
            best = increasing
        } else {
            distanceFromAverage = -1
            best = decreasing
        }

        while true {
            let nextDistanceFromAverage = (distanceFromAverage < 0) ? distanceFromAverage - 1 : distanceFromAverage + 1
            let nextTotalCost = distanceFunction(crabs, average + nextDistanceFromAverage)
            if nextTotalCost < best {
                best = nextTotalCost
                distanceFromAverage = nextDistanceFromAverage
            } else {
                return best.description
            }
        }
    }

    override func part1() -> Any {
        return solve { crabs, location in
            return crabs
                .map { abs($0 - location) }
                .reduce(0, +)
        }
    }

    override func part2() -> Any {
        return solve { crabs, location in
            return crabs
                .map { crabLocation in
                    let distance = abs(crabLocation - location)
                    return distance * (distance + 1) / 2
                }
                .reduce(0, +)
        }
    }
}

Day07().run()
