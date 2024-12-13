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

    func testDay06() async throws {
        let day = Day06()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 5444)
        XCTAssertEqual(parts.1, 1946)
    }

    func testDay07() async throws {
        let day = Day07()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 20665830408335)
        XCTAssertEqual(parts.1, 354060705047464)
    }

    func testDay08() async throws {
        let day = Day08()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 329)
        XCTAssertEqual(parts.1, 1190)
    }

    func testDay09() async throws {
        let day = Day09()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 6291146824486)
        XCTAssertEqual(parts.1, 6307279963620)
    }

    func testDay10() async throws {
        let day = Day10()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 796)
        XCTAssertEqual(parts.1, 1942)
    }

    func testDay11() async throws {
        let day = Day11()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 199753)
        XCTAssertEqual(parts.1, 239413123020116)
    }

    func testDay12() async throws {
        let day = Day12()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 1486324)
        XCTAssertEqual(parts.1, 898684)
    }

    func testDay13() async throws {
        let day = Day13()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 26810)
        XCTAssertEqual(parts.1, 108713182988244)
    }
}
