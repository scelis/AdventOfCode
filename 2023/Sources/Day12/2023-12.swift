import AdventKit
import Algorithms
import Foundation

public struct Day12: Day {

    // MARK: - Structures

    enum Spring: Character {
        case operational = "."
        case damaged = "#"
        case unknown = "?"
    }

    struct Record {
        var springs: [Spring]
        var targetCounts: [Int]
    }

    // MARK: - Solving

    public func part1() async throws -> Int {
        return await countPossibleArrangements()
    }

    public func part2() async throws -> Int {
        return await countPossibleArrangements(unfolded: 5)
    }

    func countPossibleArrangements(unfolded: Int = 1) async -> Int {
        let records = self.records

        var count = 0
        await withTaskGroup(of: Int.self) { group in
            for record in records {
                group.addTask {
                    var cache: [String: Int] = [:]
                    let record = record.unfolded(times: unfolded).trimmed()
                    return await self.numberOfPossibleArrangements(record: record, cache: &cache)
                }
            }
            for await number in group {
                count += number
            }
        }

        return count
    }

    func numberOfPossibleArrangements(record: Record, cache: inout [String: Int]) async -> Int {
        let cacheKey = record.cacheKey
        if let cachedValue = cache[record.cacheKey] {
            return cachedValue
        }

        let currentCounts = record.currentCounts()
        if currentCounts == record.targetCounts {
            // Our springs match the target exactly. Nothing more to do.
            return 1
        }
        if (currentCounts.max() ?? 0) > (record.targetCounts.max() ?? 0) {
            // Our current counts has a segment longer than allowed.
            return 0
        }
        let currentNumBroken = currentCounts.reduce(0, +)
        let targetNumBroken = record.targetCounts.reduce(0, +)
        if currentNumBroken >= targetNumBroken {
            // We have more broken springs than allowed.
            return 0
        }
        if record.numBrokenOrUnknown() < targetNumBroken {
            // There aren't enough unknown springs left to meet the target.
            return 0
        }

        // Find first space where the next segment can fit
        if let firstPossibleIndex = record.firstPossibleDamagedIndex() {
            var matchingRecord = record
            matchingRecord.springs.removeFirst(firstPossibleIndex + record.targetCounts[0])
            if matchingRecord.springs.first == .unknown {
                matchingRecord.springs[0] = .operational
            }
            matchingRecord.targetCounts.removeFirst()
            matchingRecord = matchingRecord.trimmed()

            if record.springs[firstPossibleIndex] == .damaged {
                // First space in the first possible segment is damaged, so this is the only place it can go.
                let number = await numberOfPossibleArrangements(record: matchingRecord, cache: &cache)
                cache[cacheKey] = number
                return number
            } else {
                // First space is unknown so also consider removing the first space.
                var otherRecord = record
                otherRecord.springs.removeFirst(firstPossibleIndex + 1)
                otherRecord = otherRecord.trimmed()
                let matchingCount = await numberOfPossibleArrangements(record: matchingRecord, cache: &cache)
                let otherCount = await numberOfPossibleArrangements(record: otherRecord, cache: &cache)
                cache[matchingRecord.cacheKey] = matchingCount
                cache[otherRecord.cacheKey] = otherCount
                cache[cacheKey] = matchingCount + otherCount
                return matchingCount + otherCount
            }
        } else {
            cache[cacheKey] = 0
            return 0
        }
    }

    // MARK: - Parsing

    var records: [Record] {
        input().components(separatedBy: .newlines).map { line in
            let components = line.components(separatedBy: .whitespaces)
            let springs = components[0].compactMap(Spring.init)
            let counts = components[1].components(separatedBy: ",").compactMap(Int.init)
            return Record(springs: springs, targetCounts: counts)
        }
    }
}

extension Day12.Record {
    var cacheKey: String {
        var cacheKey = String(springs.map({ $0.rawValue }))
        cacheKey += " - [" + targetCounts.compactMap({ "\($0)" }).joined(separator: ",") + "]"
        return cacheKey
    }

    func trimmed() -> Day12.Record {
        var record = self
        while record.springs.first == .operational {
            record.springs.removeFirst()
        }
        while record.springs.last == .operational {
            record.springs.removeLast()
        }
        return record
    }

    func currentCounts() -> [Int] {
        springs.chunked(by: ==).filter({ $0.first == .damaged }).map({ $0.count })
    }

    func numBrokenOrUnknown() -> Int {
        springs
            .filter { $0 == .damaged || $0 == .unknown }
            .count
    }

    func firstPossibleDamagedIndex() -> Int? {
        guard let target = targetCounts.first else { return nil }

        var startingIndex = 0
        var currentIndex = 0
        var foundDamagedSpring = false

        while (currentIndex - startingIndex) < target {
            switch springs[safe: currentIndex] {
            case nil:
                return nil
            case .damaged:
                foundDamagedSpring = true
                currentIndex += 1
            case .unknown:
                currentIndex += 1
            case .operational:
                if foundDamagedSpring {
                    return nil
                }
                currentIndex += 1
                startingIndex = currentIndex
            }

            if (currentIndex - startingIndex) == target {
                if springs[safe: currentIndex] == .damaged {
                    if springs[startingIndex] == .damaged {
                        return nil
                    } else {
                        startingIndex += 1
                    }
                } else {
                    return startingIndex
                }
            }
        }

        return nil
    }

    func unfolded(times: Int) -> Day12.Record {
        guard times > 1 else { return self }

        var unfoldedSprings = springs
        var unfoldedTargetCounts = targetCounts
        for _ in (2...times) {
            unfoldedSprings += [.unknown] + springs
            unfoldedTargetCounts += targetCounts
        }

        return Day12.Record(springs: unfoldedSprings, targetCounts: unfoldedTargetCounts)
    }
}
