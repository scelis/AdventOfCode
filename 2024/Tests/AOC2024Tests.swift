import Foundation
import XCTest
@testable import AOC2024

class AOC2024Tests: XCTestCase {
    func testDay01() async throws {
        let day = Day01()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 1)
        XCTAssertEqual(parts.1, 2)
    }
}
