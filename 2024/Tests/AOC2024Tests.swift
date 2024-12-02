import Foundation
import XCTest
@testable import AOC2024

class AOC2024Tests: XCTestCase {
    func testDay01() async throws {
        let day = Day01()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 3508942)
        XCTAssertEqual(parts.1, 26593248)
    }

    func testDay02() async throws {
        let day = Day02()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 287)
        XCTAssertEqual(parts.1, 354)
    }
}
