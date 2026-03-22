import Foundation
import Testing
@testable import AOC2021

@Suite struct AOC2021Tests {
    @Test func day01() async throws {
        let day = Day01()
        let parts = try await day.run(input: loadInput(forResource: "2021-01"))
        #expect(parts.0 == 1446)
        #expect(parts.1 == 1486)
    }

    @Test func day02() async throws {
        let day = Day02()
        let parts = try await day.run(input: loadInput(forResource: "2021-02"))
        #expect(parts.0 == 1250395)
        #expect(parts.1 == 1451210346)
    }

    @Test func day03() async throws {
        let day = Day03()
        let parts = try await day.run(input: loadInput(forResource: "2021-03"))
        #expect(parts.0 == 2583164)
        #expect(parts.1 == 2784375)
    }

    @Test func day04() async throws {
        let day = Day04()
        let parts = try await day.run(input: loadInput(forResource: "2021-04"))
        #expect(parts.0 == 34506)
        #expect(parts.1 == 7686)
    }

    @Test func day05() async throws {
        let day = Day05()
        let parts = try await day.run(input: loadInput(forResource: "2021-05"))
        #expect(parts.0 == 6225)
        #expect(parts.1 == 22116)
    }

    @Test func day06() async throws {
        let day = Day06()
        let parts = try await day.run(input: loadInput(forResource: "2021-06"))
        #expect(parts.0 == 380758)
        #expect(parts.1 == 1710623015163)
    }

    @Test func day07() async throws {
        let day = Day07()
        let parts = try await day.run(input: loadInput(forResource: "2021-07"))
        #expect(parts.0 == 331067)
        #expect(parts.1 == 92881128)
    }

    @Test func day08() async throws {
        let day = Day08()
        let parts = try await day.run(input: loadInput(forResource: "2021-08"))
        #expect(parts.0 == 512)
        #expect(parts.1 == 1091165)
    }

    @Test func day09() async throws {
        let day = Day09()
        let parts = try await day.run(input: loadInput(forResource: "2021-09"))
        #expect(parts.0 == 564)
        #expect(parts.1 == 1038240)
    }

    @Test func day10() async throws {
        let day = Day10()
        let parts = try await day.run(input: loadInput(forResource: "2021-10"))
        #expect(parts.0 == 318099)
        #expect(parts.1 == 2389738699)
    }

    private func loadInput(forResource: String, withExtension: String = "txt") -> String {
        let url = Bundle.module.url(forResource: forResource, withExtension: withExtension, subdirectory: "Resources")
        let data = try! Data(contentsOf: url!)
        let str = String(data: data, encoding: .utf8)!
        return str.trimmingCharacters(in: .newlines)
    }
}
