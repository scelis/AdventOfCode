import AdventKit
import Foundation

struct Day07: Day {

    // MARK: - Structures

    enum Card: Int, CaseIterable {
        case two = 2
        case three = 3
        case four = 4
        case five = 5
        case six = 6
        case seven = 7
        case eight = 8
        case nine = 9
        case ten = 10
        case jack = 11
        case queen = 12
        case king = 13
        case ace = 14

        init?(character: Character) {
            switch character {
            case "2": self = .two
            case "3": self = .three
            case "4": self = .four
            case "5": self = .five
            case "6": self = .six
            case "7": self = .seven
            case "8": self = .eight
            case "9": self = .nine
            case "T": self = .ten
            case "J": self = .jack
            case "Q": self = .queen
            case "K": self = .king
            case "A": self = .ace
            default: return nil
            }
        }

        func relativeValue(usingJokers: Bool) -> Int {
            switch self {
            case .two: return usingJokers ? 1 : 0
            case .three: return usingJokers ? 2 : 1
            case .four: return usingJokers ? 3 : 2
            case .five: return usingJokers ? 4 : 3
            case .six: return usingJokers ? 5 : 4
            case .seven: return usingJokers ? 6 : 5
            case .eight: return usingJokers ? 7 : 6
            case .nine: return usingJokers ? 8 : 7
            case .ten: return usingJokers ? 9 : 8
            case .jack: return usingJokers ? 0 : 9
            case .queen: return usingJokers ? 10 : 10
            case .king: return usingJokers ? 11 : 11
            case .ace: return usingJokers ? 12 : 12
            }
        }
    }

    struct Hand {
        var cards: [Card]
        var bid: Int
    }

    // MARK: - Solving

    func calculateRelativeStrength(_ hand: Hand, usingJokers: Bool) -> Int {
        let counts: [Card: Int] = {
            var counts = hand.cards.reduce(into: [:]) { partialResult, card in
                partialResult[card, default: 0] += 1
            }
            if usingJokers, let numJokers = counts[.jack], numJokers < 5 {
                counts[.jack] = nil
                let replacement = counts.max { $0.value < $1.value }!.key
                counts[replacement]! += numJokers
            }
            return counts
        }()

        let sortedCounts = counts.values.sorted(by: >)
        let initialValue = sortedCounts[0] * 10 + (sortedCounts[safe: 1] ?? 0)
        return hand.cards.reduce(initialValue) { partialResult, card in
            return partialResult * Card.allCases.count + card.relativeValue(usingJokers: usingJokers)
        }
    }

    func calculateTotalWinnings(hands: [Hand], usingJokers: Bool) -> Int {
        let sortedHands: [Hand] = hands
            .map { ($0, calculateRelativeStrength($0, usingJokers: usingJokers)) }
            .sorted { $0.1 < $1.1 }
            .map { $0.0 }

        return sortedHands
            .enumerated()
            .reduce(0) { partialResult, item -> Int in
                partialResult + (item.offset + 1) * item.element.bid
            }
    }

    func run() async throws -> (Int, Int) {
        let hands = parseHands()
        async let p1 = part1(hands: hands)
        async let p2 = part2(hands: hands)
        return try await (p1, p2)
    }

    public func part1(hands: [Hand]) async throws -> Int {
        calculateTotalWinnings(hands: hands, usingJokers: false)
    }

    public func part2(hands: [Hand]) async throws -> Int {
        calculateTotalWinnings(hands: hands, usingJokers: true)
    }

    // MARK: - Parsing

    func parseHands() -> [Hand] {
        inputLines().map { line in
            let components = line.components(separatedBy: " ")
            let cards: [Card] = components[0].compactMap(Card.init)
            let bid = Int(components[1])!
            return Hand(cards: cards, bid: bid)
        }
    }
}
