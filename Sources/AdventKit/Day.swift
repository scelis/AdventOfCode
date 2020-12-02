import Foundation

open class Day {
    private var inputURL: URL? {
        let className = String(cString: class_getName(type(of: self)))
        let groups = try! className.firstMatchingGroups(withPattern: "AOC_(\\d+)_(\\d+)")
        var dir = URL(fileURLWithPath: "\(#file)").deletingLastPathComponent().deletingLastPathComponent()
        dir.appendPathComponent(groups![0]!)
        dir.appendPathComponent("Day\(groups![1]!)")
        dir.appendPathComponent("input.txt")
        return dir
    }

    public lazy var inputString: String = {
        guard
            let url = inputURL,
            let input = FileManager.default.contents(atPath: url.path),
            let string = String(data: input, encoding: .utf8)
            else { return "" }

        return string.trimmingCharacters(in: .whitespacesAndNewlines)
    }()

    public lazy var inputLines: [String] = {
        return inputString
            .components(separatedBy: .newlines)
            .compactMap({ line in
                let line = line.trimmingCharacters(in: .whitespaces)
                return line.isEmpty ? nil : line
            })
    }()

    public lazy var inputIntegers: [Int] = {
        return inputLines.compactMap({ Int($0) })
    }()

    public init() {
    }

    open func part1() -> String {
        return ""
    }

    open func part2() -> String {
        return ""
    }

    public func run() {
        print("Part 1: \(part1())")
        print("Part 2: \(part2())")
    }
}
