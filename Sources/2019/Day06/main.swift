import AdventKit
import Foundation

class Day06: Day {
    var centerToFarDict: [String: [String]] = [:]
    var farToCenterDict: [String: String] = [:]

    override init() {
        super.init()

        for line in inputLines {
            let components = line.components(separatedBy: ")")

            farToCenterDict[components[1]] = components[0]

            if var arr = centerToFarDict[components[0]] {
                arr.append(components[1])
                centerToFarDict[components[0]] = arr
            } else {
                centerToFarDict[components[0]] = [components[1]]
            }
        }
    }

    func countDirectAndIndirectOrbits(from: String, depth: Int = 0) -> Int {
        guard let children = centerToFarDict[from] else { return 0 }

        var sum = 0
        for child in children {
            sum += 1 // Direct
            sum += depth // Indirects
            sum += countDirectAndIndirectOrbits(from: child, depth: depth + 1)
        }

        return sum
    }

    func distance(from: String, to: String) -> Int {
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

    override func part1() -> String {
        return "\(countDirectAndIndirectOrbits(from: "COM"))"
    }

    override func part2() -> String {
        return "\(distance(from: "YOU", to: "SAN") - 2)"
    }
}

Day06().run()
