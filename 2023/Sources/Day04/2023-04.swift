import AdventKit
import Foundation

public struct Day04: Day {

    // MARK: - Structures

    private struct Card {
        var id: Int
        var winningNumbers: [Int]
        var otherNumbers: [Int]

        var numberOfMatches: Int {
            Set(winningNumbers).intersection(Set(otherNumbers)).count
        }
    }

    // MARK: - Solving

    private let cards: [Card]

    public func part1() async throws -> Int {
        cards.reduce(0) { partialResult, card in
            let numberOfMatches = card.numberOfMatches
            return (numberOfMatches == 0) ? partialResult : partialResult + pow(2, numberOfMatches - 1)
        }
    }

    public func part2() async throws -> Int {
        let lastCardID = cards.last!.id
        var cardCounts: [Int: Int] = [:]
        for card in cards {
            cardCounts[card.id, default: 0] += 1
            for i in 0..<card.numberOfMatches {
                if card.id + i + 1 <= lastCardID {
                    cardCounts[card.id + i + 1, default: 0] += cardCounts[card.id]!
                }
            }
        }
        return cardCounts.values.reduce(0, +)
    }

    // MARK: - Parsing

    private static let cardRegex = #/^Card +(\d+): +/#

    init() {
        self.cards = Self.inputLines().map { Self.parseCard(string: $0) }
    }

    private static func parseCard(string: String) -> Card {
        let match = string.firstMatch(of: cardRegex)!
        let cardID = Int(match.1)!
        let numbers: [[Int]] = string[match.0.endIndex...].components(separatedBy: "|").map { side in
            side.components(separatedBy: " ").compactMap(Int.init)
        }
        return Card(id: cardID, winningNumbers: numbers[0], otherNumbers: numbers[1])
    }
}
