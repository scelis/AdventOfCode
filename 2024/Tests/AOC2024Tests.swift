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

    func testDay03() async throws {
        let day = Day03()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 175015740)
        XCTAssertEqual(parts.1, 112272912)
    }

    func testDay04() async throws {
        let day = Day04()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 2496)
        XCTAssertEqual(parts.1, 1967)
    }

    func testDay05() async throws {
        let day = Day05()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 6034)
        XCTAssertEqual(parts.1, 6305)
    }
}
