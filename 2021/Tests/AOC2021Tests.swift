import Foundation
import XCTest
@testable import AOC2021

class AOC2021Tests: XCTestCase {
    func testDay01() async throws {
        let day = Day01()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 1446)
        XCTAssertEqual(parts.1, 1486)
    }

    func testDay02() async throws {
        let day = Day02()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 1250395)
        XCTAssertEqual(parts.1, 1451210346)
    }

    func testDay03() async throws {
        let day = Day03()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 2583164)
        XCTAssertEqual(parts.1, 2784375)
    }

    func testDay04() async throws {
        let day = Day04()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 34506)
        XCTAssertEqual(parts.1, 7686)
    }

    func testDay05() async throws {
        let day = Day05()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 6225)
        XCTAssertEqual(parts.1, 22116)
    }

    func testDay06() async throws {
        let day = Day06()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 380758)
        XCTAssertEqual(parts.1, 1710623015163)
    }

    func testDay07() async throws {
        let day = Day07()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 331067)
        XCTAssertEqual(parts.1, 92881128)
    }

    func testDay08() async throws {
        let day = Day08()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 512)
        XCTAssertEqual(parts.1, 1091165)
    }

    func testDay09() async throws {
        let day = Day09()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 564)
        XCTAssertEqual(parts.1, 1038240)
    }

    func testDay10() async throws {
        let day = Day10()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 318099)
        XCTAssertEqual(parts.1, 2389738699)
    }
}
