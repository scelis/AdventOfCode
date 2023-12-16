import Foundation

public protocol Day {
    associatedtype Part1: CustomStringConvertible
    associatedtype Part2: CustomStringConvertible

    func part1() async throws -> Part1
    func part2() async throws -> Part2
    func run() async throws -> (Part1, Part2)
}

extension Day {

    // MARK: Solving

    public func part1() async throws -> Part1 {
        fatalError("Unimplemented")
    }

    public func part2() async throws -> Part2 {
        fatalError("Unimplemented")
    }

    public func run() async throws -> (Part1, Part2) {
        async let p1 = part1()
        async let p2 = part2()
        return (try await p1, try await p2)
    }

    // MARK: Input

    public static func input(file: StaticString = #file) -> String {
        let url = URL(filePath: file.description).deletingLastPathComponent().appending(pathComponent: "input.txt")
        if
            let input = FileManager.default.contents(atPath: url.path),
            let string = String(data: input, encoding: .utf8)
        {
            return string.trimmingCharacters(in: .newlines)
        } else {
            return ""
        }
    }

    public func input(file: StaticString = #file) -> String {
        Self.input(file: file)
    }

    public static func inputLines(file: StaticString = #file) -> [String] {
        input(file: file).components(separatedBy: .newlines)
    }

    public func inputLines(file: StaticString = #file) -> [String] {
        Self.inputLines(file: file)
    }

    public static func inputIntegers(file: StaticString = #file) -> [Int] {
        input(file: file).components(separatedBy: .whitespacesAndNewlines).compactMap(Int.init)
    }

    public func inputIntegers(file: StaticString = #file) -> [Int] {
        Self.inputIntegers(file: file)
    }

    public static func inputIntegerArrays(file: StaticString = #file) -> [[Int]] {
        inputLines(file: file).map { line in
            line.components(separatedBy: .whitespaces).compactMap(Int.init)
        }
    }

    public func inputIntegerArrays(file: StaticString = #file) -> [[Int]] {
        Self.inputIntegerArrays(file: file)
    }
}
