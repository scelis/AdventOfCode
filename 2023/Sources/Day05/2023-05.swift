import AdventKit
import Algorithms
import Foundation

struct Day05: Day {
    func run() async throws -> (Int, Int) {
        let seeds = parseSeeds()
        let maps = parseMaps()
        async let p1 = part1(seeds: seeds, maps: maps)
        async let p2 = part2(seeds: seeds, maps: maps)
        return try await (p1, p2)
    }

    public func part1(seeds: [Int], maps: [[[Int]]]) async throws -> Int {
        var current = Set(seeds)
        var next: Set<Int> = []

        for group in maps {
            for map in group {
                for item in current {
                    if item >= map[1] && item < map[1] + map[2] {
                        next.insert(map[0] + (item - map[1]))
                        current.remove(item)
                    }
                }
            }
            current.formUnion(next)
            next.removeAll()
        }

        return current.min()!
    }

    public func part2(seeds: [Int], maps: [[[Int]]]) async throws -> Int {
        var current = IndexSet()
        var next = IndexSet()

        seeds.chunks(ofCount: 2).forEach { chunk in
            current.insert(integersIn: (chunk.first!..<(chunk.first! + chunk.last!)))
        }

        for group in maps {
            for map in group {
                let sourceSet = IndexSet(integersIn: map[1]..<(map[1] + map[2]))
                for sourceRange in sourceSet.intersection(current).rangeView {
                    let destinationRange = (sourceRange.lowerBound - map[1] + map[0])..<(sourceRange.upperBound - map[1] + map[0])
                    next.insert(integersIn: destinationRange)
                    current.remove(integersIn: sourceRange)
                }
            }
            current.formUnion(next)
            next.removeAll()
        }

        return current.first!
    }

    // MARK: - Parsing

    func parseSeeds() -> [Int] {
        let sections = input().components(separatedBy: "\n\n")
        return sections[0].components(separatedBy: " ").compactMap(Int.init)
    }

    func parseMaps() -> [[[Int]]] {
        input().components(separatedBy: "\n\n").dropFirst().map { section in
            let lines = section.components(separatedBy: "\n").dropFirst()
            return lines.map { $0.components(separatedBy: " ").compactMap(Int.init) }
        }
    }
}
