import AdventKit
import Foundation

public struct Day02: Day {
    private enum Color: String {
        case red, green, blue
    }

    private struct Game {
        var id: Int
        var reveals: [[Color: Int]]
    }

    public func part1() async throws -> Int {
        Self.games
            .filter { isPossible(game: $0, maximumCubes: [.red: 12, .green: 13, .blue: 14]) }
            .map { $0.id }
            .reduce(0, +)
    }

    public func part2() async throws -> Int {
        Self.games
            .map { power(of: $0) }
            .reduce(0, +)
    }

    private func isPossible(game: Game, maximumCubes: [Color: Int]) -> Bool {
        game.reveals.allSatisfy { reveal in
            reveal.allSatisfy { color, count in
                count <= maximumCubes[color, default: 0]
            }
        }
    }

    private func power(of game: Game) -> Int {
        var maximumCubeCounts: [Color: Int] = [.red: 0, .green: 0, .blue: 0]
        for reveal in game.reveals {
            for (color, count) in reveal {
                maximumCubeCounts[color] = max(maximumCubeCounts[color]!, count)
            }
        }
        return maximumCubeCounts.values.reduce(1, *)
    }

    // MARK: - Parsing

    private static var games: [Game] = {
        input().components(separatedBy: .newlines).map { parseGame(string: $0) }
    }()

    private static let gameRegex = #/^Game (\d+): /#

    private static func parseGame(string: String) -> Game {
        let match = string.firstMatch(of: gameRegex)!
        let gameID = Int(match.1)!
        let reveals: [[Color: Int]] = string[match.0.endIndex...].components(separatedBy: "; ").map { reveal in
            reveal.components(separatedBy: ", ").reduce(into: [:]) { partialResult, numberColor in
                let colorComponents = numberColor.components(separatedBy: " ")
                let count = Int(colorComponents[0])!
                let color = Color(rawValue: colorComponents[1])!
                partialResult[color] = count
            }
        }
        return Game(id: gameID, reveals: reveals)
    }
}
