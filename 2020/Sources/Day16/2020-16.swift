import AdventKit
import Algorithms
import Foundation

let fieldsInput = """
departure location: 44-709 or 728-964
departure station: 42-259 or 269-974
departure platform: 39-690 or 701-954
departure track: 49-909 or 924-965
departure date: 48-759 or 779-957
departure time: 38-115 or 121-965
arrival location: 32-808 or 818-949
arrival station: 45-418 or 439-949
arrival platform: 35-877 or 894-962
arrival track: 26-866 or 872-958
class: 32-727 or 736-969
duration: 35-446 or 460-968
price: 26-545 or 571-961
route: 35-207 or 223-960
row: 43-156 or 165-955
seat: 26-172 or 181-966
train: 49-582 or 606-952
type: 36-279 or 303-968
wagon: 26-657 or 672-959
zone: 36-621 or 637-963
"""

public struct Day16: Day {
    static let ticket = [83,127,131,137,113,73,139,101,67,53,107,103,59,149,109,61,79,71,97,89]

    static let regex = try! NSRegularExpression(
        pattern: #"^(.+): ([0-9]+)-([0-9]+) or ([0-9]+)-([0-9]+)$"#,
        options: [.anchorsMatchLines]
    )

    static var fields: [String: IndexSet] = {
        var dict: [String: IndexSet] = [:]
        try! fieldsInput.enumerateMatches(withRegularExpression: regex) { match in
            let a = Int(match[2])!
            let b = Int(match[3])!
            let c = Int(match[4])!
            let d = Int(match[5])!
            dict[match[1]] = IndexSet(a...b).union(IndexSet(c...d))
        }
        return dict
    }()

    struct ScanTicketsResult {
        var potentialTickets: [[Int]]
        var errorRate: Int
    }

    func scanTickets() -> ScanTicketsResult {
        var allValidRanges = IndexSet()
        for indexSet in Self.fields.values {
            allValidRanges = allValidRanges.union(indexSet)
        }

        var errorRate = 0
        var potentialTickets: [[Int]] = []
        for ticket in inputLines().map({ $0.components(separatedBy: ",").map({ Int($0)! }) }) {
            var isValid = true

            for field in ticket {
                if !allValidRanges.contains(field) {
                    isValid = false
                    errorRate += field
                }
            }

            if isValid {
                potentialTickets.append(ticket)
            }
        }

        return ScanTicketsResult(potentialTickets: potentialTickets, errorRate: errorRate)
    }

    public func part1() async throws -> Int {
        scanTickets().errorRate
    }

    public func part2() async throws -> Int {
        var actualFields: [Set<String>] = .init(repeating: Set(Array(Self.fields.keys)), count: Self.fields.count)
        let scanTicketsResult = scanTickets()

        while true {
            for i in 0..<Self.ticket.count {
                var potentialFields = actualFields[i]

                fields: for field in actualFields[i] {
                tickets: for ticket in scanTicketsResult.potentialTickets {
                        let value = ticket[i]
                    let indexSet = Self.fields[field]!
                        if !indexSet.contains(value) {
                            potentialFields.remove(field)
                            continue fields
                        }
                    }
                }

                actualFields[i] = potentialFields

                if potentialFields.count == 1 {
                    for j in 0..<actualFields.count {
                        if j != i {
                            var updated = actualFields[j]
                            updated.remove(potentialFields.first!)
                            actualFields[j] = updated
                        }
                    }
                }
            }

            var finished = true
            for fields in actualFields {
                if fields.count > 1 {
                    finished = false
                }
            }

            if finished {
                var ret = 1
                for i in 0..<Self.ticket.count {
                    if actualFields[i].first!.starts(with: "departure") {
                        ret *= Self.ticket[i]
                    }
                }
                return ret
            }
        }
    }
}
