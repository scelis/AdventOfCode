import Foundation

open class Day {
    open var inputURL: URL? { nil }

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
