import AdventKit
import Foundation

struct Day07: Day {
    let lineRegex = try! NSRegularExpression(pattern: #"^(.+) bags contain (.+)\.$"#, options: [.anchorsMatchLines])
    let contentsRegex = try! NSRegularExpression(pattern: #"(\d)+ (\D+) bags?"#, options: [])

    func parseInput(input: String) -> (containers: [String: [(Int, String)]], containedBy: [String: [String]]) {
        var containers: [String: [(Int, String)]] = [:]
        var containedBy: [String: [String]] = [:]

        try! input.enumerateMatches(withRegularExpression: lineRegex) { groups in
            let outerColor = groups[1]
            let contents = groups[2]
            try! contents.enumerateMatches(withRegularExpression: contentsRegex) { groups in
                let innerNumber = Int(groups[1])!
                let innerColor = groups[2]

                var c = containers[outerColor] ?? []
                c.append((innerNumber, innerColor))
                containers[outerColor] = c

                var cb = containedBy[innerColor] ?? []
                cb.append(outerColor)
                containedBy[innerColor] = cb
            }
        }

        return (containers, containedBy)
    }

    func run(input: String) async throws -> (Int, Int) {
        let (containers, containedBy) = parseInput(input: input)
        async let p1 = part1(containedBy: containedBy)
        async let p2 = part2(containers: containers)
        return try await (p1, p2)
    }

    func part1(containedBy: [String: [String]]) throws -> Int {
        var colors: Set<String> = []
        addColorsThatEventuallyContain(color: "shiny gold", toSet: &colors, containedBy: containedBy)
        return colors.count
    }

    func addColorsThatEventuallyContain(color: String, toSet set: inout Set<String>, containedBy: [String: [String]]) {
        guard let containers = containedBy[color] else { return }
        for containerColor in containers {
            if !set.contains(containerColor) {
                set.insert(containerColor)
                addColorsThatEventuallyContain(color: containerColor, toSet: &set, containedBy: containedBy)
            }
        }
    }

    func part2(containers: [String: [(Int, String)]]) throws -> Int {
        var work: [String: Int] = [:]
        let result = numberOfBagsInside(color: "shiny gold", work: &work, containers: containers)
        return result
    }

    func numberOfBagsInside(color: String, work: inout [String: Int], containers: [String: [(Int, String)]]) -> Int {
        if let prev = work[color] {
            return prev
        } else if let contents = containers[color] {
            var sum = 0
            for (innerNumber, innerColor) in contents {
                let innerContents = numberOfBagsInside(color: innerColor, work: &work, containers: containers)
                sum = sum + innerNumber + (innerNumber * innerContents)
            }
            work[color] = sum
            return sum
        } else {
            work[color] = 0
            return 0
        }
    }
}
