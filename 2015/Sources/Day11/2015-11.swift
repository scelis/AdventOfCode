import AdventKit2
import Foundation

struct Day11: Day {

    func run() async throws -> (String, String) {
        let input = Array(input())
        let part1 = nextValidPassword(after: input)
        let part2 = nextValidPassword(after: part1)
        return (String(part1), String(part2))
    }

    func nextValidPassword(after: [Character]) -> [Character] {
        var password = increment(password: after)
        while !isValid(password: password) {
            password = increment(password: password)
        }
        return password
    }

    func increment(password: [Character]) -> [Character] {
        var password = password

        var i = password.count - 1
        while password[i] == "z" {
            password[i] = "a"
            i -= 1
        }

        password[i] = Character(UnicodeScalar(password[i].asciiValue! + 1))
        if password[i] == "i" {
            password[i] = "j"
        } else if password[i] == "o" {
            password[i] = "p"
        } else if password[i] == "l" {
            password[i] = "m"
        }

        return password
    }

    func isValid(password: [Character]) -> Bool {
        var pairs: Set<Character> = []
        var foundStraight = false

        for i in 0..<password.count - 1 {
            if
                i < password.count - 1,
                password[i] == password[i + 1]
            {
                pairs.insert(password[i])
            }

            if
                i < password.count - 2,
                password[i].asciiValue! == password[i + 1].asciiValue! - 1,
                password[i].asciiValue! == password[i + 2].asciiValue! - 2
            {
                foundStraight = true
            }
        }

        return pairs.count >= 2 && foundStraight
    }
}
