import AdventKit
import Foundation

struct Day10: Day {
    private let pairs: [Character: Character] = ["(": ")", "[": "]", "{": "}", "<": ">"]
    private let reversePairs: [Character: Character] = [")": "(", "]": "[", "}": "{", ">": "<"]

    func run() async throws -> (Int, Int) {
        async let p1 = part1()
        async let p2 = part2()
        return try await (p1, p2)
    }

    func part1() async throws -> Int {
        let values: [Character: Int] = [")": 3, "]": 57, "}": 1197, ">": 25137]

        return input()
            .components(separatedBy: .newlines)
            .compactMap { line -> Int? in
                var stack: [Character] = []
                for character in line {
                    if pairs.keys.contains(character) {
                        stack.append(character)
                    } else if pairs.values.contains(character) {
                        if stack.last == reversePairs[character] {
                            stack.removeLast()
                        } else {
                            return values[character]
                        }
                    } else {
                        fatalError()
                    }
                }

                return nil
            }
            .reduce(0, +)
    }

    func part2() async throws -> Int {
        let values: [Character: Int] = [")": 1, "]": 2, "}": 3, ">": 4]

        let elements = input()
            .components(separatedBy: .newlines)
            .compactMap { line -> Int? in
                var stack: [Character] = []

                for character in line {
                    if pairs.keys.contains(character) {
                        stack.append(character)
                    } else if pairs.values.contains(character) {
                        if stack.last == reversePairs[character] {
                            stack.removeLast()
                        } else {
                            return nil
                        }
                    } else {
                        fatalError()
                    }
                }

                return stack.reversed().reduce(0) { partialResult, character in
                    return partialResult * 5 + values[pairs[character]!]!
                }
            }
            .sorted(by: <)

        return elements[elements.count / 2]
    }
}
