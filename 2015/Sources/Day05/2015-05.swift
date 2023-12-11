import AdventKit
import Algorithms
import Foundation

public class Day05: Day<Int, Int> {
    public override func part1() throws -> Int {
        let naughtySegments: Set<String> = ["ab", "cd", "pq", "xy"]
        let vowels: Set<Character> = Set("aeiou")

        func isNice(_ string: String) -> Bool {
            var numVowels = 0
            var hasDoubleLetter = false
            var previousCharacter: Character?
            for character in string {
                if vowels.contains(character) {
                    numVowels += 1
                }

                if let previousCharacter {
                    if previousCharacter == character {
                        hasDoubleLetter = true
                    }

                    let segment = String(previousCharacter) + String(character)
                    if naughtySegments.contains(segment) {
                        return false
                    }
                }

                previousCharacter = character
            }

            return numVowels >= 3 && hasDoubleLetter
        }

        return inputLines
            .filter { isNice($0) }
            .count
    }

    public override func part2() throws -> Int {
        func isNice(_ string: String) -> Bool {
            let characters = Array(string)
            var pairs: Set<String> = []
            var hasTwoPair = false
            var hasSandwich = false
            for i in 0..<characters.count {
                let character = characters[i]
                if let nextCharacter = characters[safe: i + 1] {
                    let upcomingPair = String(character) + String(nextCharacter)
                    if pairs.contains(upcomingPair) {
                        hasTwoPair = true
                    }
                }
                if let previousCharacter = characters[safe: i - 1] {
                    let pair = String(previousCharacter) + String(character)
                    pairs.insert(pair)
                }
                if
                    let previousCharacter = characters[safe: i - 1],
                    let nextCharacter = characters[safe: i + 1],
                    previousCharacter == nextCharacter
                {
                    hasSandwich = true
                }
            }

            return hasTwoPair && hasSandwich
        }

        return inputLines
            .filter { isNice($0) }
            .count
    }
}
