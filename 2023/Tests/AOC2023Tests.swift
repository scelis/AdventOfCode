import Foundation
import Testing
@testable import AOC2023

@Suite struct AOC2024Tests {
    @Test func day01() async throws {
        let day = Day01()
        let parts = try await day.run()
        #expect(parts.0 == 54951)
        #expect(parts.1 == 55218)
    }

    @Test func day02() async throws {
        let day = Day02()
        let parts = try await day.run()
        #expect(parts.0 == 1931)
        #expect(parts.1 == 83105)
    }

    @Test func day03() async throws {
        let day = Day03()
        let parts = try await day.run()
        #expect(parts.0 == 531561)
        #expect(parts.1 == 83279367)
    }

    @Test func day04() async throws {
        let day = Day04()
        let parts = try await day.run()
        #expect(parts.0 == 24175)
        #expect(parts.1 == 18846301)
    }

    @Test func day05() async throws {
        let day = Day05()
        let parts = try await day.run()
        #expect(parts.0 == 282277027)
        #expect(parts.1 == 11554135)
    }

    @Test func day06() async throws {
        let day = Day06()
        let parts = try await day.run()
        #expect(parts.0 == 2612736)
        #expect(parts.1 == 29891250)
    }

    @Test func day07() async throws {
        let day = Day07()
        let parts = try await day.run()
        #expect(parts.0 == 250602641)
        #expect(parts.1 == 251037509)
    }

    @Test func day08() async throws {
        let day = Day08()
        let parts = try await day.run()
        #expect(parts.0 == 16897)
        #expect(parts.1 == 16563603485021)
    }

    @Test func day09() async throws {
        let day = Day09()
        let parts = try await day.run()
        #expect(parts.0 == 1992273652)
        #expect(parts.1 == 1012)
    }

    @Test func day10() async throws {
        let day = Day10()
        let parts = try await day.run()
        #expect(parts.0 == 6717)
        #expect(parts.1 == 381)
    }

    @Test func day11() async throws {
        let day = Day11()
        let parts = try await day.run()
        #expect(parts.0 == 9974721)
        #expect(parts.1 == 702770569197)
    }

    @Test func day12() async throws {
        let day = Day12()
        let parts = try await day.run()
        #expect(parts.0 == 7260)
        #expect(parts.1 == 1909291258644)
    }

    @Test func day13() async throws {
        let day = Day13()
        let parts = try await day.run()
        #expect(parts.0 == 36015)
        #expect(parts.1 == 35335)
    }

    @Test func day14() async throws {
        let day = Day14()
        let parts = try await day.run()
        #expect(parts.0 == 106997)
        #expect(parts.1 == 99641)
    }

    @Test func day15() async throws {
        let day = Day15()
        let parts = try await day.run()
        #expect(parts.0 == 508498)
        #expect(parts.1 == 279116)
    }

    @Test func day16() async throws {
        let day = Day16()
        let parts = try await day.run()
        #expect(parts.0 == 7632)
        #expect(parts.1 == 8023)
    }

    @Test func day17() async throws {
        let day = Day17()
        let parts = try await day.run()
        #expect(parts.0 == 1044)
        #expect(parts.1 == 1227)
    }

    @Test func day18() async throws {
        let day = Day18()
        let parts = try await day.run()
        #expect(parts.0 == 48652)
        #expect(parts.1 == 45757884535661)
    }

    @Test func day19() async throws {
        let day = Day19()
        let parts = try await day.run()
        #expect(parts.0 == 409898)
        #expect(parts.1 == 113057405770956)
    }

    @Test func day20() async throws {
        let day = Day20()
        let parts = try await day.run()
        #expect(parts.0 == 944750144)
        #expect(parts.1 == 222718819437131)
    }

    @Test func day21() async throws {
        let day = Day21()
        let parts = try await day.run()
        #expect(parts.0 == 3729)
    }
}
