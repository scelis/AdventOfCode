import AdventKit2
import Foundation

struct Day02: Day {
    enum Color: String {
        case red, green, blue
    }

    struct Game {
        var id: Int
        var reveals: [[Color: Int]]
    }

    func run() async throws -> (Int, Int) {
        let games = parseGames()
        async let p1 = part1(games: games)
        async let p2 = part2(games: games)
        return try await (p1, p2)
    }

    func part1(games: [Game]) async throws -> Int {
        games
            .filter { isPossible(game: $0, maximumCubes: [.red: 12, .green: 13, .blue: 14]) }
            .map { $0.id }
            .reduce(0, +)
    }

    func part2(games: [Game]) async throws -> Int {
        games
            .map { power(of: $0) }
            .reduce(0, +)
    }

    func isPossible(game: Game, maximumCubes: [Color: Int]) -> Bool {
        game.reveals.allSatisfy { reveal in
            reveal.allSatisfy { color, count in
                count <= maximumCubes[color, default: 0]
            }
        }
    }

    func power(of game: Game) -> Int {
        var maximumCubeCounts: [Color: Int] = [.red: 0, .green: 0, .blue: 0]
        for reveal in game.reveals {
            for (color, count) in reveal {
                maximumCubeCounts[color] = max(maximumCubeCounts[color]!, count)
            }
        }
        return maximumCubeCounts.values.reduce(1, *)
    }

    // MARK: - Parsing

    func parseGames() -> [Game] {
        let gameRegex = #/^Game (\d+): /#

        return input().components(separatedBy: .newlines).map { string in
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
}
