import AdventKit
import Foundation

struct Day15: Day {

    // MARK: - Structures

    struct Lens: Equatable {
        var label: String
        var focalLength: Int
    }

    // MARK: - Solving

    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        input()
            .components(separatedBy: ",")
            .map { hash($0) }
            .reduce(0, +)
    }

    func part2() async throws -> Int {
        var boxes: [Int: [Lens]] = [:]

        input()
            .components(separatedBy: ",")
            .forEach { string in
                if string.hasSuffix("-") {
                    let label = String(string.dropLast())
                    let boxNumber = hash(label)
                    if let lenses = boxes[boxNumber] {
                        boxes[boxNumber] = lenses.filter { $0.label != label }
                    }
                } else {
                    let components = string.components(separatedBy: "=")
                    let label = components[0]
                    let focalLength = Int(components[1])!
                    let lens = Lens(label: label, focalLength: focalLength)
                    let boxNumber = hash(label)
                    var lenses = boxes[boxNumber, default: []]
                    if let index = lenses.firstIndex(where: { $0.label == label }) {
                        lenses[index] = lens
                    } else {
                        lenses.append(lens)
                    }
                    boxes[boxNumber] = lenses
                }
            }

        var focusingPower = 0
        for (box, lenses) in boxes {
            lenses.enumerated().forEach { index, lens in
                focusingPower += (box + 1) * (index + 1) * lens.focalLength
            }
        }

        return focusingPower
    }

    func hash(_ string: String) -> Int {
        string.reduce(0) { (($0 + Int($1.asciiValue!)) * 17) % 256 }
    }
}
