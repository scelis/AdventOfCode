import AdventKit
import Algorithms
import Foundation

struct Day19: Day {

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

    func run() async throws -> (Int, Int) {
        let parts = parseParts()
        let workflows = parseWorkflows()
        async let p1 = part1(parts: parts, workflows: workflows)
        async let p2 = part2(workflows: workflows)
        return try await (p1, p2)
    }

    public func part1(parts: [Part], workflows: [String: Workflow]) async throws -> Int {
        parseParts()
            .filter { isPartAccepted($0, workflows: workflows) }
            .map { $0.ratings.values.reduce(0, +) }
            .reduce(0, +)
    }

    func isPartAccepted(_ part: Part, workflows: [String: Workflow]) -> Bool {
        var currentWorkflow = "in"
        while currentWorkflow != "A" && currentWorkflow != "R" {
            let workflow = workflows[currentWorkflow]!
            currentWorkflow = workflow.nextWorkflow(for: part)
        }

        return currentWorkflow == "A"
    }

    public func part2(workflows: [String: Workflow]) async throws -> Int {
        acceptedCombinations(
            workflows: workflows,
            currentWorkflow: "in",
            currentRatings: [
                "x": IndexSet(integersIn: 1...4000),
                "m": IndexSet(integersIn: 1...4000),
                "a": IndexSet(integersIn: 1...4000),
                "s": IndexSet(integersIn: 1...4000)
            ]
        )
    }

    func acceptedCombinations(workflows: [String: Workflow], currentWorkflow: String, currentRatings: [String: IndexSet]) -> Int {
        guard currentWorkflow != "A" else { return currentRatings.values.map({ $0.count }).reduce(1, *) }
        guard currentWorkflow != "R" else { return 0 }

        var total = 0
        var currentRatings = currentRatings
        let workflow = workflows[currentWorkflow]!
        for rule in workflow.rules {
            switch rule.operator {
            case .greaterThan:
                var acceptedRatings = currentRatings
                acceptedRatings[rule.rating]!.remove(integersIn: 1...rule.value)
                total += acceptedCombinations(workflows: workflows, currentWorkflow: rule.destination, currentRatings: acceptedRatings)
                currentRatings[rule.rating]!.remove(integersIn: (rule.value + 1)...4000)
            case .lessThan:
                var acceptedRatings = currentRatings
                acceptedRatings[rule.rating]!.remove(integersIn: rule.value...4000)
                total += acceptedCombinations(workflows: workflows, currentWorkflow: rule.destination, currentRatings: acceptedRatings)
                currentRatings[rule.rating]!.remove(integersIn: 1..<rule.value)
            }
        }

        return total + acceptedCombinations(workflows: workflows, currentWorkflow: workflow.fallback, currentRatings: currentRatings)
    }

    // MARK: - Parsing

    func parseWorkflows() -> [String: Workflow] {
        let workflowRegex = #/^([a-z]+)\{(.*),([a-zA-Z]+)\}$/#
        let ruleRegex = #/^([a-z]+)(>|<)([0-9]+)\:([a-zA-Z]+)$/#

        return input().components(separatedBy: "\n\n")[0].components(separatedBy: .newlines).map { line in
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
    }

    func parseParts() -> [Part] {
        input().components(separatedBy: "\n\n")[1].components(separatedBy: .newlines).map { line in
            let ratings: [String: Int] = line.trimmingCharacters(in: CharacterSet(charactersIn: "{}"))
                .components(separatedBy: ",")
                .reduce(into: [:]) { partialResult, string in
                    let components = string.components(separatedBy: "=")
                    partialResult[components[0]] = Int(components[1])!
                }
            return Part(ratings: ratings)
        }
    }
}
