import Foundation
import Testing
@testable import AOC2025

@Suite struct AOC2025Tests {
    @Test func day01() async throws {
        let day = Day01()
        let parts = try await day.run(input: loadInput(fileName: "2025-01.txt"))
        #expect(parts.0 == 1052)
        #expect(parts.1 == 6295)
    }

    @Test func day02() async throws {
        let day = Day02()
        let parts = try await day.run(input: loadInput(fileName: "2025-02.txt"))
        #expect(parts.0 == 15873079081)
        #expect(parts.1 == 22617871034)
    }

    @Test func day03() async throws {
        let day = Day03()
        let parts = try await day.run(input: loadInput(fileName: "2025-03.txt"))
        #expect(parts.0 == 17332)
        #expect(parts.1 == 172516781546707)
    }

    @Test func day04() async throws {
        let day = Day04()
        let parts = try await day.run(input: loadInput(fileName: "2025-04.txt"))
        #expect(parts.0 == 1389)
        #expect(parts.1 == 9000)
    }

    @Test func day05() async throws {
        let day = Day05()
        let parts = try await day.run(input: loadInput(fileName: "2025-05.txt"))
        #expect(parts.0 == 567)
        #expect(parts.1 == 354149806372909)
    }
    
    @Test func day06() async throws {
        let day = Day06()
        let parts = try await day.run(input: loadInput(fileName: "2025-06.txt"))
        #expect(parts.0 == 5733696195703)
        #expect(parts.1 == 10951882745757)
    }

    @Test func day07() async throws {
        let day = Day07()
        let parts = try await day.run(input: loadInput(fileName: "2025-07.txt"))
        #expect(parts.0 == 1628)
        #expect(parts.1 == 27055852018812)
    }

    @Test func day08() async throws {
        let day = Day08()
        let parts = try await day.run(input: loadInput(fileName: "2025-08.txt"))
        #expect(parts.0 == 47040)
        #expect(parts.1 == 4884971896)
    }

    @Test func day09() async throws {
        let day = Day09()
        let parts = try await day.run(input: loadInput(fileName: "2025-09.txt"))
        #expect(parts.0 == 4749672288)
        #expect(parts.1 == 1479665889)
    }

    @Test func day10() async throws {
        let day = Day10()
        let parts = try await day.run(input: loadInput(fileName: "2025-10.txt"))
        #expect(parts.0 == 401)
        #expect(parts.1 == 0)
    }

    @Test func day11() async throws {
        let day = Day11()

        let sample1 = try await day.run(input: loadInput(fileName: "2025-11-sample-1.txt"))
        #expect(sample1.0 == 5)

        let sample2 = try await day.run(input: loadInput(fileName: "2025-11-sample-2.txt"))
        #expect(sample2.1 == 2)

        let real = try await day.run(input: loadInput(fileName: "2025-11.txt"))
        #expect(real.0 == 552)
        #expect(real.1 == 307608674109300)
    }

    private func loadInput(fileName: String) -> String {
        let parts = fileName.components(separatedBy: ".")
        let url = Bundle.module.url(forResource: parts[0], withExtension: parts[1], subdirectory: "Resources")
        let data = try! Data(contentsOf: url!)
        let str = String(data: data, encoding: .utf8)!
        return str.trimmingCharacters(in: .newlines)
    }
}
