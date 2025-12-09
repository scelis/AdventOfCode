import AdventKit
import Foundation

struct Day08: Day {
    struct Pair: Comparable {
        var first: Coordinate3D
        var second: Coordinate3D
        var distance: Int

        static func < (lhs: Pair, rhs: Pair) -> Bool {
            return lhs.distance < rhs.distance
        }
    }

    func run() async throws -> (Int, Int) {
        let coordinates: [Coordinate3D] = parseInput()

        // Create a BTree that holds all pairs (and their distances)
        let pairs = BTree<Pair>()
        for i in 0..<(coordinates.count - 1) {
            for j in (i + 1)..<coordinates.count {
                let distance = relativeDistance(from: coordinates[i], to: coordinates[j])
                let pair = Pair(first: coordinates[i], second: coordinates[j], distance: distance)
                pairs.insert(pair)
            }
        }

        var sets: [Set<Coordinate3D>] = []
        var iterator = pairs.makeIterator()

        func connect(pair: Pair) {
            var updatedSets: [Set<Coordinate3D>] = []
            var pairSet: Set<Coordinate3D> = [pair.first, pair.second]
            for set in sets {
                if set.contains(pair.first) || set.contains(pair.second) {
                    pairSet.formUnion(set)
                } else {
                    updatedSets.append(set)
                }
            }
            updatedSets.append(pairSet)
            sets = updatedSets
        }

        // Part 1: Take 1000 closest pairs and use them to generate sets of connected coordinates.
        for _ in 0..<1000 {
            connect(pair: iterator.next()!)
        }

        let part1 = sets
            .map { $0.count }
            .sorted()
            .suffix(3)
            .reduce(1, *)

        // Part 2: Keep connecting until all nodes are in a single set.
        var finalPair: Pair?
        while sets.first!.count < coordinates.count {
            let pair = iterator.next()!
            connect(pair: pair)
            finalPair = pair
        }

        let part2 = finalPair!.first.x * finalPair!.second.x
        return (part1, part2)
    }

    func parseInput() -> [Coordinate3D] {
        inputLines().map { line in
            let parts = line.components(separatedBy: ",").compactMap(Int.init)
            return Coordinate3D(x: parts[0], y: parts[1], z: parts[2])
        }
    }

    public func relativeDistance(from: Coordinate3D, to: Coordinate3D) -> Int {
        // This is only approximate. We avoid square rooting the answer because
        // the distance itself doesn't matter. We just need to be able to compare
        // multiple distances to find which is smallest.
        return
            (to.x - from.x) * (to.x - from.x) +
            (to.y - from.y) * (to.y - from.y) +
            (to.z - from.z) * (to.z - from.z)
    }
}
