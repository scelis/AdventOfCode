import AdventKit2
import Foundation

struct Day13: Day {
    struct Packet: Comparable {
        let value: [Any]

        init(string: String) throws {
            self.value = try JSONSerialization.jsonObject(with: string.data(using: .utf8)!) as! [Any]
        }

        static func < (lhs: Day13.Packet, rhs: Day13.Packet) -> Bool {
            return areInCorrectOrder(left: lhs.value, right: rhs.value) == true
        }

        static func == (lhs: Day13.Packet, rhs: Day13.Packet) -> Bool {
            return areInCorrectOrder(left: lhs.value, right: rhs.value) == nil
        }

        static func areInCorrectOrder(left: [Any], right: [Any]) -> Bool? {
            var left = left
            var right = right

            while true {
                if left.isEmpty && right.isEmpty {
                    return nil
                } else if left.isEmpty {
                    return true
                } else if right.isEmpty {
                    return false
                }

                if
                    let leftInt = left.first as? Int,
                    let rightInt = right.first as? Int
                {
                    if leftInt < rightInt {
                        return true
                    } else if leftInt > rightInt {
                        return false
                    }
                } else if
                    let leftArray = left.first as? [Any],
                    let rightArray = right.first as? [Any]
                {
                    if let decision = areInCorrectOrder(left: leftArray, right: rightArray) {
                        return decision
                    }
                } else if
                    let leftInt = left.first as? Int,
                    let rightArray = right.first as? [Any]
                {
                    if let decision = areInCorrectOrder(left: [leftInt], right: rightArray) {
                        return decision
                    }
                } else if
                    let leftArray = left.first as? [Any],
                    let rightInt = right.first as? Int
                {
                    if let decision = areInCorrectOrder(left: leftArray, right: [rightInt]) {
                        return decision
                    }
                } else {
                    fatalError()
                }

                left.removeFirst()
                right.removeFirst()
            }
        }

        func isMarker(ofValue markerValue: Int) -> Bool {
            if
                value.count == 1,
                let inner = value[0] as? [Any],
                inner.count == 1,
                (inner.first as? Int) == markerValue
            {
                return true
            } else {
                return false
            }
        }
    }

    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        try input()
            .components(separatedBy: "\n\n")
            .map { chunk in
                let components = chunk.components(separatedBy: "\n")
                return (try Packet(string: components[0]), try Packet(string: components[1]))
            }
            .enumerated()
            .map { index, pair -> Int in pair.0 < pair.1 ? index + 1 : 0 }
            .reduce(0, +)
    }

    func part2() async throws -> Int {
        var packets = try input()
            .components(separatedBy: "\n")
            .filter{ !$0.isEmpty }
            .map { try Packet(string: $0) }
        packets.append(try Packet(string: "[[2]]"))
        packets.append(try Packet(string: "[[6]]"))
        packets.sort(by: <)
        let index1 = packets.firstIndex { $0.isMarker(ofValue: 2) }! + 1
        let index2 = packets.firstIndex { $0.isMarker(ofValue: 6) }! + 1
        return index1 * index2
    }
}
