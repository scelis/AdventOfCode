import Foundation
import Testing
@testable import AOC2015

@Suite struct AOC2015Tests {
    @Test func day01() async throws {
        let day = Day01()
        let parts = try await day.run(input: loadInput(forResource: "2015-01"))
        #expect(parts.0 == 138)
        #expect(parts.1 == 1771)
    }

    @Test func day02() async throws {
        let day = Day02()
        let parts = try await day.run(input: loadInput(forResource: "2015-02"))
        #expect(parts.0 == 1606483)
        #expect(parts.1 == 3842356)
    }

    @Test func day03() async throws {
        let day = Day03()
        let parts = try await day.run(input: loadInput(forResource: "2015-03"))
        #expect(parts.0 == 2081)
        #expect(parts.1 == 2341)
    }

    @Test func day04() async throws {
        let day = Day04()
        let parts = try await day.run(input: loadInput(forResource: "2015-04"))
        #expect(parts.0 == 282749)
        #expect(parts.1 == 9962624)
    }

    @Test func day05() async throws {
        let day = Day05()
        let parts = try await day.run(input: loadInput(forResource: "2015-05"))
        #expect(parts.0 == 236)
        #expect(parts.1 == 51)
    }

    @Test func day06() async throws {
        let day = Day06()
        let parts = try await day.run(input: loadInput(forResource: "2015-06"))
        #expect(parts.0 == 377891)
        #expect(parts.1 == 14110788)
    }

    @Test func day07() async throws {
        let day = Day07()
        let parts = try await day.run(input: loadInput(forResource: "2015-07"))
        #expect(parts.0 == 956)
        #expect(parts.1 == 40149)
    }

    @Test func day08() async throws {
        let day = Day08()
        let parts = try await day.run(input: loadInput(forResource: "2015-08"))
        #expect(parts.0 == 1350)
        #expect(parts.1 == 2085)
    }

    @Test func day09() async throws {
        let day = Day09()
        let parts = try await day.run(input: loadInput(forResource: "2015-09"))
        #expect(parts.0 == 141)
        #expect(parts.1 == 736)
    }

    @Test func day10() async throws {
        let day = Day10()
        let parts = try await day.run(input: loadInput(forResource: "2015-10"))
        #expect(parts.0 == 360154)
        #expect(parts.1 == 5103798)
    }

    @Test func day11() async throws {
        let day = Day11()
        let parts = try await day.run(input: loadInput(forResource: "2015-11"))
        #expect(parts.0 == "vzbxxyzz")
        #expect(parts.1 == "vzcaabcc")
    }

    @Test func day12() async throws {
        let day = Day12()
        let parts = try await day.run(input: loadInput(forResource: "2015-12"))
        #expect(parts.0 == 191164)
        #expect(parts.1 == 87842)
    }

    @Test func day13() async throws {
        let day = Day13()
        let parts = try await day.run(input: loadInput(forResource: "2015-13"))
        #expect(parts.0 == 664)
        #expect(parts.1 == 640)
    }

    @Test func day14() async throws {
        let day = Day14()
        let parts = try await day.run(input: loadInput(forResource: "2015-14"))
        #expect(parts.0 == 2696)
        #expect(parts.1 == 1084)
    }

    @Test func day15() async throws {
        let day = Day15()
        let parts = try await day.run(input: loadInput(forResource: "2015-15"))
        #expect(parts.0 == 21367368)
        #expect(parts.1 == 1766400)
    }

    @Test func day16() async throws {
        let day = Day16()
        let parts = try await day.run(input: loadInput(forResource: "2015-16"))
        #expect(parts.0 == 103)
        #expect(parts.1 == 405)
    }

    private func loadInput(forResource: String, withExtension: String = "txt") -> String {
        let url = Bundle.module.url(forResource: forResource, withExtension: withExtension, subdirectory: "Resources")
        let data = try! Data(contentsOf: url!)
        let str = String(data: data, encoding: .utf8)!
        return str.trimmingCharacters(in: .newlines)
    }
}
