import AdventKit
import Foundation

struct Day06: Day {
    func run(input: String) async throws -> (Int, Int) {
        let (centerToFarDict, farToCenterDict) = parseOrbits(input: input)
        async let p1 = part1(centerToFarDict: centerToFarDict)
        async let p2 = part2(farToCenterDict: farToCenterDict)
        return try await (p1, p2)
    }

    func parseOrbits(input: String) -> (centerToFar: [String: [String]], farToCenter: [String: String]) {
        var centerToFarDict: [String: [String]] = [:]
        var farToCenterDict: [String: String] = [:]

        for line in input.lines {
            let components = line.components(separatedBy: ")")

            farToCenterDict[components[1]] = components[0]

            if var arr = centerToFarDict[components[0]] {
                arr.append(components[1])
                centerToFarDict[components[0]] = arr
            } else {
                centerToFarDict[components[0]] = [components[1]]
            }
        }

        return (centerToFarDict, farToCenterDict)
    }

    func countDirectAndIndirectOrbits(from: String, depth: Int = 0, centerToFarDict: [String: [String]]) -> Int {
        guard let children = centerToFarDict[from] else { return 0 }

        var sum = 0
        for child in children {
            sum += 1 // Direct
            sum += depth // Indirects
            sum += countDirectAndIndirectOrbits(from: child, depth: depth + 1, centerToFarDict: centerToFarDict)
        }

        return sum
    }

    func distance(from: String, to: String, farToCenterDict: [String: String]) -> Int {
        var destinationParents: [String: Int] = [:]
        var i = 0
        var next = to
        while let parent = farToCenterDict[next] {
            destinationParents[parent] = i + 1
            i += 1
            next = parent
        }

        var totalDistance = 0
        next = from
        while let parent = farToCenterDict[next] {
            totalDistance += 1
            if let distance = destinationParents[parent] {
                totalDistance += distance
                break
            }
            next = parent
        }

        return totalDistance
    }

    func part1(centerToFarDict: [String: [String]]) async throws -> Int {
        return countDirectAndIndirectOrbits(from: "COM", centerToFarDict: centerToFarDict)
    }

    func part2(farToCenterDict: [String: String]) async throws -> Int {
        return distance(from: "YOU", to: "SAN", farToCenterDict: farToCenterDict) - 2
    }
}
