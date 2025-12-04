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
}
