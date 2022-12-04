import AdventKit
import Foundation

class Day04: Day {
    enum Field: String, CaseIterable {
        case birthYear = "byr"
        case issueYear = "iyr"
        case expirationYear = "eyr"
        case height = "hgt"
        case hairColor = "hcl"
        case eyeColor = "ecl"
        case passportID = "pid"
        case countryID = "cid"

        func isValid(value: String?, strict: Bool) -> Bool {
            guard let value = value else { return self == .countryID }
            guard strict else { return true }

            switch self {
            case .countryID:
                return true
            case .birthYear:
                return (1920...2002).contains(Int(value) ?? 0)
            case .issueYear:
                return (2010...2020).contains(Int(value) ?? 0)
            case .expirationYear:
                return (2020...2030).contains(Int(value) ?? 0)
            case .height:
                var value = value
                if value.hasSuffix("cm") {
                    value.removeLast(2)
                    return (150...193).contains(Int(value) ?? 0)
                } else if value.hasSuffix("in") {
                    value.removeLast(2)
                    return (59...76).contains(Int(value) ?? 0)
                } else {
                    return false
                }
            case .hairColor:
                return value.range(of: "^#[0-9a-f]{6}$", options: .regularExpression) != nil
            case .eyeColor:
                return ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].contains(value)
            case .passportID:
                return value.range(of: "^[0-9]{9}$", options: .regularExpression) != nil
            }
        }
    }

    func numberOfValidPassports(strict: Bool) -> Int {
        var numValid = 0
        var current: [Field: String] = [:]
        for line in inputLines {
            if line.isEmpty {
                if isValid(passport: current, strict: strict) {
                    numValid += 1
                }
                current = [:]
            } else {
                for field in line.components(separatedBy: .whitespaces) {
                    let pair = field.components(separatedBy: ":")
                    current[Field(rawValue: pair[0])!] = pair[1]
                }
            }
        }
        if isValid(passport: current, strict: strict) {
            numValid += 1
        }
        return numValid
    }

    func isValid(passport: [Field: String], strict: Bool) -> Bool {
        for field in Field.allCases {
            if !field.isValid(value: passport[field], strict: strict) {
                return false
            }
        }
        return true
    }

    override func part1() -> Any {
        return numberOfValidPassports(strict: false).description
    }

    override func part2() -> Any {
        return numberOfValidPassports(strict: true).description
    }
}

Day04().run()
