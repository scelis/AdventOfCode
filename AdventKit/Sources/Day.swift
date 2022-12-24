import Foundation

open class Day<Part1: CustomStringConvertible, Part2: CustomStringConvertible> {

    // MARK: - Initialization

    public init() {
    }

    public init(input: String) {
        self.input = input
    }

    public init(fileName: String) {
        inputURL = url(withFileName: fileName)
    }

    // MARK: - Input

    private lazy var inputURL: URL? = {
        return url(withFileName: "input.txt")
    }()

    public lazy var input: String = {
        guard
            let url = inputURL,
            let input = FileManager.default.contents(atPath: url.path),
            let string = String(data: input, encoding: .utf8)
            else { return "" }

        return string.trimmingCharacters(in: .newlines)
    }()

    public lazy var inputLines: [String] = {
        return input.components(separatedBy: .newlines)
    }()

    private func url(withFileName fileName: String) -> URL {
        let className = String(cString: class_getName(type(of: self)))
        let groups = try! className.firstMatch(withPattern: #"AOC(\d+)\.Day(\d+)"#)!
        let dir = URL(fileURLWithPath: "\(#file)")
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .appending(pathComponent: groups[1])
            .appending(pathComponent: "Sources")
            .appending(pathComponent: "Day\(groups[2])")
            .appending(pathComponent: fileName)
        return dir
    }

    // MARK: - Solving

    open func part1() throws -> Part1 {
        fatalError("You must implement part1()")
    }

    open func part2() throws -> Part2 {
        fatalError("You must implement part2()")
    }
}
