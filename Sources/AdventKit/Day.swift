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
