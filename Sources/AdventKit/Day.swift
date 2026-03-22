import Foundation

public protocol Day: Sendable {
    associatedtype Part1: CustomStringConvertible
    associatedtype Part2: CustomStringConvertible

    func run(input: String) async throws -> (Part1, Part2)
}

public enum AdventKitError: Error {
    case fileNotFound
    case invalidData
}

extension Day {
    public func run(url: URL?) async throws -> (Part1, Part2) {
        guard let url else {
            throw AdventKitError.fileNotFound
        }

        let data = try Data(contentsOf: url)
        guard let input = String(data: data, encoding: .utf8) else {
            throw AdventKitError.invalidData
        }

        return try await run(input: input.trimmingCharacters(in: .newlines))
    }
}

extension String {
    public var lines: [String] {
        components(separatedBy: .newlines)
    }

    public var integers: [Int] {
        components(separatedBy: .whitespacesAndNewlines).compactMap(Int.init)
    }

    public var integerArrays: [[Int]] {
        lines.map { line in
            line.components(separatedBy: .whitespaces).compactMap(Int.init)
        }
    }

    public var characterArrays: [[Character]] {
        lines.map { Array($0) }
    }
}
