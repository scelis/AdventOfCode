import AdventKit
import Foundation

public class Day07: Day<Int, Int> {
    let lineRegex = try! NSRegularExpression(pattern: #"^(.+) bags contain (.+)\.$"#, options: [.anchorsMatchLines])
    let contentsRegex = try! NSRegularExpression(pattern: #"(\d)+ (\D+) bags?"#, options: [])

    var containers: [String: [(Int, String)]] = [:]
    var containedBy: [String: [String]] = [:]

    override init() {
        super.init()

        try! input.enumerateMatches(withRegularExpression: lineRegex) { groups in
            let outerColor = groups[1]
            let contents = groups[2]
            try! contents.enumerateMatches(withRegularExpression: contentsRegex) { groups in
                let innerNumber = Int(groups[1])!
                let innerColor = groups[2]

                var contents = containers[outerColor] ?? []
                contents.append((innerNumber, innerColor))
                containers[outerColor] = contents

                var containers = containedBy[innerColor] ?? []
                containers.append(outerColor)
                containedBy[innerColor] = containers
            }
        }
    }

    public override func part1() throws -> Int {
        var colors: Set<String> = []
        addColorsThatEventuallyContain(color: "shiny gold", toSet: &colors)
        return colors.count
    }

    func addColorsThatEventuallyContain(color: String, toSet set: inout Set<String>) {
        guard let containers = containedBy[color] else { return }
        for containerColor in containers {
            if !set.contains(containerColor) {
                set.insert(containerColor)
                addColorsThatEventuallyContain(color: containerColor, toSet: &set)
            }
        }
    }

    public override func part2() throws -> Int {
        var work: [String: Int] = [:]
        let result = numberOfBagsInside(color: "shiny gold", work: &work)
        return result
    }

    func numberOfBagsInside(color: String, work: inout [String: Int]) -> Int {
        if let prev = work[color] {
            return prev
        } else if let contents = containers[color] {
            var sum = 0
            for (innerNumber, innerColor) in contents {
                let innerContents = numberOfBagsInside(color: innerColor, work: &work)
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
