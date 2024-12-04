import Foundation

public protocol Day: Sendable {
    associatedtype Part1: CustomStringConvertible
    associatedtype Part2: CustomStringConvertible

    func run() async throws -> (Part1, Part2)
}

extension Day {
    public func input(file: StaticString = #filePath) -> String {
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

    public func inputLines(file: StaticString = #filePath) -> [String] {
        input(file: file).components(separatedBy: .newlines)
    }

    public func inputIntegers(file: StaticString = #filePath) -> [Int] {
        input(file: file).components(separatedBy: .whitespacesAndNewlines).compactMap(Int.init)
    }

    public func inputIntegerArrays(file: StaticString = #filePath) -> [[Int]] {
        inputLines(file: file).map { line in
            line.components(separatedBy: .whitespaces).compactMap(Int.init)
        }
    }

    public func inputCharacterArrays(file: StaticString = #filePath) -> [[Character]] {
        inputLines(file: file).map { line in
            Array(line)
        }
    }
}
