import Foundation
import Testing
@testable import AOC2020

@Suite struct AOC2020Tests {
    @Test func day01() async throws {
        let day = Day01()
        let parts = try await day.run(input: loadInput(forResource: "2020-01"))
        #expect(parts.0 == 840324)
        #expect(parts.1 == 170098110)
    }

    @Test func day02() async throws {
        let day = Day02()
        let parts = try await day.run(input: loadInput(forResource: "2020-02"))
        #expect(parts.0 == 638)
        #expect(parts.1 == 699)
    }

    @Test func day03() async throws {
        let day = Day03()
        let parts = try await day.run(input: loadInput(forResource: "2020-03"))
        #expect(parts.0 == 198)
        #expect(parts.1 == 5140884672)
    }

    @Test func day04() async throws {
        let day = Day04()
        let parts = try await day.run(input: loadInput(forResource: "2020-04"))
        #expect(parts.0 == 202)
        #expect(parts.1 == 137)
    }

    @Test func day05() async throws {
        let day = Day05()
        let parts = try await day.run(input: loadInput(forResource: "2020-05"))
        #expect(parts.0 == 850)
        #expect(parts.1 == 599)
    }

    @Test func day06() async throws {
        let day = Day06()
        let parts = try await day.run(input: loadInput(forResource: "2020-06"))
        #expect(parts.0 == 6596)
        #expect(parts.1 == 3219)
    }

    @Test func day07() async throws {
        let day = Day07()
        let parts = try await day.run(input: loadInput(forResource: "2020-07"))
        #expect(parts.0 == 161)
        #expect(parts.1 == 30899)
    }

    @Test func day08() async throws {
        let day = Day08()
        let parts = try await day.run(input: loadInput(forResource: "2020-08"))
        #expect(parts.0 == 1337)
        #expect(parts.1 == 1358)
    }

    @Test func day09() async throws {
        let day = Day09()
        let parts = try await day.run(input: loadInput(forResource: "2020-09"))
        #expect(parts.0 == 26796446)
        #expect(parts.1 == 3353494)
    }

    @Test func day10() async throws {
        let day = Day10()
        let parts = try await day.run(input: loadInput(forResource: "2020-10"))
        #expect(parts.0 == 2100)
        #expect(parts.1 == 16198260678656)
    }

    @Test func day11() async throws {
        let day = Day11()
        let parts = try await day.run(input: loadInput(forResource: "2020-11"))
        #expect(parts.0 == 2483)
        #expect(parts.1 == 2285)
    }

    @Test func day12() async throws {
        let day = Day12()
        let parts = try await day.run(input: loadInput(forResource: "2020-12"))
        #expect(parts.0 == 636)
        #expect(parts.1 == 26841)
    }

    @Test func day13() async throws {
        let day = Day13()
        let parts = try await day.run(input: loadInput(forResource: "2020-13"))
        #expect(parts.0 == 153)
        #expect(parts.1 == 471793476184394)
    }

    @Test func day14() async throws {
        let day = Day14()
        let parts = try await day.run(input: loadInput(forResource: "2020-14"))
        #expect(parts.0 == 10050490168421)
        #expect(parts.1 == 2173858456958)
    }

    @Test func day15() async throws {
        let day = Day15()
        let parts = try await day.run(input: loadInput(forResource: "2020-15"))
        #expect(parts.0 == 614)
        #expect(parts.1 == 1065)
    }

    @Test func day16() async throws {
        let day = Day16()
        let parts = try await day.run(input: loadInput(forResource: "2020-16"))
        #expect(parts.0 == 25972)
        #expect(parts.1 == 622670335901)
    }

    private func loadInput(forResource: String, withExtension: String = "txt") -> String {
        let url = Bundle.module.url(forResource: forResource, withExtension: withExtension, subdirectory: "Resources")
        let data = try! Data(contentsOf: url!)
        let str = String(data: data, encoding: .utf8)!
        return str.trimmingCharacters(in: .newlines)
    }
}
