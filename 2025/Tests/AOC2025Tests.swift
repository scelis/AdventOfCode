import Foundation
import Testing
@testable import AOC2025

@Suite struct AOC2025Tests {
    @Test func day01() async throws {
        let day = Day01()
        let parts = try await day.run()
        #expect(parts.0 == 1052)
        #expect(parts.1 == 6295)
    }

    @Test func day02() async throws {
        let day = Day02()
        let parts = try await day.run()
        #expect(parts.0 == 15873079081)
        #expect(parts.1 == 22617871034)
    }

    @Test func day03() async throws {
        let day = Day03()
        let parts = try await day.run()
        #expect(parts.0 == 17332)
        #expect(parts.1 == 172516781546707)
    }

    @Test func day04() async throws {
        let day = Day04()
        let parts = try await day.run()
        #expect(parts.0 == 1389)
        #expect(parts.1 == 9000)
    }

    @Test func day05() async throws {
        let day = Day05()
        let parts = try await day.run()
        #expect(parts.0 == 567)
        #expect(parts.1 == 354149806372909)
    }
    
    @Test func day06() async throws {
        let day = Day06()
        let parts = try await day.run()
        #expect(parts.0 == 5733696195703)
        #expect(parts.1 == 10951882745757)
    }

    @Test func day07() async throws {
        let day = Day07()
        let parts = try await day.run()
        #expect(parts.0 == 1628)
        #expect(parts.1 == 27055852018812)
    }
}
