import Foundation
import Testing
@testable import AOC2022

@Suite struct AOC2022Tests {
    @Test func day01() async throws {
        let day = Day01()
        let parts = try await day.run(input: loadInput(forResource: "2022-01"))
        #expect(parts.0 == 71934)
        #expect(parts.1 == 211447)
    }

    @Test func day02() async throws {
        let day = Day02()
        let parts = try await day.run(input: loadInput(forResource: "2022-02"))
        #expect(parts.0 == 12855)
        #expect(parts.1 == 13726)
    }

    @Test func day03() async throws {
        let day = Day03()
        let parts = try await day.run(input: loadInput(forResource: "2022-03"))
        #expect(parts.0 == 7908)
        #expect(parts.1 == 2838)
    }

    @Test func day04() async throws {
        let day = Day04()
        let parts = try await day.run(input: loadInput(forResource: "2022-04"))
        #expect(parts.0 == 483)
        #expect(parts.1 == 874)
    }

    @Test func day05() async throws {
        let day = Day05()
        let parts = try await day.run(input: loadInput(forResource: "2022-05"))
        #expect(parts.0 == "RTGWZTHLD")
        #expect(parts.1 == "STHGRZZFR")
    }

    @Test func day06() async throws {
        let day = Day06()
        let parts = try await day.run(input: loadInput(forResource: "2022-06"))
        #expect(parts.0 == 1640)
        #expect(parts.1 == 3613)
    }

    @Test func day07() async throws {
        let day = Day07()
        let parts = try await day.run(input: loadInput(forResource: "2022-07"))
        #expect(parts.0 == 1141028)
        #expect(parts.1 == 8278005)
    }

    @Test func day08() async throws {
        let day = Day08()
        let parts = try await day.run(input: loadInput(forResource: "2022-08"))
        #expect(parts.0 == 1814)
        #expect(parts.1 == 330786)
    }

    @Test func day09() async throws {
        let day = Day09()
        let parts = try await day.run(input: loadInput(forResource: "2022-09"))
        #expect(parts.0 == 6026)
        #expect(parts.1 == 2273)
    }

    @Test func day10() async throws {
        let day = Day10()
        let parts = try await day.run(input: loadInput(forResource: "2022-10"))
        #expect(parts.0 == 13740)
        #expect(parts.1.trimmingCharacters(in: .newlines) == """
####.#..#.###..###..####.####..##..#....
...#.#..#.#..#.#..#.#....#....#..#.#....
..#..#..#.#..#.#..#.###..###..#....#....
.#...#..#.###..###..#....#....#....#....
#....#..#.#....#.#..#....#....#..#.#....
####..##..#....#..#.#....####..##..####.
""")
    }

    @Test func day11() async throws {
        let day = Day11()
        let parts = try await day.run(input: loadInput(forResource: "2022-11"))
        #expect(parts.0 == 67830)
        #expect(parts.1 == 15305381442)
    }

    @Test func day12() async throws {
        let day = Day12()
        let parts = try await day.run(input: loadInput(forResource: "2022-12"))
        #expect(parts.0 == 472)
        #expect(parts.1 == 465)
    }

    @Test func day13() async throws {
        let day = Day13()
        let parts = try await day.run(input: loadInput(forResource: "2022-13"))
        #expect(parts.0 == 5684)
        #expect(parts.1 == 22932)
    }

    @Test func day14() async throws {
        let day = Day14()
        let parts = try await day.run(input: loadInput(forResource: "2022-14"))
        #expect(parts.0 == 1016)
        #expect(parts.1 == 25402)
    }

    @Test func day15() async throws {
        let day = Day15()
        let parts = try await day.run(input: loadInput(forResource: "2022-15"))
        #expect(parts.0 == 4951427)
        #expect(parts.1 == 13029714573243)
    }

    private func loadInput(forResource: String, withExtension: String = "txt") -> String {
        let url = Bundle.module.url(forResource: forResource, withExtension: withExtension, subdirectory: "Resources")
        let data = try! Data(contentsOf: url!)
        let str = String(data: data, encoding: .utf8)!
        return str.trimmingCharacters(in: .newlines)
    }
}
