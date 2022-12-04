import Foundation

open class Day {

    // MARK: - Initialization

    public init() {
    }

    public init(input: String) {
        inputString = input
    }

    public init(fileName: String) {
        inputURL = url(withFileName: fileName)
    }

    // MARK: - Input

    private lazy var inputURL: URL? = {
        return url(withFileName: "input.txt")
    }()

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
                return line.trimmingCharacters(in: .whitespaces)
            })
    }()

    public lazy var inputIntegers: [Int] = {
        return inputLines.compactMap({ Int($0) })
    }()

    private func url(withFileName fileName: String) -> URL? {
        let className = String(cString: class_getName(type(of: self)))
        let groups = try! className.firstMatch(withPattern: #"AOC_(\d+)_(\d+)"#)!
        var dir = URL(fileURLWithPath: "\(#file)").deletingLastPathComponent().deletingLastPathComponent()
        dir.appendPathComponent(groups[1])
        dir.appendPathComponent("Day\(groups[2])")
        dir.appendPathComponent(fileName)
        return dir
    }

    // MARK: - Solving

    open func part1() -> Any {
        return ""
    }

    open func part2() -> Any {
        return ""
    }

    public func run() {
        print("Part 1: \(part1())")
        print("Part 2: \(part2())")
    }
}
