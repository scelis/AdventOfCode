import AdventKit
import Foundation

public class Day02: Day<Int, Int> {
    private enum Color: String {
        case red, green, blue
    }

    private struct Game {
        var id: Int
        var reveals: [[Color: Int]]
    }

    public override func part1() throws -> Int {
        games
            .filter { isPossible(game: $0, maximumCubes: [.red: 12, .green: 13, .blue: 14]) }
            .map { $0.id }
            .reduce(0, +)
    }

    public override func part2() throws -> Int {
        games
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

    private lazy var games: [Game] = inputLines.map { parseGame(string: $0) }

    private let gameRegex = #/^Game (\d+): /#

    private func parseGame(string: String) -> Game {
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
