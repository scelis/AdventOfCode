import AdventKit
import Algorithms
import Foundation

public struct Day19: Day {

    // MARK: - Structures

    enum Operator: String {
        case greaterThan = ">"
        case lessThan = "<"
    }

    struct Rule {
        var rating: String
        var `operator`: Operator
        var value: Int
        var destination: String

        func accepts(_ part: Part) -> Bool {
            let partRatingValue = part.ratings[rating]!
            switch `operator` {
            case .greaterThan:
                return partRatingValue > value
            case .lessThan:
                return partRatingValue < value
            }
        }
    }

    struct Workflow {
        var name: String
        var rules: [Rule]
        var fallback: String

        func nextWorkflow(for part: Part) -> String {
            for rule in rules {
                if rule.accepts(part) {
                    return rule.destination
                }
            }

            return fallback
        }
    }

    struct Part {
        var ratings: [String: Int]
    }

    // MARK: - Solving

    public func part1() async throws -> Int {
        Self.parts
            .filter { isPartAccepted($0) }
            .map { $0.ratings.values.reduce(0, +) }
            .reduce(0, +)
    }

    func isPartAccepted(_ part: Part) -> Bool {
        var currentWorkflow = "in"
        while currentWorkflow != "A" && currentWorkflow != "R" {
            let workflow = Self.workflows[currentWorkflow]!
            currentWorkflow = workflow.nextWorkflow(for: part)
        }

        return currentWorkflow == "A"
    }

    public func part2() async throws -> Int {
        acceptedCombinations(
            currentWorkflow: "in",
            currentRatings: [
                "x": IndexSet(integersIn: 1...4000),
                "m": IndexSet(integersIn: 1...4000),
                "a": IndexSet(integersIn: 1...4000),
                "s": IndexSet(integersIn: 1...4000)
            ]
        )
    }

    func acceptedCombinations(currentWorkflow: String, currentRatings: [String: IndexSet]) -> Int {
        guard currentWorkflow != "A" else { return currentRatings.values.map({ $0.count }).reduce(1, *) }
        guard currentWorkflow != "R" else { return 0 }

        var total = 0
        var currentRatings = currentRatings
        let workflow = Self.workflows[currentWorkflow]!
        for rule in workflow.rules {
            switch rule.operator {
            case .greaterThan:
                var acceptedRatings = currentRatings
                acceptedRatings[rule.rating]!.remove(integersIn: 1...rule.value)
                total += acceptedCombinations(currentWorkflow: rule.destination, currentRatings: acceptedRatings)
                currentRatings[rule.rating]!.remove(integersIn: (rule.value + 1)...4000)
            case .lessThan:
                var acceptedRatings = currentRatings
                acceptedRatings[rule.rating]!.remove(integersIn: rule.value...4000)
                total += acceptedCombinations(currentWorkflow: rule.destination, currentRatings: acceptedRatings)
                currentRatings[rule.rating]!.remove(integersIn: 1..<rule.value)
            }
        }

        return total + acceptedCombinations(currentWorkflow: workflow.fallback, currentRatings: currentRatings)
    }

    // MARK: - Parsing

    private static let workflowRegex = #/^([a-z]+)\{(.*),([a-zA-Z]+)\}$/#
    private static let ruleRegex = #/^([a-z]+)(>|<)([0-9]+)\:([a-zA-Z]+)$/#

    private static var workflows: [String: Workflow] = {
        input().components(separatedBy: "\n\n")[0].components(separatedBy: .newlines).map { line in
            let workflowMatch = line.wholeMatch(of: workflowRegex)!
            let rules = workflowMatch.2.components(separatedBy: ",").map { ruleString in
                let ruleMatch = ruleString.wholeMatch(of: ruleRegex)!
                return Rule(
                    rating: String(ruleMatch.1),
                    operator: Operator(rawValue: String(ruleMatch.2))!,
                    value: Int(ruleMatch.3)!,
                    destination: String(ruleMatch.4)
                )
            }
            return Workflow(name: String(workflowMatch.1), rules: rules, fallback: String(workflowMatch.3))
        }
        .reduce(into: [:]) { $0[$1.name] = $1 }
    }()

    private static var parts: [Part] = {
        input().components(separatedBy: "\n\n")[1].components(separatedBy: .newlines).map { line in
            let ratings: [String: Int] = line.trimmingCharacters(in: CharacterSet(charactersIn: "{}"))
                .components(separatedBy: ",")
                .reduce(into: [:]) { partialResult, string in
                    let components = string.components(separatedBy: "=")
                    partialResult[components[0]] = Int(components[1])!
                }
            return Part(ratings: ratings)
        }
    }()
}
