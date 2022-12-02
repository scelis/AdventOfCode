import AdventKit
import Foundation

class Day02: Day {
    enum Choice: Int {
        case rock = 1
        case paper = 2
        case scissors = 3

        init(string: String) {
            switch string {
            case "A", "X": self = .rock
            case "B", "Y": self = .paper
            case "C", "Z": self = .scissors
            default: fatalError()
            }
        }

        var beats: Choice {
            switch self {
            case .rock: return .scissors
            case .paper: return .rock
            case .scissors: return .paper
            }
        }

        var losesTo: Choice {
            switch self {
            case .scissors: return .rock
            case .rock: return .paper
            case .paper: return .scissors
            }
        }

        func outcome(against: Choice) -> Outcome {
            if self == against {
                return .tie
            } else if self.beats == against {
                return .win
            } else {
                return .loss
            }
        }

        static func choice(toAchieve outcome: Outcome, against: Choice) -> Choice {
            switch outcome {
            case .tie: return against
            case .win: return against.losesTo
            case .loss: return against.beats
            }
        }
    }

    enum Outcome: Int {
        case loss = 0
        case tie = 3
        case win = 6

        init(string: String) {
            switch string {
            case "X": self = .loss
            case "Y": self = .tie
            case "Z": self = .win
            default: fatalError()
            }
        }
    }

    override func part1() -> String {
        return inputLines.map { line in
            let array = line.components(separatedBy: .whitespaces)
            let theirs = Choice(string: array[0])
            let mine = Choice(string: array[1])
            return mine.outcome(against: theirs).rawValue + mine.rawValue
        }
        .reduce(0, +)
        .description
    }

    override func part2() -> String {
        return inputLines.map { line in
            let array = line.components(separatedBy: .whitespaces)
            let theirs = Choice(string: array[0])
            let outcome = Outcome(string: array[1])
            let mine = Choice.choice(toAchieve: outcome, against: theirs)
            return outcome.rawValue + mine.rawValue
        }
        .reduce(0, +)
        .description
    }
}

Day02().run()
