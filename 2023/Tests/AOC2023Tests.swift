import Foundation
import XCTest
@testable import AOC2023

class AOC2023Tests: XCTestCase {
    func testDay01() async throws {
        let day = Day01()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 54951)
        XCTAssertEqual(parts.1, 55218)
    }

    func testDay02() async throws {
        let day = Day02()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 1931)
        XCTAssertEqual(parts.1, 83105)
    }

    func testDay03() async throws {
        let day = Day03()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 531561)
        XCTAssertEqual(parts.1, 83279367)
    }

    func testDay04() async throws {
        let day = Day04()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 24175)
        XCTAssertEqual(parts.1, 18846301)
    }

    func testDay05() async throws {
        let day = Day05()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 282277027)
        XCTAssertEqual(parts.1, 11554135)
    }

    func testDay06() async throws {
        let day = Day06()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 2612736)
        XCTAssertEqual(parts.1, 29891250)
    }

    func testDay07() async throws {
        let day = Day07()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 250602641)
        XCTAssertEqual(parts.1, 251037509)
    }

    func testDay08() async throws {
        let day = Day08()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 16897)
        XCTAssertEqual(parts.1, 16563603485021)
    }

    func testDay09() async throws {
        let day = Day09()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 1992273652)
        XCTAssertEqual(parts.1, 1012)
    }

    func testDay10() async throws {
        let day = Day10()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 6717)
        XCTAssertEqual(parts.1, 381)
    }

    func testDay11() async throws {
        let day = Day11()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 9974721)
        XCTAssertEqual(parts.1, 702770569197)
    }

    func testDay12() async throws {
        let day = Day12()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 7260)
        XCTAssertEqual(parts.1, 1909291258644)
    }

    func testDay13() async throws {
        let day = Day13()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 36015)
        XCTAssertEqual(parts.1, 35335)
    }

    func testDay14() async throws {
        let day = Day14()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 106997)
        XCTAssertEqual(parts.1, 99641)
    }

    func testDay15() async throws {
        let day = Day15()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 508498)
        XCTAssertEqual(parts.1, 279116)
    }

    func testDay16() async throws {
        let day = Day16()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 7632)
        XCTAssertEqual(parts.1, 8023)
    }

    func testDay17() async throws {
        let day = Day17()
        let parts = try await day.run()
        XCTAssertEqual(parts.0, 1044)
        XCTAssertEqual(parts.1, 1227)
    }
}
