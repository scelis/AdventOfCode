import Foundation
import Testing
@testable import AOC2025

@Suite struct AOC2025Tests {
    @Test func day01() async throws {
        let day = Day01()
        let parts = try await day.run()
        #expect(parts.0 == 0)
        #expect(parts.1 == 0)
    }
}
