import Foundation
import Testing
@testable import AOC2019

@Suite struct AOC2019Tests {
    @Test func day01() async throws {
        let day = Day01()
        let parts = try await day.run(input: loadInput(fileName: "2019-01.txt"))
        #expect(parts.0 == 3295206)
        #expect(parts.1 == 4939939)
    }

    @Test func day02() async throws {
        let day = Day02()
        let parts = try await day.run(input: loadInput(fileName: "2019-02.txt"))
        #expect(parts.0 == 9706670)
        #expect(parts.1 == 2552)
    }

    @Test func day03() async throws {
        let day = Day03()
        let parts = try await day.run(input: loadInput(fileName: "2019-03.txt"))
        #expect(parts.0 == 489)
        #expect(parts.1 == 93654)
    }

    @Test func day04() async throws {
        let day = Day04()
        let parts = try await day.run(input: loadInput(fileName: "2019-04.txt"))
        #expect(parts.0 == 1748)
        #expect(parts.1 == 1180)
    }

    @Test func day05() async throws {
        let day = Day05()
        let parts = try await day.run(input: loadInput(fileName: "2019-05.txt"))
        #expect(parts.0 == 7988899)
        #expect(parts.1 == 13758663)
    }

    @Test func day06() async throws {
        let day = Day06()
        let parts = try await day.run(input: loadInput(fileName: "2019-06.txt"))
        #expect(parts.0 == 162439)
        #expect(parts.1 == 367)
    }

    @Test func day07() async throws {
        let day = Day07()
        let parts = try await day.run(input: loadInput(fileName: "2019-07.txt"))
        #expect(parts.0 == 46248)
        #expect(parts.1 == 54163586)
    }

    @Test func day08() async throws {
        let day = Day08()
        let parts = try await day.run(input: loadInput(fileName: "2019-08.txt"))
        #expect(parts.0 == 1703)
        #expect(parts.1.contains("""
1001001100011001111011110
1001010010100101000010000
1111010000100001110011100
1001010000101101000010000
1001010010100101000010000
1001001100011101000011110
"""))
    }

    @Test func day09() async throws {
        let day = Day09()
        let parts = try await day.run(input: loadInput(fileName: "2019-09.txt"))
        #expect(parts.0 == 2204990589)
        #expect(parts.1 == 50008)
    }

    @Test func day10() async throws {
        let day = Day10()
        let parts = try await day.run(input: loadInput(fileName: "2019-10.txt"))
        #expect(parts.0 == 326)
        #expect(parts.1 == 1623)
    }

    @Test func day11() async throws {
        let day = Day11()
        let parts = try await day.run(input: loadInput(fileName: "2019-11.txt"))
        #expect(parts.0 == 2184)
        #expect(parts.1.contains("""
⬛️⬛️⬜️⬜️⬛️⬛️⬜️⬛️⬛️⬜️⬛️⬛️⬜️⬜️⬛️⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬜️⬜️⬜️⬛️⬜️⬜️⬜️⬜️⬛️⬜️⬜️⬜️⬛️⬛️⬜️⬛️⬛️⬜️⬛️⬛️⬛️
⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬛️⬛️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬛️⬜️⬛️⬛️⬛️⬛️
⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬜️⬜️⬜️⬛️⬜️⬛️⬛️⬛️⬛️⬜️⬜️⬜️⬜️⬛️⬛️⬛️⬜️⬛️⬛️⬜️⬜️⬜️⬛️⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬜️⬛️⬛️⬛️⬛️⬛️
⬛️⬜️⬜️⬜️⬜️⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬛️⬜️⬛️⬛️⬜️⬛️⬛️⬛️⬜️⬛️⬛️⬛️⬛️⬜️⬜️⬜️⬛️⬛️⬜️⬛️⬜️⬛️⬛️⬛️⬛️
⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬜️⬛️⬛️⬛️⬛️
⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬛️⬛️⬜️⬛️⬛️⬜️⬜️⬛️⬛️⬜️⬛️⬛️⬜️⬛️⬜️⬜️⬜️⬜️⬛️⬜️⬜️⬜️⬜️⬛️⬜️⬛️⬛️⬛️⬛️⬜️⬛️⬛️⬜️⬛️⬛️⬛️
"""))
    }

    @Test func day12() async throws {
        let day = Day12()
        let parts = try await day.run(input: loadInput(fileName: "2019-12.txt"))
        #expect(parts.0 == 10055)
        #expect(parts.1 == 374307970285176)
    }

    @Test func day13() async throws {
        let day = Day13()
        let parts = try await day.run(input: loadInput(fileName: "2019-13.txt"))
        #expect(parts.0 == 398)
        #expect(parts.1 == 19447)
    }

    @Test func day14() async throws {
        let day = Day14()
        let parts = try await day.run(input: loadInput(fileName: "2019-14.txt"))
        #expect(parts.0 == 485720)
        #expect(parts.1 == 3848998)
    }

    @Test func day15() async throws {
        let day = Day15()
        let parts = try await day.run(input: loadInput(fileName: "2019-15.txt"))
        #expect(parts.0 == 262)
        #expect(parts.1 == 314)
    }

    @Test func day16() async throws {
        let day = Day16()
        let parts = try await day.run(input: loadInput(fileName: "2019-16.txt"))
        #expect(parts.0 == 52611030)
        #expect(parts.1 == 52541026)
    }

    @Test func day17() async throws {
        let day = Day17()
        let parts = try await day.run(input: loadInput(fileName: "2019-17.txt"))
        #expect(parts.0 == 4800)
        #expect(parts.1 == 982279)
    }

    private func loadInput(fileName: String) -> String {
        let parts = fileName.components(separatedBy: ".")
        let url = Bundle.module.url(forResource: parts[0], withExtension: parts[1], subdirectory: "Resources")
        let data = try! Data(contentsOf: url!)
        let str = String(data: data, encoding: .utf8)!
        return str.trimmingCharacters(in: .newlines)
    }
}
